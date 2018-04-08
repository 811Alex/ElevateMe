' The purpose of this script is to execute things with elevated privileges in systems running Windows.
' Make no mistake, this is NOT supposed to be some kind of exploit, it will still prompt the user on a system with UAC.
' You can use it to automatically make your code run with elevated privileges, without using something like the 
' compatibility properties of an executable, so if that's what you're looking for, you probably found it.
'
' This script can be used in two ways:
'	-you can execute it and give it as an argument a different executable (with any arguments needed on the side)
'	-or you can write your code in this file, if it can be expressed in VBScript
'
' License: cc0-1.0
' Have a good one!

Const elevStr = "elevated"	'the string to append to the args, to know if we're already elevated
Dim objShell, argC
Set objShell = CreateObject("Shell.Application")
argC = WScript.Arguments.Count
elevateMe
''''' Anything below here, will be executed with elevated privileges. '''''

''' This piece of code, treats the 1st arg that this script receives as an executable and it executes it with any extra args it gets, go ahead and remove it if you don't want it '''
Dim fso, CurrentDir, app, extraArgs
If argC > 1 Then	'1st arg is the elevStr, if we have more than 1, things need to be executed
	Set fso = CreateObject("Scripting.FileSystemObject")
	CurrentDir = fso.GetParentFolderName(WScript.ScriptFullName)
	app = WScript.Arguments(0)	'get 1st arg
	extraArgs = getArgs(1,1)	'the last arg is the elevStr, so we grab what's between that and the 1st one
	
	if not fso.FileExists(app) Then	'absolute path?
		app = CurrentDir & app		'relative path?
		If not fso.FileExists(app) Then WScript.Quit 1	'can't find executable
	end if
	objShell.ShellExecute app,extraArgs
End If

''''' Add your code here, if needed. '''''



''''' End '''''
WScript.Quit

Sub elevateMe	'executes this script with elevated privileges and exits
	If argC > 0 Then If WScript.Arguments(argC-1) = elevStr Then Exit Sub	'already elevated
	args = Wscript.ScriptFullName & " " & LTrim(getArgs(0,0) & " " & elevStr)
	objShell.ShellExecute "wscript",args,,"runas"
	Wscript.Quit
End Sub

Function getArgs(aFrom,aTo)	'grab any extra arguments, Args: range, both start from 0, aTo counts from the end
	Dim temp
	temp = ""
	If argC > aFrom Then
		For i = aFrom To argC-aTo-1
			temp = temp & WScript.Arguments(i) & " "
		Next
	End If
	getArgs = RTrim(temp)
End Function