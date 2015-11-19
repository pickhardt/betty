Betty (version 0.1.8)
=====================
![circle ci build](https://circleci.com/gh/pickhardt/betty/tree/dev.png)

Betty is a friendly English-like interface for your command line.

She translates English-like phrases into commands in case you ever run into situations [like this][xkcd].

[xkcd]:http://xkcd.com/1168/

This means you don't have to leave your command line to look up an obscure but useful command. Just ask Betty!

NOTE: While I do not have the time to actively maintain Betty anymore, it is perfectly functional, and I am open to new maintainers taking the lead. If you would be interested, contact me at pickhardt (at) gmail (dot) com.

By Analogy
----------

iPhone users: it's like Siri for the command line.

Android users: it's like Google Voice Search for the command line. (What's Google Voice Search? It's that thing you talk to that does stuff.)


Set Up
------

Manually:

1. First, git clone this repo with `git clone https://github.com/pickhardt/betty`
2. Add the following alias to your ~/.bashrc
```alias betty="~/path/to/betty/main.rb"```
3. Use it! For instance, you can run commands: "betty how many words are in this directory" or "betty uncompress something.tar.gz"

Automatically:

1. First, git clone this repo with `git clone https://github.com/pickhardt/betty`
2. Run `ruby install.rb` in `betty/`.
3. Use it! For instance, you can run commands: `betty how many words are in this directory` or `betty uncompress something.tar.gz`


Examples
--------

Give Betty natural language input, for instance `betty whats my username`, and she'll respond in the most appropriate way.

    > betty whats my username
    Betty: Running whoami
    jrp

    > betty whats my real name
    Betty: Running finger `whoami` | sed 's/.*: *//;q'
    Jeff Pickhardt

If there's more than one way Betty could respond, she'll ask you to select the one you want.

    > betty whats my name
    Betty: Okay, I have multiple ways to respond.
    Betty: Enter the number of the command you want me to run one, or N (no) if you don't want me to run any.
    [1] whoami
        Gets your system username.
    [2] finger `whoami` | sed 's/.*: *//;q'
        Gets your full name.
    > 2
    Betty: Running finger `whoami` | sed 's/.*: *//;q'
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

    Config
    betty change your name to Joe
    betty speak to me
    betty stop speaking to me

    Datetime
    betty what time is it
    betty what is todays date
    betty what month is it
    betty whats today

    Find
    betty find me all files that contain california

    Internet
    betty download http://www.mysite.com/something.tar.gz to something.tar.gz
    betty uncompress something.tar.gz
    betty unarchive something.tar.gz to somedir
    (You can use unzip, unarchive, untar, uncompress, and expand interchangeably.)
    betty compress /path/to/dir

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

    Map
    betty show me a map of mountain view

    Meta
    betty what version are you (or just betty version)
    betty whats your github again

    Permissions
    betty give me permission to this directory
    betty give anotheruser ownership of myfile.txt

    Process
    betty show me all processes by root containing grep
    betty show me all my processes containing netbio

    Sizes
    betty show size for myfile.txt

    Spotify
    betty play spotify
    betty pause spotify
    betty next spotify
    betty previous spotify

    User
    betty whats my username
    betty whats my real name
    betty whats my ip address
    betty who else is logged in
    betty whats my version of ruby

	Web queries
	betty turn web on
	betty please tell me what is the weather like in London

Contributing
------------

Contributions are welcome! If you would like to contribute, please issue a pull request against the **dev branch**, not the master branch.

Please ensure that you use soft tabs, converting tabs to spaces. Do not use actual tab characters because it will make the spacing look weird in others' text editors.

Please make sure that the tests pass and try to write tests for your contributions. To check the tests, first run `bundle install` followed by `bundle exec rspec spec`


Maintainers Wanted
------------------

While I do not have the time to actively maintain Betty anymore, it is a cool concept and I'm open to someone else taking the lead. If you would like to become a maintainer, contact me at pickhardt (at) gmail (dot) com.


Versioning
----------

Releases will follow a semantic versioning format:

`<major>.<minor>.<patch>`

For more information on SemVer, visit [http://semver.org/](http://semver.org/).

License
-------

Released under the Apache License 2.0. Related link: www.apache.org/licenses/LICENSE-2.0.html
