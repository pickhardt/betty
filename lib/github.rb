#
# github.rb
# Author: Muhammad Hussein Nasrollahpour
# Date: 2014
# Copyright: See license agreement
#

## task: Takes care of all the Git commands headaches for user

module GitHub

  # creates a new repository on github
  def self.create_new_repository command
    match = command.match(/^create\snew\srepo\s+(.*)\s+on\s+(.*)$/)

    if match
      account_name = match[2].strip
      repo_name = match[1].strip

      if nil != account_name && nil != repo_name
        {
          :command => "curl -u '#{account_name}' https://api.github.com/user/repos -d '{\"name\":\"#{repo_name}\"}'",
          :explanation => "Creating a new repo on https://github.com/#{account_name}"
        }
      end
    end
  end

  # Clones a repository if exists
  def self.clone_a_repository command
    matches = command.match /^clone\s+(.*)\s+(in)?\s+(.*)?\sfrom\s+(.*)?\s+(to)?\s+(.*)?$/

    if matches
      i = 3
      branch_name = nil
      dir = nil
      repo_name = matches[1]
      has_in = "in" == matches[2] ? true : false
      if has_in
        branch_name = matches[i]
        i += 1
      end
      account_name = matches[i]
      i += 1
      has_to = "to" == matches[i] ? true : false
      if has_to
        i += 1
        dir = matches[i]
      end

      cmd = "git clone "
      exp = "Cloning #{repo_name}"

      if nil != repo_name && nil != account_name
        # FIXME:
        # if nil == branch_name && nil == dir
          # {
            # :command => cmd + "git://github.com/#{account_name}/#{repo_name}.git",
            # :explanation => exp + " repository in #{Dir.pwd}"
          # }
        # elsif nil != branch_name && nil == dir
          # {
            # :command => cmd + "-b #{branch_name} " + "git://github.com/#{account_name}/#{repo_name}.git",
            # :explanation => exp + ":#{branch_name} repository in #{Dir.pwd}"
          # }
        # elsif nil == branch_name && nil != dir
          # {
            # :command => cmd + "git://github.com/#{account_name}/#{repo_name}.git #{dir}",
            # :explanation => exp + ":#{branch_name} repository in #{Dir.pwd}"
          # }
        # elsif nil != branch_name && nil != dir
        if nil != branch_name && nil != dir
          {
            :command => cmd + "-b #{branch_name} " + "git://github.com/#{account_name}/#{repo_name}.git #{dir}",
            :explanation => exp + ":#{branch_name} repository in #{Dir.pwd}"
          }
        end
      end
    end
  end

  # Validates the question that is asked from betty about GitHub
  # and calls preferred methods based on user command
  def self.interpret command
    responses = []

    new_repo_command = self.create_new_repository(command)
    responses << new_repo_command if new_repo_command

    clone_repo_command = self.clone_a_repository command
    responses << clone_repo_command if clone_repo_command

    # TODO: Add more stuff as well

    responses
  end

  # Shows the help for specified executor
  def self.help
    commands = []

    commands << {
      :Category => "GitHub",
      :description => "Automate git commands",
      :usage => ["- betty create new repo repo_name on github_account_name",
                 "- betty clone repo_name in branch_name from github_account_name to directory"]
    }

    commands
  end

end

$executors << GitHub
