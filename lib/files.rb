module Files
  def self.interpret(command)
     responses = []
     
     ## Create file
     if command.match(/create\s+([new\s]?)+file(s?)/i)
        files = command.sub(/create\s+([new\s]?)+file(s?)/i,'').strip.split(' ')
        responses <<{
          :command => "touch #{files.join(' ')}",
          :explanation => "Create file(s)."
        }
     end

     ## Create Folder
     if command.match(/(create|make)\s+([new\s]?)+(folder(s?)|dir|director(y|ies))(s?)\s/i)
        files = command.sub(/(create|make)\s+([new\s]?)+(folder(s?)|dir|director(y|ies))(s?)\s/i,'').strip.split(' ')
        responses << {
          :command => "mkdir #{files.join(' ')}",
          :explanation => "Create Folder(s)"
        }
       end

     ## Rename file/folder
     if command.match(/rename\s+(file|folder)\s/i)
       paths = command.sub(/rename\s+(file|folder)\s/,'').strip.split(' ')
       
       if !(paths.size<2 || paths.size > 3) 
         paths -= ["to"] if(paths.size==3)
         old_f, new_f = paths
         
         responses << {
           :command => "mv #{old_f} #{new_f}",
           :explanation => "Rename file/folder"
         }
       end
     end

     ## Delete file(s)
     if command.match(/(delete|remove)\s+file(s?)\s/)
       paths = command.sub(/(delete|remove)\s+file\s/,'').strip.split(' ')
     
       responses << {
         :command => "rm #{paths.join(' ')}",
         :explanation => "Remove file(s)"
       }
     end
     
     ## Delete folder(s)
     if command.match(/(delete|remove)\s+folder(s?)\s/) || 
         command.match(/(delete|remove)\s+all\s+(file(s?))\s+in\s/)
         paths = command.sub(/(delete|remove)\s+folder(s?)\s/,'').strip.split(' ')
     
         responses << {
           :command => "rm -r #{paths.join(' ')}",
           :explanation => "Remove folder(s)"
         }
     end

     ## Delete files and folders
     if command.match(/cleanup\s+folder(s?)\s/) || command.match(/force\s+cleanup\s+folder(s?)\s/)
        paths = command.sub(/cleanup\s+folder(s?)\s/,'').strip.split(' ')
        flags = "-r "
        flags += command.match(/force/) ? '-f ' : ''
     
        responses << {
          :command => "rm #{flags} #{paths.join(' ')}",
          :explanation => "Removes all files and folders in give folder"
        }
     end

     ## Copy, Move, Scp files/folders
     if action = command.match(/(copy|move)\s+(file(s?)|folder(s?)\s+)?(from\s+)?/i)
       paths = command.sub(/(copy|move)\s+(file(s?)|folder(s?)\s+)?(from\s+)?/i, '').strip.split(' ')
       if !(paths.size > 3 || paths.size < 2)
         paths -= ['to'] if paths.size == 3  # Remove 'to' if exist

         source, destination = paths

         ## Remote transfer ## !!!! SUGGESTION REQUIRED !!!!
         if (source.split('@')[1].split(':')[0].match(/(.com|\d+)/) rescue false)|| (destination.split('@')[1].split(':')[0].match(/(.com|\d+)/) rescue false)
           flags = ""
           flags += (File.directory?(source) || File.directory?(destination)) ? "-r " : ''
         
           responses << {
             :command => "scp #{flags}#{source} #{destination}",
             :explanation => "Remote transfer"
           }
         else
           if action[1].downcase == 'move' 
             responses << {
               :command => "mv #{source} #{destination}",
               :explanation => "Moves the file/folder"
             }
           elsif action[1].downcase == 'copy'
             flags = ""
             flags += File.directory?(source) ? "-R " : ''
             responses << {
               :command => "cp #{flags}#{source} #{destination}",
               :explanation => "Copies the file/folder"
             }
           end
         end
       end # path
     end

     responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Files",
      :usage =>[ "- betty create file fop.txt",
        "- betty create new file foo.txt",
        "- betty create files foo.txt bar.txt",
        "- betty create new files foo.txt bar.txt",
        "- betty create folder foo",
        "- betty create folders foo bar",
        "- betty create directory foo",
        "- betty create directories foo bar",
        "- betty create new folder foo",
        "- betty make directory foo",
        "- betty make directories foo bar",
        "- betty copy file my.txt to usr/",
        "- betty move file my.txt to usr/",
        "- betty copy folder my_songs/ to backup/",
        "- betty move folder my_songs/ to backup/",
        "- betty delete file junk.txt",
        "- betty remove file junk.txt",
        "- betty delete folder logs/",
        "- betty remove folder logs/",
        "- betty cleanup folder logs/",
        "- betty force cleanup folder logs/"
      ]
    }
  end
end

$executors << Files