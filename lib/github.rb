#
# github.rb
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See license agreement
#

## task: Takes care of all the Git commands headaches for user

module Github

  # creates a new repository on github
  def self.create_new_repository command
    match = command.match(/^create\snew\srepo\s+(.*)\s+(.*)$/)

    if match
      account_name = match[1].strip
      repo_name = match[2].strip

      if nil != account_name && nil != repo_name
        {
          :command => "curl -u '#{account_name}' https://api.github.com/user/repos -d '{\"name\":\"#{repo_name}\"}'",
          :explanation => "Creating a new repo on https://github.com/#{account_name}"
        }
      end
    end
  end

  # Validates the question that is asked from betty about GitHub
  # and calls preferred methods based on user command
  def self.interpret command
    responses = []

    new_repo_command = self.create_new_repository(command)
    responses << new_repo_command if new_repo_command
    # TODO: Add more stuff as well

    responses
  end

end

$executors << Github
