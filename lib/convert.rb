module Conversion
  
  def self.detect_in_format f
    # todo : mapping latin1 -> ISO-8859-1 etc etc
    return f.gsub(/.*\./,"")
  end
  
  def self.detect_out_format f
    return f.gsub(/.*\./,"")
  end
  
  
  def self.interpret(command)
    responses = []

    image_formats=%w[jpg bmp gif tif png]
    sound_formats=%w[wav mp3 flac au ogg]
    encoding_formats=%w[utf8 latin1 ascii ISO-8859-1 UTF-8] 
    doc_formats=%w[doc pdf] 
    # etc, todo
        
    convert_pattern=%r{
      (convert|save|transform)\s
      (?<all>all\s)?
      (?<my>my\s)?
      (?<files>.*?)\s
      (to|as)\s
      (?<out>.*)
    }imx
    
    match=convert_pattern.match command 
    return responses if not match
    
    in_files=match[:files]
    in_format=detect_in_format in_files
    out_format=detect_out_format match[:out]
    out_file=match[:out] if match[:out].length>3
    out_file||=in_files.sub(/\.#{in_format}/,".#{out_format}")
    args =  ""

    if match and encoding_formats.index out_format    
      command="iconv "
      args="-f ISO-8859-1 -t UTF-8"
      args="-f #{in_format} -t #{out_format}"
    end
    
    if match and image_formats.index out_format
      command="sips -s format"
      args = out_format + " "
      args += in_files + " "
      args += " --out " + out_file
      # OR: alias resize-image='/opt/local/bin/convert in.jpg -resize 231x231 out.jpg'
    end
    
    if match and sound_formats.index out_format
      command="ffmpeg"
      command="sox" if in_format=="raw"|| in_format=="pcm"
      args="-i #{in_files} #{out_file}"
      args="-t raw -r 8000 -e signed -b 16 -c 1" if in_format=="raw"
      args="-t raw -r 16k -e signed -b 8 -c 1" if in_format=="pcm"
      # function m4a_TO_mp3(){
      #   open "http://media.io/"
      # }
    end
    
    responses << {
      :command => "#{command} #{args}",
      :explanation => "Convert #{in_files} to #{out_format}"
    }

    return responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Conversion",
      :description => '\033[34mConvert\033[0m all kinds of files',
      :usage => ["convert img.jpg to bmp",
                 "convert song.wav to mp3"]
    }
    commands
  end
end

$executors << Conversion
