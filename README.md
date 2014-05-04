Betty (version 0.1.0)
=====================

Betty is an intelligent personal assistant for your command line.

She translates English-like phrases into commands.

This means you don't have to leave your command line to look up an obscure but useful command. Just ask Betty!


By Analogy
----------

iPhone users: it's like Siri for the command line.

Android users: it's like Google Now for the command line. (What's Google Now? It's that thing you talk to that does stuff.)


Set Up
------

First, git clone this repo.

Then add the following alias to your ~/.bashrc

alias betty="~/path/to/betty/main.rb"

Then run commands: "betty how many words are in this directory" or "betty uncompress something.tar.gz"

Examples
--------

Give Betty natural language input, for instance "betty whats my username", and she'll respond in the most appropriate way.

    > betty whats my username
    Betty: Running whoami
    jrp
    
    > betty whats my real name
    Betty: Running finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //'
    Jeff Pickhardt

If there's more than one way Betty could respond, she'll ask you to select the one you want.

    > betty whats my name
    Betty: Okay, I have multiple ways to respond.
    Betty: Enter the number of the command you want me to run one, or N (no) if you don't want me to run any.
    [1] whoami
        Gets your system username.
    [2] finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //'
        Gets your full name.
    > 2
    Betty: Running finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //'
    Jeff Pickhardt


Mission
-------

The mission of Betty is to provide a way to use computers through natural language input.

Specifically, the benefit is being able to do things on your computer without leaving the command line or screwing around on the internet trying to find the right command. Betty just works.


Contributing
------------

Contributions are welcome! If you would like to contribute, please issue a pull request against the dev branch, not the master branch.


Versioning
----------

Releases will follow a semantic versioning format:

`<major>.<minor>.<patch>`

For more information on SemVer, visit [http://semver.org/](http://semver.org/).
