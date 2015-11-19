module Count
  COUNT_PATTERNS = [
    %r{
      ^count\s+
      (the\s+)?(total\s+)?(number\s+of\s+)?
      (?<what>words|lines|char(acter)?s?)\s+
      in\s+
      (?<where>.+)$
    }ix,

    %r{
      ^how\s+many\s+
      (?<what>words|lines|char(acter)?s?)\s+
      are\s+(there\s+)?in\s+
      (?<where>.+)$
    }ix
  ]

  CURRENT_DIRECTORY_PATTERN = %r{
    ^(this\s+)?
    (dir(ectory)?|folder|path)?$
  }x

  module_function

  # Interpret the command and return an array with result or an empty array
  def interpret(command)
    [count_stuff(command)].compact
  end

  def count_stuff(command)
    match = command.match(pattern)
    build_command_hash(match) if match
  end

  def build_command_hash(match)
    where = match[:where]
    what = what_to_count(match[:what])

    {
      command: build_command(where, what),
      explanation: build_explanation(where, what)
    }
  end

  def build_command(where, what)
    result = "find #{current_directory?(where) ? '.' : where} "
    result << "-type f -exec wc -#{extract_flag(what)} \{\} \\; | "
    result << "awk '{total += $1} END {print total}'"
  end

  def build_explanation(where, what)
    result = "Counts the total number of #{what} in "
    result << if current_directory?(where)
                'all the files in the current directory, including subdirectories.'
              else
                where
              end
  end

  def what_to_count(what)
    return 'characters' if what.downcase.start_with?('char')
    what
  end

  def extract_flag(what)
    what.chars.first
  end

  def current_directory?(where)
    where == '.' || where =~ CURRENT_DIRECTORY_PATTERN
  end

  # Join regular expressions using 'or' operator
  def pattern
    Regexp.union(COUNT_PATTERNS)
  end

  def help
    [{
      category: 'Count',
      description: '\033[34mCount\033[0m',
      usage: [
        'how many words are in this directory',
        'how many characters are in myfile.py',
        'count lines in this folder',
        '(Note that there\'re many ways to say more or less the same thing.)'
      ]
    }]
  end
end

$executors << Count
