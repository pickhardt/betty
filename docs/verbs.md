# Verbs
This document is a specification for a series of verbs that could be added to enhance the operation of betty.  Implementing these verbs may require changes to the core internal data structures.

Here are the suggested verbs:

* remember
* search
* learn
* quickref / cheatsheet / qref

Each is discussed below.

## Remember

Remember tells betty that you want her to, well, remember something.  This will later be retrieved by search or some kind of contextual memory ui. Remember can take arguments like a string to remember or a special word like "last" which would remember the last command typed.

Memories are heavily contextual and indexed along a number of different dimensions: 

* machine
* path
* ip address
* date
* keywords

The idea here is to surround the memory in a "cloud of metadata" so that you can effectively get back to it by whatever fragment you might remember.  We've all had the issue where we know we did something on the command line but we just can't get it back.  Here's a great example:

betty remember last

where last was this bit of arcana:

sudo gem install -n /usr/local/bin json

-or- (worse)

gem install nokogiri -- --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/libxml2 --use-system-libraries

I cannot tell you how many times I've had to dig that bit of crap up - so many times that I have a file named gem.txt in a /docs directory on like 10 projects now.  That's madness.

Now if we can get back the last command entered in the shell (I'm not a shell guy really) then we could make this:

## Search

Search would let you get back to a memory like:

betty search nokogiri

And you might get back that bit of arcana. 

Or "betty search last week" and you could get back anything you remembered last week.  

Or betty search . and you'd get anything in this directory you remembered.

If we can come up with a syntax for "current_machine"  (maybe betty search localhost) then it could be anything you remembered on this machine.

Earlier you challenged me "Is this EverNote?" and my answer was no.  When you work at the command line you effectively have micro expressions that are so small you often can't even justify writing them down and because they vary from machine to machine you can't always even generate them correctly but people do work them out and then they need them.  I think betty could be a far better approach to this than EverNote.

And if we work out a sync architecture tied to something like Dropbox then it could literally travel from machine to machine with you.  Yeah its tricky coding but its very worth while.  

## Learn

Both Learn and Remember are verbs that let the user add their own information to betty.  The more we can let people add their own information to betty, the more betty becomes something personal and vital that they won't want to walk away from.  Ideally learn would let the user generate their own betty commands where they can teach how to do something at the betty level.   It would likely need to be some kind of prompted mode which generated a data file.  It might even be great tool for us to generate commands faster.

If this was coupled to some kind of analytics we could see what people are doing with it.  You're clearly an analytics guy - you get this.

## quickref / cheatsheet / qref

This would be a verb where you could say:

betty cheatsheet docker

And it would tell betty to generate a cheatsheet of everything it knows about Docker.  Right now I'm in the middle of a massive code refactor from traditional hosting onto AWS and Docker and the myriad amount of crap I need to have on hand is annoying.  A lot of the files I'm generating in lib are directly from that project.  I have stubs for aws / docker / db / git / postgres / mysql / ssh / sql / tmux  Being able to get a cheatsheet of all those things after the fact would be hugely useful.  

This would likely involve some decent meta programming because we don't want to rebuild stuff.  What we would likely want to do is add extra fields to responses like :name, :url (for a reference), :execute, etc.  So you could say something like:

betty cheatsheet docker

And you'd get back an entry like:

Docker

List Processes:
docker ps   More... (if we had a url and hyperterm this could be the url)

Shut Down Processes
docker kill PID

The idea for :execute is we might to define something as a command but NOT have it always executed
