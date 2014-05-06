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

More advanced and reusable syntax parsing, so that generic things can be used in many commands.

  For example, a generic way to parse phrases that mean files:
  
  betty count number of words in the files in this directory that end in rb or py
  
  AND
  
  betty move the files in this directory that end in rb or py to my/directory/here

  Note that "the files in this directory that end in rb or py" was used in both.

Maybe this could also handle multiple commands (with and) or conditionals (like if). "copy something.txt into my documents folder and rename it somethingelse.txt"


1.0
---

Betty for more than just the command line: it should have an API or otherwise be generally usable such that people can use Betty from non-command line interfaces.
