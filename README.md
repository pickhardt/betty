Betty (version 0.1.2)
=====================

Betty is a friendly English-like interface for your command line.

She translates English-like phrases into commands in case you every run into
situations [like this][xkcd].

[xkcd]:http://xkcd.com/1168/

This means you don't have to leave your command line to look up an obscure but useful command. Just ask Betty!


By Analogy
----------

iPhone users: it's like Siri for the command line.

Android users: it's like Google Now for the command line. (What's Google Now? It's that thing you talk to that does stuff.)


Set Up
------

1. git clone this repo. `git clone https://github.com/pickhardt/betty` will do.
2. Run `python install.py` in `betty/`.
3. Run commands: `betty how many words are in this directory` or `betty uncompress something.tar.gz`

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


Documentation
-------------

The following is a non-exhaustive list of things you can do:

    Count
    betty how many words are in this directory
    betty how many characters are in myfile.py
    betty count lines in this folder
    (Note that there's many ways to say more or less the same thing.)

    Internet
    betty download http://www.mysite.com/something.tar.gz to something.tar.gz
    betty uncompress something.tar.gz
    betty unarchive something.tar.gz to somedir
    (You can use unzip, unarchive, untar, uncompress, and expand interchangeably.)
    
    iTunes
    betty mute itunes
    betty unmute itunes
    betty pause the music
    betty resume itunes
    betty stop my music
    betty next song
    betty prev track
    betty what song is playing
    (Note that the words song, track, music, etc. are interchangeable)

    Fun
    betty go crazy
    betty whats the meaning of life
    ...and more that are left for you to discover!

    Meta
    betty what version are you (or just betty version)
    betty whats your github again
    
    Permissions
    betty give me permission to this directory
    betty give anotheruser ownership of myfile.txt
    
    User
    betty whats my username
    betty whats my real name
    betty whats my ip address
    betty who else is logged in
    

Contributing
------------

Contributions are welcome! If you would like to contribute, please issue a pull request against the dev branch, not the master branch.


Versioning
----------

Releases will follow a semantic versioning format:

`<major>.<minor>.<patch>`

For more information on SemVer, visit [http://semver.org/](http://semver.org/).
