module OS

  def self.platform_name
    os = "Unknown OS!"

    case RUBY_PLATFORM
      when /cygwin|mswin|mingw|bccwin|wince|emx/
        os = "Windows"
      when /darwin/
        os = "OS X"
      when /freebsd/
        os = "FreeBSD"
      when /openbsd/
        os = "OpenBSD"
      when /netbsd/
        os = "NetBSD"
      when /linux/
        os = "Linux"
    end

    os
  end

  def self.interpret(command)
    responses = []

    if command.match(/^(?:show|me|whats|what|is|my|\s)*OS(?:\s|name|do i have|is used|.)*$/i)
      os = platform_name

      responses << {
        :command => "echo '#{os}'",
        :explanation => "Show what OS is used."
      }
    end
    
    if command.match(/^(?:show|me|whats|what|is|my|\s)*kernel(?:\s|name|do i have|is used|.)*$/i)
      os = platform_name

      responses << {
        :command => "uname -a",
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
      :usage => ["show what OS is used"]
    }
    commands
  end
end

$executors << OS
