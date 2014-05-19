module Spotify

  @linux_dbus_command = "dbus-send --print-reply " \
            "--dest=org.mpris.MediaPlayer2.spotify " \
            "/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.%s"  \
            ">/dev/null"

  @osx_osascript_command = "osascript -e 'tell application \"spotify\" to %s'"

  def self.start(command)
    matching = command.match(/^(start|resume|play)\s+(spotify|((?:the|my)\s+)?music)$/i)

    if matching
      cmdline = ""
      case OS.platform_name
        when 'Mac OS'
          cmdline = @osx_osascript_command % "play"
        when 'Linux'
          cmdline = @linux_dbus_command % "PlayPause"
      end
      {
        :command => cmdline,
        :explanation => "Starts playing spotify."
      }
    else
      nil
    end
  end

  def self.pause(command)
    matching = command.match(/^pause\s+(spotify|((?:the|my)\s+)?music)$/i)

    if matching
      cmdline = ""
      case OS.platform_name
        when 'Mac OS'
          cmdline = @osx_osascript_command % "pause"
        when 'Linux'
          cmdline = @linux_dbus_command % "Pause"
      end
      {
        :command => cmdline,
        :explanation => "Pauses spotify."
      }
    else
      nil
    end
  end

  def self.next(command)
    matching = command.match(/^(next|advance)\s+(song|music|track|spotify)$/i)

    if matching
      cmdline = ""
      case OS.platform_name
        when 'Mac OS'
          cmdline = @osx_osascript_command % "next track"
        when 'Linux'
          cmdline = @linux_dbus_command % "Next"
      end
      {
        :command => cmdline,
        :explanation => "Makes spotify play the next track."
      }
    else
      nil
    end
  end

  def self.prev(command)
    matching = command.match(/^prev(?:ious)?\s+(song|music|track|spotify)$/i)

    if matching
      cmdline = ""
      case OS.platform_name
        when 'Mac OS'
          cmdline = @osx_osascript_command % "previous track"
        when 'Linux'
          cmdline = @linux_dbus_command % "Previous"
      end
      {
        :command => cmdline,
        :explanation => "Makes spotify play the previous track."
      }
    else
      nil
    end
  end


  def self.interpret(command)
    responses = []

    start_command = self.start(command)
    responses << start_command if start_command

    pause_command = self.pause(command)
    responses << pause_command if pause_command

    next_command = self.next(command)
    responses << next_command if next_command

    prev_command = self.prev(command)
    responses << prev_command if prev_command

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Spotify",
      :description => 'Control \033[34mSpotify\033[0m',
      :usage => ["play spotify",
      "pause spotify",
      "next spotify",
      "previous spotify"]
    }
    commands
  end
end

$executors << Spotify
