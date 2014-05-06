module Count
  def self.count_stuff(command)
    match = command.match(/^count\s+(?:the\s+)?(?:total\s+)?(?:number\s+of\s+)?(words?|lines?|char(?:acter)?s?)\s+in\s+(.+)$/i) ||
            command.match(/^how\s+many\s+(words?|lines?|char(?:acter)?s?)\s+are(?:\s+there)?\s+in\s+(.+)$/i)
    
    if match
      what = match[1].strip.downcase
      where = match[2].strip
      is_this_directory = where == '.' || where.downcase.match(/^(this\s+)?(?:dir(?:ectory)|folder|path)?$/)
      
      flag = nil
      if what == "word" || what == "words"
        what = "words"
        flag = "w"
      elsif what == "line" || what == "lines"
        what = "lines"
        flag = "l"
      elsif ["char", "chars", "character", "characters"].include?(what)
        what = "characters"
        flag = "c"
      end
      
      {
        :command => "find #{ is_this_directory ? '.' : where } -type f -exec wc -#{ flag } \{\} \\; | awk '{total += $1} END {print total}'",
        :explanation => "Counts the total number of #{ what } in #{ is_this_directory ? 'all the files in the current directory, including subdirectories' : where }."
      }
    end
  end
  
  def self.interpret(command)
    responses = []
    
    count_stuff_command = self.count_stuff(command)
    responses << count_stuff_command if count_stuff_command
    
    responses
  end
end

$executors << Count
