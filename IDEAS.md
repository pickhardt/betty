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