module Cmus

  def self.stop(command)
    matching = command.match(/^stop\s+(cmus|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "cmus-remote --stop",
        :explanation => "Stops playing cmus."
      }
    else
      nil
    end
  end

  def self.start(command)
    matching = command.match(/^(start|resume|play)\s+(cmus|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "cmus-remote --play",
        :explanation => "Starts playing cmus."
      }
    else
      nil
    end
  end

  def self.pause(command)
    matching = command.match(/^pause\s+(cmus|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "cmus-remote --pause",
        :explanation => "Pauses cmus."
      }
    else
      nil
    end
  end

  def self.next(command)
    matching = command.match(/^(next|advance)\s+(song|music|track|cmus)$/i)

    if matching
      {
        :command => "cmus-remote --next",
        :explanation => "Makes cmus play the next track."
      }
    else
      nil
    end
  end

  def self.prev(command)
    matching = command.match(/^prev(?:ious)?\s+(song|music|track|cmus)$/i)

    if matching
      {
        :command => "cmus-remote --prev",
        :explanation => "Makes cmus play the previous track."
      }
    else
      nil
    end
  end

  def self.playing(command)
    matching = command.match(/^what\'?s?\s+((songs?|musics?|tracks?|cmus)\s+)?(is)?\s?play(?:ing)?$/i)

    if matching
      {
        :command => "cmus-remote --query | awk '/file.+/ {print $0}'",
        :explanation => "Gets the name of the playing track on cmus."
      }
    else
      nil
    end
  end

  def self.interpret(command)
    responses = []

    stop_command = self.stop(command)
    responses << stop_command if stop_command

    start_command = self.start(command)
    responses << start_command if start_command

    pause_command = self.pause(command)
    responses << pause_command if pause_command

    next_command = self.next(command)
    responses << next_command if next_command

    prev_command = self.prev(command)
    responses << prev_command if prev_command

    playing_command = self.playing(command)
    responses << playing_command if playing_command

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Cmus",
      :description => 'Control \033[34mCmus\033[0m',
      :usage => ["pause cmus (requires CMus Music player to be running)",
      "resume cmus (requires CMus Music player to be running)",
      "stop cmus (requires CMus Music player to be running)",
      "next cmus (requires CMus Music player to be running)",
      "prev cmus (requires CMus Music player to be running)",
      "whats cmus playing (requires CMus Music player to be running)"]
    }
    commands
  end
end

$executors << Cmus
