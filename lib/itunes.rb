require File.expand_path('../commands.rb', __FILE__)

module ITunes
  def self.mute_or_unmute(command)
    matching = command.match(/^(un)?mute\s+(itunes|((?:the|my)\s+)?music)$/i)
    is_unmute = matching && matching[1] == "un"
    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to set mute to #{ !is_unmute }"}),
        :explanation => "#{ is_unmute ? 'Unmutes' : 'Mutes' } iTunes."
      }
    else
      nil
    end
  end

  def self.stop(command)
    matching = command.match(/^stop\s+(itunes|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to stop"}),
        :explanation => "Stops playing iTunes."
      }
    else
      nil
    end
  end

  def self.start(command)
    matching = command.match(/^(start|resume|play)\s+(itunes|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to play"}),
        :explanation => "Starts playing iTunes."
      }
    else
      nil
    end
  end

  def self.pause(command)
    matching = command.match(/^pause\s+(itunes|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to pause"}),
        :explanation => "Pauses iTunes."
      }
    else
      nil
    end
  end

  def self.next(command)
    matching = command.match(/^(next|advance)\s+(song|music|track|iTunes)$/i)

    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to next track"}),
        :explanation => "Makes iTunes play the next track."
      }
    else
      nil
    end
  end

  def self.prev(command)
    matching = command.match(/^prev(?:ious)?\s+(song|music|track|iTunes)$/i)

    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to previous track"}),
        :explanation => "Makes iTunes play the previous track."
      }
    else
      nil
    end
  end

  def self.playing(command)
    matching = command.match(/^what\'?s?\s+((songs?|musics?|tracks?|iTunes)\s+)?(is)?\s?play(?:ing)?$/i)

    if matching
      {
        :command => Command.bus({:osx => "tell application \"iTunes\" to get name of current track"}),
        :explanation => "Gets the name of the playing track on iTunes."
      }
    else
      nil
    end
  end

  def self.interpret(command)
    responses = []

    mute_command = self.mute_or_unmute(command)
    responses << mute_command if mute_command

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
      :category => "iTunes",
      :description => 'Control \033[34miTunes\033[0m',
      :usage => ["mute itunes",
      "unmute itunes",
      "pause the music",
      "resume itunes",
      "stop my music",
      "next song",
      "prev track",
      "what song is playing",
      "(Note that the words song, track, music, etc. are interchangeable)"]
    }
    commands
  end
end

$executors << ITunes
