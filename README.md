# unblock-file
A command line utility which will unblock files and folders which are passed to it.
### USAGE:
new_unblock.exe [-r] [First\File\Path] .... [nth\File\Path]      
-r = Recursively unblock the files in the directory specified

### EXAMPLE:
new_unblock.exe -r %USERPROFILE%\Downloads     
Description: Unblocks all files in the current user's Downloads folder and all subfolders.

new_unblock.exe %USERPROFILE%\Documents\MyImportantDoc.docx      
Description: Unblocks the file "MyImportantDoc.docx" in the current user's Documents folder.


## How it works:
  So this is a very simple little utility I wrote in order to provide an automated way to unblock files and get rid of the extra
  prompt which appears when trying to run "blocked" applications:    
  ![Blocked file](http://i.imgur.com/Ls2FsFl.jpg "Blocked File")     
  The utility no longer relies on other third party tools to unblock files and now is able to run without any dependencies.
  The script will scan all of the files within the directory/directories specified by the arguments passed to it and, if any
  of the files have any Zone Identifier Stream data associated with them (see below for explanation), and deletes the 
  Zone Identifier Stream data if it is detected.
  
  
  ## Zone Identifier Stream data
  Zone Identifier Stream Names are used by Internet explorer for storage of URL security Zones.  Since these security zones
  security zones group URL namespaces according to their respective levels of trust, any file downloaded from the internet
  will have the Zone Identifier Stream Name for the Security Zone of the URL namespace from which it was downloaded "attached" 
  to it as well.