module Google
	def self.interpret(command)
		responses = []

		matches = command.match(/^search\sin\sgoogle\sby\s+(.+)$/) || command.match(/^google\sby\s+(.+)$/)

		if matches
			search_term = matches[1].gsub(' ', '%20')

			responses << {
				:command => "open https://www.google.com/search?q=#{search_term}",
        		:explanation => "Opens a browser on Google searching for '#{ search_term }."
			}
		end

		responses
	end
end

$executors << Google