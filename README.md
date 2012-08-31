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
7. A patched DejaVu font for general use.


Installation
------------

Prefered way of installation is cloning the repository into your repository folder. 

My setup is following:

1. at work

<pre>
        github
          _
         / \
          |
          |
          |
         \_/
  1:1 clone r+w access
         / \
          |
          |
          |
         \_/
      read clone --bare with my changes for work
          _          _     _     _     _
         / \        / \   / \   / \   / \
          |          |     |     |     |
          |          |     |     |     |
          |          |     |     |     |
         \_/        \_/   \_/   \_/   \_/
   work station  remotes
</pre>

So I can manage all my accounts at work having the same configuration with my general configuration (updateable!) and setting new work configuration at its own, never getting to github.

2. at home

<pre>
It is similar at home, but on _each_ of my pcs exist an bare repository.

        github
          _
         / \
          |
          |
          |
         \_/
  1:1 clone r+w access
         / \
          |
          |
          |
         \_/
      read clone --bare with my changes for work
          _          _     _     _     _
         / \        / \   / \   / \   / \
          |          |     |     |     |
          |          |     |     |     |
          |          |     |     |     |
         \_/        \_/   \_/   \_/   \_/
   work station  remotes
</pre>

## Directorys

* `./bin`: Executable files which you do want on all your systems.
** git-wtf
* `./wrapper`: Wrapper scripts.
** pager
** urxvt

Frequently asked questeions
---------------------------

QUESTION: I have files on host $a which must not be versioned but I do not want add them to .gitignore (e. g. nobody should know about it, or file pattern is useless on other hosts)
ANSWER: Add it to .git/info/exclude
