syranez' default home directory
===============================

This is the default skeleton home directory of syranez.

Current available content is

1. vim configuration
2. bash configuration
3. git global configuration
4. tmux configuration
5. newsbeuter configuration

    You have to set an url file in .newsbeuter though
6. nload configuration

Installation
------------

+ mutt

There is a .muttrc.standard file with My standard configuration, which can be used on all accounts. Include it in your .muttrc and overwrite what you do not like and set your private data in .muttrc.

Frequently asked questeions
---------------------------

QUESTION: I have files on host $a which must not be versioned but I do not want add them to .gitignore (e. g. nobody should know about it, or file pattern is useless on other hosts)
ANSWER: Add it to .git/info/exclude
