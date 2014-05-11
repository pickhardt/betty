module Spotify
  
  def self.start(command)
    matching = command.match(/^(start|resume|play)\s+(spotify|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "osascript -e 'tell application \"spotify\" to play'",
        :explanation => "Starts playing spotify."
      }
    else
      nil
    end
  end

  def self.pause(command)
    matching = command.match(/^pause\s+(spotify|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "osascript -e 'tell application \"spotify\" to pause'",
        :explanation => "Pauses spotify."
      }
    else
      nil
    end
  end

  def self.next(command)
    matching = command.match(/^(next|advance)\s+(song|music|track|spotify)$/i)

    if matching
      {
        :command => "osascript -e 'tell application \"spotify\" to next track'",
        :explanation => "Makes spotify play the next track."
      }
    else
      nil
    end
  end

  def self.prev(command)
    matching = command.match(/^prev(?:ious)?\s+(song|music|track|spotify)$/i)

    if matching
      {
        :command => "osascript -e 'tell application \"spotify\" to previous track'",
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
      :description => "Control \033[34mSpotify\033[0m",
      :usage => "- betty play spotify
- betty pause spotify
- betty next spotify
- betty previous spotify"
    }
    commands
  end
end

$executors << Spotify
