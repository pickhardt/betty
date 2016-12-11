require './lib/simple_matcher'


class Find < Token
  concepts(
    find: {
      token_class: SimpleMatcher,
      regex: /^find\s+(?:me\s+)?(?:all\s+)?/i
    },
    extensions: {
      token_class: SimpleMatcher,
      regex: /^(\S+\s+)?/i
    },
    files: {
      token_class: SimpleMatcher,
      regex: /^files/i
    },
    directory: {
      token_class: SimpleMatcher,
      regex: /(?:\s+in\s+(\S+))?/i,
      default: '.'
    },
    search_text: {
      token_class: SimpleMatcher,
      regex: /(?:\s+that\s+contain\s+(.+))?$/i,
      question: 'What do you want to search for?'
    }
  )

  definition :find, :extensions, :files, :directory, :search_text

  def call
    extensions = extensions.call
    search_text = search_text.call
    directory = directory.call
    {
      command: "grep --include=#{ extensions } -Rn #{ search_text } #{ directory }",
      explanation: "Find files in #{ directory } with extension "\
                   "#{ extensions } that contain '#{ search_text }'."
    }
  end

  def self.help
    commands = []
    commands << {
      :category => "Find",
      :description => '\033[34mFind\033[0m files',
      :usage => ["betty find me all files that contain california",
      "betty find all rb files in ./lib/",
      "betty find all txt files"]
    }
    commands
  end
end

$executors << Find
