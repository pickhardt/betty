#!/usr/bin/env ruby

`complete -o bashdefault -o default -o filenames -o nospace -C ~/betty/betty-auto-completer.rb betty`
# ^^ This command links the 'betty' command to betty-auto-completer.rb
# It needs to be called only once upon installation, but it doesn't harm to be called every time

if ARGV.length==0
  puts "OK auto completer for betty installed"
  exit 
end

words=ARGV[1..-1].reverse.join(" ")
last=ARGV[2]
current=ARGV[1]

if last=="betty"
  puts "count"   if "count"  .start_with? current
  puts "find"    if "find"   .start_with? current
  puts "show"    if "show"   .start_with? current
  puts "what"    if "what"   .start_with? current
  puts "convert" if "convert".start_with? current
end

if last=="count"
  puts "words" if "words".start_with? current
  puts "lines" if "lines".start_with? current
  puts "chars" if "chars".start_with? current
end

if last=="convert"
  `COMPREPLY=()` # default filename completion
  # `compgen ...`
end