require 'rbconfig'

module OS

  def self.platform_name
    os = ""

    case RbConfig::CONFIG['host_os']
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        os = 'Windows'
      when /darwin|mac os/
        os = 'Mac OS'
      when /linux/
        os = 'Linux'
      else
        os = 'I cannot decipher what OS you are running on :('
    end

    os
  end

  def self.interpret(command)
    responses = []

    if command.match(/^(?:show|me|whats|what|is|my|\s)*OS(?:\s|name|do i have|is used|.)*$/i)
      os = platform_name

      responses << {
        :say => "#{os}",
        :explanation => "Show what OS is used."
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "OS",
      :description => 'Show \033[34mOS\033[0m name',
      :usage => ["- betty show what OS is used"]
    }
    commands
  end
end

$executors << OS
