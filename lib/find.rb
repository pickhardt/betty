module Find
  def self.interpret(command)
    responses = []

    match = command.match(/^find\s+(me\s+)?(all\s+)?(\S+\s+)?files(\s+in\s+(\S+))?(\s+that\s+contain\s+(.+))?$/i)

    if match
      pattern = match[3] ? "\\*.#{match[3].strip}" : "\\*"
      directory = match[5] ? match[5].strip : "."
      contains = match[7] ? match[7].strip : nil

      if contains
        responses << {
          :command => "grep --include=#{ pattern } -Rn #{ contains } #{ directory }",
          :explanation => "Find files with extension that contains string."
        }
      else
        responses << {
          :command => "find #{ directory } -name #{ pattern }",
          :explanation => "Find all files with extension."
        }
      end
    end

    responses
  end
end

$executors << Find
