#!/usr/bin/env ruby

`complete -o bashdefault -o default -o filenames -o nospace -C ~/betty/autocomplete.rb betty`
# This should be called only once upon installation, but it doesn't hurt if it gets called multiple times.

if ARGV.length==0
  puts "Betty: Autocomplete installed."
  exit 
end

words = ARGV[1..-1].reverse.join(" ")
last = ARGV[2]
current = ARGV[1]

if last == "betty"
  puts "count" if "count".start_with? current
  puts "find" if "find".start_with? current
  puts "show" if "show".start_with? current
  puts "what" if "what".start_with? current
  puts "convert" if "convert".start_with? current
end

if last == "count"
  puts "words" if "words".start_with? current
  puts "lines" if "lines".start_with? current
  puts "chars" if "chars".start_with? current
end

if last == "convert"
  `COMPREPLY=()` # default filename completion
  # `compgen ...`
end