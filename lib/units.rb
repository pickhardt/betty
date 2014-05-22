module Units

  #
  ## Source: http://en.wikipedia.org/wiki/Conversion_of_units
  #

  def self.convert(amount, from, to)
        precision_f = '%.2f'            # this should be a config option

        conversions = {
            :mass => {  # all relative to 1 kilogram
                :grams     => {:re => /^(?:grams?|gr)$/i,         :factor => 1000.0},
                :quintals  => {:re => /^(?:quintals?)$/i,         :factor => 0.01},
                :tonnes    => {:re => /^(?:tonn?es?|(?-i:t))$/i,  :factor => 0.001},
                :kilograms => {:re => /^(?:kg|kilograms?)$/i,     :factor => 1.0},
                :pounds    => {:re => /^(?:pounds?|lbs)$/i,       :factor => 1.0 / 0.45359237},
            },
            :temperature => {   # using celsius as the standard
                :celsius    => {:re => /^(?:celsius|(?-i:C))$/i,    :code => lambda {|n, to| n} },
                :kelvin     => {:re => /^(?:kelvin|(?-i:K))$/i,     :code => lambda {|n, to| to ? (n + 273.15) : (-273.15 + n)} },
                :fahrenheit => {:re => /^(?:fahrenheit|(?-i:F))$/i, :code => lambda {|n, to| to ? (32.0 + n * 9.0/5.0) : ((n - 32.0) * 5.0/9.0)} },
            },
            :time        => {  # all relative to 1 second
                :nanoseconds  => {:re => /^(?:nanosec(?:ond)?s?|(?-i:ns))/,        :factor => 1.0e9},
                :microseconds => {:re => /^(?:microsec(?:ond)?s?|(?-i:us))/i,      :factor => 1.0e6},
                :milliseconds => {:re => /^(?:mill?isec(?:ond)?s?|(?-i:ms))$/i,    :factor => 1.0e3},
                :seconds      => {:re => /^(?:sec(?:ond)?s?|(?-i:s))$/i,           :factor => 1.0},
                :minutes      => {:re => /^(?:min(?:ute)?s?)$/i,                   :factor => 1.0 / 60.0},
                :moments      => {:re => /^(?:mom(?:ent)?s?)$/i,                   :factor => 1.0 / 90.0},
                :hours        => {:re => /^(?:hours?)$/i,                          :factor => 1.0 / 3600.0},
                :days         => {:re => /^(?:days?)$/i,                           :factor => 1.0 / 86400.0},
                :millidays    => {:re => /^(?:millidays?|(?-i:md))$/i,             :factor => 1.0 / 86.4},
                :weeks        => {:re => /^(?:weeks?)$/i,                          :factor => 1.0 / 604800.0},
                :months       => {:re => /^(?:mon(?:th)?s?)$/i,                    :factor => 1.0 / 2.62974e6},
                :years        => {:re => /^(?:years?)$/i,                          :factor => 1.0 / 31556952.0},
            },
            :velocity    => { # all relative to 1 meter / second
                :meters_per_second     => {:re => /^(?:m(?:et(?:er|re)s?)?\/s(?:ec)?|m(?:et(?:er|re)s?)?\s+per\s+sec(?:ond)?)$/i,      :factor => 1.0,},
                :miles_per_hour        => {:re => /^(?:mph|mi(?:les?)?\/h|mi(?:les?)?\s+per\s+hour)$/i,                                :factor => 1.0 / 0.44704},
                :miles_per_minute      => {:re => /^(?:mpm|mi(?:les?)?\/min|mi(?:les?)?\s+per\s+min(?:ute)?)$/i,                       :factor => 1.0 / 26.8224},
                :miles_per_second      => {:re => /^(?:mps|mi(?:les?)?\/s(?:ec)?|mi(?:les?)?\s+per\s+sec(?:ond)?)$/i,                  :factor => 1.0 / 1609.344},
                :kilometers_per_hour   => {:re => /^(?:kph|km\/h|(?:kilomet(?:er|re)s|km)\s+per\s+hour)$/i,                            :factor => 3.6},
                :metres_per_hour       => {:re => /^(?:m(?:eters?)?\/h|(?:metres?|m)\s+per\s+hour)$/i,                                 :factor => 3600.0},
                :kilometers_per_second => {:re => /^(?:kph|km\/s(?:ec)?|(?:kilomet(?:er|re)s|km)\s+per\s+sec(?:ond)?)$/i,              :factor => 0.001},
                :speed_of_light        => {:re => /^(?:speed\s+of\s+light)$/i,                                                         :factor => 1.0 / 299792458.0},
                :speed_of_sound        => {:re => /^(?:speed\s+of\s+sound)$/i,                                                         :factor => 1.0 / 340.29},
            },
            :length      => {   # all relative to 1 meter
                :kilometers       => {:re => /^(?:kilomet(?:er|re)s?|km)$/i,      :factor => 0.001},
                :meters           => {:re => /^(?:met(?:er|re)s?|(?-i:m))$/i,     :factor => 1.0},
                :centimetres      => {:re => /^(?:centimet(?:er|re)s?|cm)$/i,     :factor => 100},
                :millimetres      => {:re => /^(?:millimet(?:er|re)s?|mm)$/i,     :factor => 1000},
                :micrometres      => {:re => /^(?:micromet(?:er|re)s?|um)$/i,     :factor => 10.0**6.0},
                :nanometres       => {:re => /^(?:nanomet(?:er|re)s?|nm)$/i,      :factor => 10.0**9.0},
                :picometres       => {:re => /^(?:picomet(?:er|re)s?|pm)$/i,      :factor => 10.0**12.0},
                :femtometres      => {:re => /^(?:femtomet(?:er|re)s?|fm)$/i,     :factor => 10.0**15.0},
                :feets            => {:re => /^(?:feets?|ft|foot)$/i,             :factor => 1.0 / 0.304799735},
                :inches           => {:re => /^(?:inch(?:es)?|in|")$/i,           :factor => 1.0 / 0.0254},
                :miles            => {:re => /^(?:miles?|mi)$/i,                  :factor => 1.0 / 1609.344},
                :yards            => {:re => /^(?:yards?|yd)$/i,                  :factor => 1.0 / 0.9144},
                :astronomic_units => {:re => /^(?:astronomic[-\s]*units?|AU)$/i,  :factor => 1.0 / 149597870700.0},
                :light_seconds    => {:re => /^(?:light[-\s]*seconds?|ls)$/i,     :factor => 1.0 / 299792458.0},
                :light_minutes    => {:re => /^(?:light[-\s]*minutes?|lm)$/i,     :factor => 1.0 /     1.798754748e10},
                :light_hours      => {:re => /^(?:light[-\s]*hours?|lh)$/i,       :factor => 1.0 /    1.0792528488e12},
                :light_days       => {:re => /^(?:light[-\s]*days?|ld)$/i,        :factor => 1.0 /   2.59020683712e13},
                :light_years      => {:re => /^(?:light[-\s]*years?|LY)$/i,       :factor => 1.0 / 9.4607304725808e15},
            },
            :information   => { # all relative to 1 byte
                :bits           => {:re => /^(?:bits?)$/i,            :factor => 8.0},
                :bytes          => {:re => /^(?:bytes?)$/i,           :factor => 1.0},
                :kilobytes      => {:re => /^(?:kilobytes?|ki?b)$/i,  :factor => 1.0 / (1024.0 ** 1.0)},
                :megabytes      => {:re => /^(?:megabytes?|mi?b)$/i,  :factor => 1.0 / (1024.0 ** 2.0)},
                :gigabytes      => {:re => /^(?:gigabytes?|gi?b)$/i,  :factor => 1.0 / (1024.0 ** 3.0)},
                :terabytes      => {:re => /^(?:terabytes?|ti?b)$/i,  :factor => 1.0 / (1024.0 ** 4.0)},
                :petabytes      => {:re => /^(?:petabytes?|pi?b)$/i,  :factor => 1.0 / (1024.0 ** 5.0)},
                :exabytes       => {:re => /^(?:exabytes?|ei?b)$/i,   :factor => 1.0 / (1024.0 ** 6.0)},
                :zettabytes     => {:re => /^(?:zettabytes?|zi?b)$/i, :factor => 1.0 / (1024.0 ** 7.0)},
                :yottabytes     => {:re => /^(?:yottabytes?|yi?b)$/i, :factor => 1.0 / (1024.0 ** 8.0)},
            },
        }

        conversions.each do |category, value|
            value.each do |from_unit, from_data|
                if from.match(from_data[:re])
                    value.each do |to_unit, to_data|
                        if to.match(to_data[:re])

                            new_amount = 0.0;
                            if category == :temperature
                                std_from = from_data[:code].call(amount, false);
                                new_amount = to_data[:code].call(std_from, true);
                            else
                                new_amount = amount * to_data[:factor] / from_data[:factor];
                            end

                            puts new_amount == new_amount.to_i ? new_amount.to_i : precision_f % new_amount;
                            return true;
                        end
                    end
                    puts "#{category}: I don't know how to convert #{from_unit.to_s.gsub('_', ' ')} to #{to}...";
                    return false;
                end
            end
        end

        puts "I don't know how to convert #{from} to #{to}... Is even '#{from}' a real unit?";
        return false;
  end

  def self.convert_stuff(command)
    match = command.match(/^
        # command or question
        (?:(?:convert|how\s+much\s+is|what(?:\s+is|\W*s)(?:\s+the)?(?:\s+equivalent\s+of)?)\s+)?

        # followed by a number or 'a' word or nothing
        ([-+]?\d+(?:\.\d+)?|(?:an?|one)(?=\s)|(?=speed\s+of\s+))

        # unit from (up to 3 words)
        \s*(\S+(?:\s+\S+){0,2})

        # 'to' token
        \s+(?:in|to|into)\s+

        # unit to (up to 3 words)
        (\S+(?:\s+\S+){0,2})
    $/ix)

    if match
      amount = match[1];
      from = match[2];
      to = match[3];

      if amount == 'a' || amount == 'an' || amount == 'one' || amount == ''
            amount = 1.0;
      else
            amount = amount.to_f;
      end

      {
        :call => lambda {self.convert(amount, from, to)},
        :explanation => "Converts #{amount} #{from} to #{to}."
      }
    end
  end

  def self.interpret(command)
    responses = []

    convert_command = self.convert_stuff(command)
    responses << convert_command if convert_command

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Units",
      :description => 'Conversion of units.',
      :usage => [
        "144 F to C",
        "convert 10kg into pounds",
        "whats the equivalent of 21 inches in meters",
        "what is the speed of light in miles per hour",
      ]
    }
    commands
  end
end

$executors << Units
