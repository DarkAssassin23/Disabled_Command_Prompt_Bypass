# Command Prompt for Standard Users When it is Disabled by the Administrator
**Version:** 2.0<br />
**Published Date:** 11/13/2023

About
----------------------
The purpose of this script is to circumvent the restriction system 
administrators put on users by disabling the command prompt on Windows 
devices. While the rational for this is for "security reasons" in a decent
number of cases PowerShell is still accessible to users even though it is 
the far more powerful and dangerous of the two when it comes to security.

This script subverts this disabling of the command prompt by using a batch
file to exploit the fact that under the hood of batch files is the command 
prompt. For additional information check out my corresponding 
[blog post](https://chiefwithcolorfulshoes.com/blog/How_to_fix_-_The_Command_Prompt_Has_been_Disabled_by_your_Administrator_-_Without_Access_to_an_Administrator_Account) 
for this script.
________________

How it works
---------------
This script works by running in an infinite loop of prompting you for input
and then calling ` cmd.exe /c ` which runs the command you just typed. 
`cmd.exe /c` is able to execute the command by using a temporary command 
prompt environment inside your batch script. 

Once it finishes executing the command(s) you typed, the temporary 
environment stops, exits and then loops back to your batch file prompting 
you for your next command. By doing this, you no longer run into the issue 
of “the command prompt has been disabled by your administrator” by leaving 
the command prompt open like `cmd.exe /k` would do, or just straight up 
opening the command prompt. 

As of version 2.0 this script now has full support for creating and modifying
temporary environment variables just like the normal command prompt
___________________


Future improvements
---------------
The script currently relies on the use of an external files for keeping
track of directory changes and environment variables because of the fact 
it uses a temporary command prompt environment to execute commands. 
Personally, I do not think this is the cleanest solution, but it works. 
If you have any recommendations to improve this, without losing any of 
the current functionality, I would also be eager to hear that as well.
