module Files
       def self.create_file(command)
          ## Create file  
          if command.match(/create\s+([new\s]?)+file(s?)/i)
               files = command.sub(/create\s+([new\s]?)+file(s?)/i,'').strip.split(' ')
               {
                     :command => "touch #{files.join(' ')}",
                     :explanation => "Create file(s)."
               }
          else
              nil               
          end
       end

       def self.create_folder(command)
          ## Create Folder
          if command.match(/(create|make)\s+([new\s]?)+(folder(s?)|dir|director(y|ies))(s?)\s/i)
               files = command.sub(/(create|make)\s+([new\s]?)+(folder(s?)|dir|director(y|ies))(s?)\s/i,'').strip.split(' ')
               {
                     :command => "mkdir #{files.join(' ')}",
                     :explanation => "Create Folder(s)"
               }
          else
              nil
          end
       end

       def self.rename_folder(command)
              ## Rename file/folder
              if command.match(/rename\s+(file|folder)\s/i)
                      paths = command.sub(/rename\s+(file|folder)\s/,'').strip.split(' ')

                      if !(paths.size<2 || paths.size > 3) 
                            paths -= ["to"] if(paths.size==3)
                            old_f, new_f = paths

                            {
                                   :command => "mv #{old_f} #{new_f}",
                                   :explanation => "Rename file/folder"
                            }
                     else
                            nil
                      end
              else
                     nil
              end                            
       end

       def self.delete_file(command)
               ## Delete file(s)
              if command.match(/(delete|remove)\s+file(s?)\s/)
                     paths = command.sub(/(delete|remove)\s+file\s/,'').strip.split(' ')

                     {
                            :command => "rm #{paths.join(' ')}",
                            :explanation => "Remove file(s)"
                     }
              else
                     nil
              end              
       end

       def self.delete_folder(command)
               ## Delete folder(s)
              if command.match(/(delete|remove)\s+folder(s?)\s/) || 
                       command.match(/(delete|remove)\s+all\s+(file(s?))\s+in\s/)
                       paths = command.sub(/(delete|remove)\s+folder(s?)\s/,'').strip.split(' ')

                       responses << {
                            :command => "rm -r #{paths.join(' ')}",
                            :explanation => "Remove folder(s)"
                       }
              end              
       end

       def self.delete_files_and_folders(command)
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
       end

       def self.copy_move(command)        
         ## Copy, Move, Scp files/folders
         if action = command.match(/(copy|move)\s+(file(s?)|folder(s?))\s+((from)?)/i) 

                paths = command.sub(/(copy|move)\s+(file(s?)|folder(s?))\s+((from)?)/i,'').strip.split(' ')              
                if !(paths.size > 3 || paths.size <2)
                 paths -= ['to'] if(paths.size == 3)  # Remove 'to' if exist

                 source, destination = paths

                     ## Remote transfer ## !!!! SUGGESTION REQUIRED !!!!
                     if (source.split('@')[1].split(':')[0].match(/(.com|\d+)/) rescue false)|| (destination.split('@')[1].split(':')[0].match(/(.com|\d+)/) rescue false)
                           flags = ""
                           flags += (File.directory?(source) || File.directory?(destination)) ? "-r " : ''

                           {
                                  :command => "scp #{flags} #{source} #{destination}",
                                  :explanation => "Remote Transfer"
                           }
                     elsif File.exist?(source) 
                           ## Move
                           if action[1] == 'move' 
                                  {
                                         :command => "mv #{source} #{destination}",
                                         :explanation => "Move the file/folder"
                                  }
                           ## Copy       
                           elsif action[1] == 'copy'
                                  flags = ""
                                  flags += File.directory?(source) ? "-R" : ''
                                  {
                                         :command => "cp #{flags} #{source} #{destination}",
                                         :explanation => "Move the file/folder"
                                  }
                           end
                     else
                           nil
                     end   
                else
                  nil
                end # path
         else
                nil
         end              
       end

	def self.interpret(command)
              responses = []

              create_file_command = self.create_file(command)
              responses << create_file_command if create_file_command

              create_folder_command = self.create_folder(command)
              responses << create_folder_command if create_folder_command

              rename_folder_command = self.rename_folder(command)
              responses << rename_folder_command if rename_folder_command

              delete_file_command = self.delete_file(command)
              responses << delete_file_command if delete_file_command

              delete_folder_command = self.delete_folder(command)
              responses << delete_folder_command if delete_folder_command

              delete_files_and_folders_command = self.delete_files_and_folders(command)
              responses << delete_files_and_folders_command if delete_files_and_folders_command

              copy_move_command = self.copy_move(command)
              responses << copy_move_command if copy_move_command

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