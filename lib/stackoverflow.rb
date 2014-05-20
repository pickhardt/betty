module Stackoverflow
  require 'cgi'

  def self.interpret(command)
    responses = []
    matches = command.match(/^(so|stackoverflow|stack)\s+(.+)/)

    if matches
      return responses if !require(File.expand_path("../../config.rb", __FILE__)) || !defined? ApiConfig || !defined? ApiConfig::GOOGLE_SEARCH_API_KEY || ApiConfig::GOOGLE_SEARCH_API_KEY.nil? || ApiConfig::GOOGLE_SEARCH_API_KEY == ""

      query = matches[-1]
      google_results = get_remote_json("https://www.googleapis.com/customsearch/v1?cx=012211726421152102993%3Autn0onfqvdc&key=#{ApiConfig::GOOGLE_SEARCH_API_KEY}", {:q => query})['items']
      stackoverflow_answers = google_results.select{ |result| result['link'].start_with?("http://stackoverflow.com/questions")}
      return responses if Array(stackoverflow_answers).length == 0

      links_array = stackoverflow_answers[0]['link'].split('/')
      id = links_array[links_array.index('questions')+1].to_i
      
      return responses if id == 0

      stackoverflow_result = get_remote_json("https://api.stackexchange.com/2.2/questions/#{id}?order=desc&sort=votes&site=stackoverflow&filter=!ay7uLWNahtxLpA")

      responses << {
        :command => "open #{stackoverflow_result['items'][0]['link']}",
        :explanation => handle_stackoverflow_data(stackoverflow_result['items'][0]),
        :ask_first => true
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Stackoverflow",
      :description => "Fetch stackoverflow responses. \nNeeds an API key: please execute cp #{File.expand_path("../../config.rb", __FILE__)}.example #{File.expand_path("../../config.rb", __FILE__)}\n\nOr get your own api key there: ",
      :usage => ["so how to post json data with curl",
                  "stackoverflow get local time in command line",
                  "stack open the browser from the console in linux"]
    }
    commands
  end

  private

  def self.handle_stackoverflow_data(data)
    "\n"+
    "-----------------------\n"+
    "Stackoverflow question:\n"+ 
    "-----------------------\n\n"+
    data['title'].bold +
    "\n\n"+
    code_in_bold(CGI.unescapeHTML(data['body_markdown']))+
    "\n\n"+
    "------------\n"+
    "Best Answer:\n"+
    "------------\n\n"+
    code_in_bold(CGI.unescapeHTML(data['answers'][0]['body_markdown']))
  end

  def self.code_in_bold(phrase)
    phrase.split("\n").map do |line| 
      if line.start_with?('    ') 
        line.bold
      else
        unquoted = true
        line.split('`').map{ |string| if unquoted then string else string.bold; unquoted ^= true end}.join('')
      end
    end.join("\n")
  end

  def self.get_remote_json(url, params={})
    require 'uri'
    require 'net/http'
    require "json"
    uri = URI(url)
    if !params.empty?
      if uri.query.nil? || uri.query == ""
        uri.query = URI.encode_www_form(params)
      else
        uri.query += "&"+URI.encode_www_form(params)
      end
    end

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    res = http.request(Net::HTTP::Get.new(uri.request_uri))

    case res
      when Net::HTTPSuccess then  
        begin
          if res.header[ 'Content-Encoding' ].eql?('gzip') then
            # puts "Performing gzip decompression for response body." if debug_mode
            sio = StringIO.new(res.body)
            gz = Zlib::GzipReader.new(sio)
            content = gz.read()
            # puts "Finished decompressing gzipped response body." if debug_mode
          else
            # puts "Page is not compressed. Using text response body. " if debug_mode
            content = res.body
          end
        rescue Exception
          puts "Error occurred (#{$!.message})"
          # handle errors
          raise $!.message
        end
    end

    return JSON.parse(content)
  end

end

$executors << Stackoverflow
