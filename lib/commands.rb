require File.expand_path('../os.rb', __FILE__)

module Command

  @@platform_error = "echo \"I don\'t know how to do that on #{OS.platform_name} yet, sorry !\""

  #todo: complete for missing OSes
  def self.browser(link)
    browser = ""
    case OS.platform_name
      when 'OS X'
        browser = 'open'
      when 'Linux'
        browser = 'xdg-open'
      when 'Windows'
        browser = 'start'
      else
        return @@platform_error
    end
    return "#{ browser } #{ link }"
  end

  def self.bus(msg= {})
    case OS.platform_name
      when 'OS X'
        if ! msg[:osx]
          return @@platform_error
        end
        return "osascript -e '#{ msg[:osx] }'"
      when 'Linux'
        if ! msg[:linux]
          return @@platform_error
        end
        return "dbus-send #{ msg[:linux] }"
      else
        return @@platform_error
      end
  end

  def self.syscmd(msg= {})
    case OS.platform_name
      when 'OS X'
        if ! msg[:osx]
          return @@platform_error
        end
        return "#{ msg[:osx] }"
      when 'Linux'
        if ! msg[:linux]
          return @@platform_error
        end
        return "#{ msg[:linux] }"
      else
        return @@platform_error
      end
  end

end

