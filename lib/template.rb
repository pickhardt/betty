#
# This file is a template that is designed to give you a starting point for extending Betty
# Copy this file to what you want to extend Betty with.  Personally I wrote this as a precursor to 
# extending Betty to supporting git development so my first step would be
#
# cp lib/_template.rb lib/git.rb
#

module Template
  #
  # If you need unit conversions or other meta methods you'd want to locate them here at the top to be consistent with the code base
  #  See process.rb for examples or convert.rb

  #
  # You need a self.interpret method which grabs the command and deals with it
  #
  def self.interpret(command)
    responses = []

    #
    # The guts generally boil down to one or more regular expression matcher against the user's command
    #
    # Remember to use \s+ as a token delimiter and use () for grouping
    #
    if command.match(/^$/)
      search_term = $1.gsub(' ', '%20')

      #
      # Build a hash of the possible responses to the user (Note :url is a new idea that I'm floating here)
      #
      # Your typical options are :command, :say, :explanation
      #   :command represents the command you want to give the user
      #   :say is something to be said out loud
      #   :explanation is what we're teaching the user
      #   :url is an web url where more details are available
      #
      # Use Command.browser(url) as a way to open a url
      #
      responses << {
        :command => "",
        :explanation => ""
      }
    end

    #
    # Return responses
    #
    responses
  end

  #
  # The help structure
  #
  def self.help
    commands = []
    commands << {
      :category => "",
      :description => '',
      :usage => [""]
    }
    commands
  end
end

# this last line is where the magic actually happens; you need to take the executors and assign it to something that does the work
# here it is commented out since this is, well, a template
#$executors << Some Class Goes Here
