#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <InetConstants.au3>
; *** End added by AutoIt3Wrapper ***
; *** Start added by AutoIt3Wrapper ***
#include <AutoItConstants.au3>
#include <WinAPIShPath.au3>
; *** End added by AutoIt3Wrapper ***
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.15.0 (Beta)
	Author:         myName

	Script Function:
	Template AutoIt script.f

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Array.au3>
#include <File.au3>
#include <WinAPIFiles.au3>
Opt("ExpandEnvStrings", 1)

$aCmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)
$recurs = False
If $aCmdLine[1] = "/?" And Int($aCmdLine[0]) = 1 Then
	ConsoleWrite(@CRLF & @CRLF & @TAB & @TAB & @TAB & @TAB & @TAB & "Unblock Files Command Line Utility" & @CRLF & @CRLF & "Unblock files." & @CRLF & "new_unblock.exe [/r] [[[drive:][path][filename]0] .... [[drive:][path][filename]n]]" & _
			@CRLF & @CRLF & "/r" & @TAB & "if any of the paths that are passed to the tool are directories, this switch will recursively unblock all files within the directory." & _
			@CRLF & @CRLF & "[[[drive:][path][filename]0] .... [[drive:][path][filename]n]]" & @TAB & "The paths that are passed to the tool to be unblocked.  These paths can be files or folders.  If a folder is specified, only the files in the root of that directory will be unblocked unless the /r switch is specified." & @CRLF)
ElseIf $aCmdLine[1] = "/?" And Int($aCmdLine[0]) > 1 Then
	ConsoleWriteError('Unexpected number of arguments.  For information on how to use this tool, run "new_unblock.exe /?".' & @CRLF)
Else
	For $i = 1 To $aCmdLine[0] Step 1
		If ($aCmdLine[$i] = "/r" Or $aCmdLine[$i] = "-r") And $i = 1 Then
			$recurs = True
			ContinueLoop
		EndIf
		If IsFile($aCmdLine[$i]) = 0 Then
			If $recurs = True Then
				$files = _FileListToArrayRec($aCmdLine[$i], "*", $FLTAR_FILES, $FLTAR_RECUR)
			Else
				$files = _FileListToArray($aCmdLine[$i], "*", $FLTA_FILES)
			EndIf
			For $b = 1 To $files[0] Step 1
				If FileExists($aCmdLine[$i] & "\" & $files[$b] & ":Zone.Identifier") Then
					ConsoleWrite ( "Unblocking file " & $aCmdLine[$i] & "\" & $files[$b] & @CRLF )
					_WinAPI_DeleteFile($aCmdLine[$i] & "\" & $files[$b] & ":Zone.Identifier:$DATA")
				Else
					ContinueLoop
				EndIf
			Next
		Else
			If FileExists($aCmdLine[$i] & ":Zone.Identifier") Then
				ConsoleWrite ( "Unblocking file " & $aCmdLine[$i] & @CRLF )
				_WinAPI_DeleteFile($aCmdLine[$i] & ":Zone.Identifier:$DATA")
			Else
				ContinueLoop
			EndIf
		EndIf
	Next
	ConsoleWrite ( "DONE" & @CRLF )
EndIf



Func IsFile($sFilePath)
	Return Number(FileExists($sFilePath) And StringInStr(FileGetAttrib($sFilePath), "D", 2, 1) = 0)
EndFunc   ;==>IsFile
