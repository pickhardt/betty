module Meta  
  def self.interpret(command)
    responses = []
    
    if command.match(/^(what\s+)?version(\s+are\s+you)?$/)
      responses << {
        :say => $VERSION,
        :explanation => "Gets Betty's version."
      }
    end
    
    if command.match(/^whats?\s+(?:is\s+)?your\s+(website|url|github|repo)(\s+again\?)?$/) ||
       command.match(/^(website|url)$/)
      responses << {
        :say => $URL,
        :explanation => "Gets Betty's website."
      }
    end
    
    responses
  end
end

$executors << Meta
