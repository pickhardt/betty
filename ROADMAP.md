Roadmap
-------

This is the roadmap for Betty. It's OK to get something done sooner than on the roadmap.

0.2
---

Auto-generate documentation alongside the commands. Even better if the documentation can create automated tests.

Add tests (or leverage the documentation for automated tests).

See what features people want most, then add those.


0.3
---

Write up a general philosophy about adding commands. For instance: how to handle potentially damaging commands like rm or overwriting files.

Math.

Unit conversions with the units command.

0.4
---

Configuration settings.


0.6
---

Tokenization.

Generally useful classes (File, Directory, FileOrDirectory, etc). Specifically, more advanced and reusable syntax parsing, so that generic things can be used in many commands.

  For example, a generic way to parse phrases that mean files:
  
  betty count number of words in the files in this directory that end in rb or py
  
  AND
  
  betty move the files in this directory that end in rb or py to my/directory/here

  Note that "the files in this directory that end in rb or py" was used in both.

Maybe this could also handle multiple commands (with and) or conditionals (like if). "copy something.txt into my documents folder and rename it somethingelse.txt"


1.0
---

Betty for more than just the command line: it should have an API or otherwise be generally usable such that people can use Betty from non-command line interfaces.


Project Brainstorm
------------------

This is a list of medium to large project ideas.

Documentation methods for each module. Something that can be used to both give helpful output to the user, and autogenerate documentation that would be browsable online.

Automated testing. BDD, not TDD. Test what matters. Don't test everything for the sake of writing tests, and don't write brittle tests.

Reusable patterns, like a pattern for detecting a file or directory and converting it into a File or Directory class.

Send any unmatched commands to an API, to both log what commands people are running that aren't being caught, and to send back any new info for a response. For example, this could send unmatched commands to Jeannie.

Understand context: where is Betty being used from? What is the user doing? What does the user have open? The contextual module would be able to detect if you're in a shell (like Terminal) or detect if you're using it outside the shell (say, from a process that does voice to text). If outside the shell, "open my documents" would command the Finder: http://www.macosxautomation.com/applescript/firsttutorial/14.html But inside the shell, it'd just do cd ~/Documents

Voice to text capability. Run a process in the background. When somebody types a hotkey, beep and start recording the sound. When they're done talking, convert that sound to text via a voice to text API. Then run the command.

Get Betty into a package manager, specifically Homebrew (https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook).

Design a general intents API: a way for applications and developers to create their own commands and register them with Betty. Then, when Betty runs, it could leverage third party intents, without the developers needing to issue a pull request into Betty. It's important that the intents API be neutral. It shouldn't work better with Apple technology or Google technology or play favorites. However, if one company supports functionality that another company doesn't, there's no reason to prevent consumers from taking advantage of that functionality. It just needs to be done in a neutral way.

an idea could  be if modules could have a `self.help` method that would get triggered on empty results and when empty arguments...

I suppose that the main `betty.help` method would have to exist first and would get called when specialized method does not exist..  This would help in the cases when a module does not have a `help` method.

sample:

```bash
$ betty abracadabra
Betty: Sorry, I did not learn how to Abracadabra yet. If you are a developer you can teach me!
I do know how to:
- find
- count
... # a list of available modules should show up

$ betty find
Betty: I can find things if you help me. Check out the following examples:
- find me files that contain interpret
- find all md files in /this/path
Please note: I am case sensitive. Watch out for my feelings...
```