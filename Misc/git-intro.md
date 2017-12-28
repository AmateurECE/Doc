<!--
 NAME:				git-intro.md

 DESCRIPTION:		An introduction to the Git versioning system.

 CREATED:			12/28/2017

 LAST EDITED:		12/28/2017
-->

# What is Git? #

Git is a versioning control system, which is a fancy expression that describes
a really simple task. In essence, git allows you to save a snapshot of the
contents of a directory. Git comes with a myriad of tools which allows you to
use and manipulate these snapshots to keep track of your work in a clean
fashion. In this document, we will take a look at how to set up and use a git
repository.

Git was invented by Linus Torvalds, who is also famously known as the inventor
of the Linux operating system. You can find the source code for git on
<a href="https://github.com/git/git">GitHub</a>.

## Repositories and Hosting Services ##

There are largely two kinds of animals in the git ecosystem. There are
**hosting services**, and there are **repositories**. Hosting services are
servers which exist on the internet to maintain stable snapshots of
repositories.
<a href="https://github.com">GitHub</a> is probably the hosting service you are
most familiar with. Companies will often set up hosting services on their own
private networks. <a href="https://gogs.io/">Gogs</a> and
<a href="https://www.phacility.com/">Phabricator</a> are examples of other
commonly used hosting services.

Repositories are the fundamental units that git deals in maintaining. A
repository is just that--a receptacle for code, text, and any other kind of
files that require maintenance and version control. Usually, repositories
contain your files and a special directory with the name `.git`. This
directory is used by git to keep track of changes made to your files. It works
like this: when you make changes to your files, you can **commit** them to your
repository, effectively saving the changes that you made. You can then be free
to change or destroy your files without worry, because the saved copy can be
restored at any point as long as that `.git` directory remains intact.

Git keeps a history of all of the commits that you make, all the way back to
the first commit you've made. This means that you can not only restore your
files to working order if something terrible happens to them, but you can also
restore them to any previous version that you committed. This is very useful in
large code bases, where you may discover that a single change 50 commits ago
introduced a fatal bug in your code which is only now surfacing. 

# Using Git #

Now we get to the fun stuff--using and installing git. The first step to
using git is to ensure that it is installed. Git usually comes standard on
most operating systems, saving you a lot of trouble. Thankfully, it is easy to
check. Open up a terminal window and run the command `git -v`. You should
receive output like the following:

```
git version 2.13.6 (Apple Git-96)
```

Yours may look a little different, but as long as you see a version number
and not something along the lines of "Unknown command 'git'" you should be
fine. If you think git may not be installed on your system, you can always
try installing it via your package manager. If you don't have a package
manager, or aren't sure what one of those is, here is some useful info:

Apple users should look into Homebrew:
<a href="https://brew.sh">https://brew.sh</a>

Linux users may rest easy, because you already have one! `man apt` or `man yum`
should give you all of the information you need. If it doesn't, Google can
provide the rest.

Windows users should really consider switching to a different operating system.

## Creating and Cloning Repositories ##

It's very simple to create a repository with git:

```
git init
```

That's it, honestly. That command will initialize a git repository in the
current directory, and git will begin tracking changes that occur to files in
that directory and all subdirectories. If this is your first repository, you
may want to consider editing your git configuration file.

```
emacs ~/.gitconfig
```

`emacs` can be substituted for your favorite text editing program. This file
contains some global settings that git uses to maintain all of your
repositories. You will notice that all settings come in the form of an
assignment with an equals sign. Here's my .gitconfig file:

```
[user]
	name = AmateurECE
	email = edtwardy@mtu.edu
[core]
	editor = emacs
[color]
	status = auto
```

There are, however, some configuration options which are not stored in this
file. For example, your password for your remote hosting service. To see all
the options (including the ones only valid in the current repository), run
`git config --list`. You can run `git config --help` if you want to know more.
By the way, this command will also work for any valid git command. Simply
substitute `config` for the command you want to know more about. You may
also want to cache your password so that you don't have to enter it every time
you want to push to a remote repository.

If you plan to push this local repository onto a hosting service's servers, you
will also want to add the url of the remote repository as a `remote`:

```
git remote add origin https://github.com/AmateurECE/Doc
```

Will add a new remote with the name `origin` (this can be any name you want)
with the url. In this case, any commits pushed to `origin` will be pushed to
a Repository named "Doc" on GitHub owned by the user "AmateurECE".
`git remote -v` will list all of the remotes.

Sometimes, however, you want to obtain a copy of a repository which already
exists out there on the internet. To do this:

```
git clone <url>
```

Where `<url>` is the url of the repository. For example, to clone this
repository:

```
git clone https://github.com/AmateurECE/Doc
```

Git will then download the files from the repository and place them into a
directory with the name of the repository in the current directory.

## Commits ##

The **commit** is the atomic substance which git relies on. It is the lifeblood
of the programming world, if you'll excuse my poetic demeanor. To make a
commit, you must first have changes. Create a new file in your repository (if
you don't yet have a README.md for it, you might want to start there!).
Running `git status` should show you that there is an untracked file in the
repository. When there are no changes in the repository, output from
`git status` Should look something like this:

```
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working tree clean
```

To view specific changes to files in your repository, you can also run
`git diff`. Note, however, that untracked files do not show up in your diff.
To begin tracking a file, run the command:

```
git add <filename>
```

Where `<filename>` is obviously the name of the file. When you are satisfied
with all of the changes you have made, you can run:

```
git commit
```

When this command is run, git will open up your text editor and ask for you to
enter a commit message. By default, git gives pretty useful help messages
so I won't explain how to make commit messages here. However, for a bit of
extra reading, you should checkout the Linux kernel documentation 
(<a href="https://www.kernel.org/doc/html/v4.12/">Here!</a>) and do research on
the rule of 50/72. These are the rules that I and many other amateur coders
follow and, generally speaking, the rules followed by companies which
contribute to open source projects. As an extra treat, here's a shortcut for
creating commit messages:

```
git commit -m '<message>'
```

Where `<message>` is your commit message. This is a handy trick, but can be
considered bad practice in repositories owned and maintained by many people.

## Pushing and Pulling Commits ##

Finally, you'll want to push these commits to a remote repository. To do this,
simply run

```
git push remote <remote> <branch>
```

Where `<remote>` is the remote, most often `origin`, and branch is the branch
which contains the commits you want to push (most often `master`). To pull
changes from a remote, run:

```
git pull
```

Git will then download commits from the remote and patch them into the
working tree. Note that git will not pull changes into the current repository
if there are uncommitted changes. To learn about how to get around this, use
the stash (`git stash --help`).

# Further Reading #

Git is an incredibly complex and useful tool. I could not possibly document all
facets of its functionality in a document of this type. Thankfull for you,
there are other people on the internet more dedicated than I who have already
done that. Please go and check out their work. As a starter, however, here are
some useful commands which I find myself using quite often:

```
git am --help
git rebase --help
git reset --help
git clean --help
git rm --help
git merge --help
git branch --help
git checkout --help
```

Finally, I have already documented some weird edge use commands which I don't
have to use enough to commit to memory
<a href="https://github.com/AmateurECE/Doc/blob/master/Misc/useful-git.txt">
here</a> (for example, want to learn how to maintain a remote repository
somewhere on your local filesystem?). At the time of me writing this, there
isn't much there, but I plan to use it extensively in the coming future.

<!-- EOF -->
