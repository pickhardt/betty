module Internet
  def self.download(command)
    match = command.match(/^download\s+([^\s]{3,})(?:\s+to\s+(.+))?$/i)
    
    if match
      where = match[1].strip
      output = match[2]
      output = output.strip if output
      
      {
        :command => "curl#{ output ? ' -o ' + output : ''} #{ where }".strip,
        :explanation => "Downloads the contents of the URL#{ output ? ' to ' + output : '' }."
      }
    end
  end

  def self.uncompress(command)
    match = command.match(/^(?:unzip|unarchive|untar|uncompress|expand)\s+([^\s]+)(?:\s+(?:to\s+)?(.+))?$/i)
    
    if match
      what_file = match[1].strip
      where = match[2]
      if where.nil?
        where = what_file.split(".").first
      end
      in_same_directory = where == '.' || where.downcase.match(/^((?:this|same)\s+)?(?:dir(?:ectory)|folder|path)?$/)
      
      {
        :command => "#{ in_same_directory ? '' : 'mkdir ' + where + ' && ' } tar -zxvf #{ what_file } #{ in_same_directory ? '' : '-C ' + where }".strip,
        :explanation => "Uncompresses the contents of the file #{ what_file }, outputting the contents to #{ in_same_directory ? 'this directory' : where }."
      }
    end
  end

  def self.compress(command)
    match = command.match(/^(?:zip|archive|tar gzip|gzip tar|compress)\s+([^\s]+)(\s+(?:directory|dir|folder|path))?$/i)

    if match
      what_file = match[1].strip

      {
        :command => "cd #{ what_file }; tar -czvf #{ what_file }.tar.gz *",
        :explanation => "Compress the contents of #{ what_file } directory, outputting the compressed file to parent directory"
      }
    end
  end
  
  def self.interpret(command)
    responses = []
    
    download_command = self.download(command)
    responses << download_command if download_command
    
    uncompress_command = self.uncompress(command)
    responses << uncompress_command if uncompress_command

    compress_command = self.compress(command)
    responses << compress_command if compress_command
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Internet",
      :description => "Download files from \033[34minternet\033[0m, uncompress/compress them",
      :usage => "- betty download http://www.mysite.com/something.tar.gz to something.tar.gz
- betty uncompress something.tar.gz
- betty unarchive something.tar.gz to somedir
(You can use unzip, unarchive, untar, uncompress, and expand interchangeably.)
- betty compress /path/to/dir"
    }
    commands
  end
end

$executors << Internet
