# ElevateMe

The purpose of this script is to execute things with elevated privileges in systems running Windows.
You can use it to automatically make your code run with elevated privileges, without using something like the 
compatibility properties of an executable, so if that's what you're looking for, you probably found it.
Make no mistake, this is _**NOT**_ supposed to be some kind of exploit, it will still prompt the user on a system with UAC.

License: [cc0, version 1.0](https://creativecommons.org/publicdomain/zero/1.0/) (basically, do as you please and if you somehow manage to fry your pc using this, it's not my fault).

You only need _elevateMe.vbs_, but I've also uploaded a simple batch file (_test.bat_), that you can use to test it first, if you'd like.

### The script can be used in two ways:
- you can execute it and give it as an argument a different executable (with any arguments needed on the side)
- or you can write your code inside the script, if it can be expressed in VBScript

## Executing through arguments

The batch disables and re-enables the "TabletInputService" service, because it's totally a great service that never makes certain apps crash on windows 10 all the time if you have a graphics tablet connected. :)

That's just an example. An operation you can only do with elevated privileges.

If you execute it directly, through a normal user, you'll notice that it will fail, saying **"Access is denied."**

You can execute it through _elevateMe.vbs_ by running the command `elevateMe.vbs test.bat` (which should succeed).

Again, just an example, there are many ways to use the script.

You can also pass arguments by simply typing them next to it, like so: `elevateMe.vbs test.bat hello world`

## Executing inside script

If you'd much rather make a single file that executes some code with privileges, you can instead insert your own VBScript code, inside elevateMe.vbs, in the designated area.

For example, to disable the "TabletInputService" service, like in the batch file, you'd type: `objShell.ShellExecute "sc","config TabletInputService start=disabled`

> Have a good one!
