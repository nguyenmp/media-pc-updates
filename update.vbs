Function Main()
  '// Make sure we're on the latest version of our script
  '// Call UpdateSelf()
  
  '// Kill Skype cause it gets in the way
  Call KillSkype()
  
  '// We do all installations first
  Call RunWindowsUpdate()
  Call RunNinite()
  
  '// We clean after installations in case there's extra junk
  Call CleanProfAccount()
  Call RunCCleaner()
  
  '// Finally run ESET cause it's slow
  Call RunEset()
End Function



Function UpdateSelf()
  Dim objFSO : Set objFSO = CreateObject("Scripting.FileSystemObject")
  tempFullName = objFSO.GetFile(WScript.ScriptFullName).ParentFolder.Path & "\temp"
  
  '// Download the latest file from the internet
  Dim xHttp: Set xHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
  Dim bStrm: Set bStrm = CreateObject("Adodb.Stream")
  xHttp.Open "GET", "https://raw.github.com/nguyenmp/media-pc-updates/master/update.vbs", False
  xHttp.Send
  
  '// Store it temporarily
  With bStrm
    .type = 1 '//Text -- Not Binary
    .open
    .write xHttp.responseBody
    .savetofile tempFullName, 2
  End With
  
  '// Compare ourselves with the latest file
  Dim objThisFile : Set objThisFile = objFSO.OpenTextFile(WScript.ScriptFullName, 1)
  Dim objTempFile : Set objTempFile = objFSO.OpenTextFile(tempFullName, 1)
  
  strThisFile = objThisFile.ReadAll
  objThisFile.Close
  
  strTempFile = objTempFile.ReadAll
  objTempFile.Close
  
  '// If there is a difference, replace ourself, delete temp and relaunch
  If (Not (strThisFile = strTempFile)) Then
    objFSO.CopyFile tempFullName, WScript.ScriptFullName, True
	WScript.Echo "Updated Successfully--Relaunching Now"
	Dim objShell : Set objShell = CreateObject("WScript.Shell")
	objShell.Run """" & WScript.ScriptFullName & """"
	WScript.Quit
  Else
    '// Else (if there is no difference), delete temp and continue execution
	objFSO.DeleteFile(tempFullName)
  End If
End Function



Function KillSkype()
  '// Kill skype cause it gets in the way
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run "taskkill /F /IM skype.exe", 1, 1
End Function



Function RunWindowsUpdate()
  '//Launch auto scan with UI
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run """C:\Windows\System32\wuauclt.exe"" /detectnow", 1, 1
  objShell.Run """C:\Windows\System32\wuauclt.exe"" /ShowWUAutoScan", 1, 1
End Function


Function RunNinite()
  
  '// We need a shell to execute any instances of Ninite
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  
  '// We need FileSystemObject and folder to search for ninite
  Dim objFSO: Set objFSO = CreateObject("Scripting.FileSystemObject")
  Dim objFolder: Set objFolder = objFSO.getFile(WScript.ScriptFullName).ParentFolder
  
  '// Since ninite is named differently per pc
  '// We search for any executable that starts with "Ninite"
  Dim re: Set re = new regexp
  With re
    .Pattern = "^Ninite.*"
	.IgnoreCase = True
  End With
  
  '// Search for any executable that starts with "Ninite" and run it
  niniteExists = False
  For Each objFile in objFolder.Files
    If ((re.Test(objFile.Name)) And (objFSO.GetExtensionName(objFile.Path) = "exe")) Then
	  absolutePath = """" & objFSO.GetAbsolutePathName(objFile) & """"
	  objShell.Run absolutePath, 1, 1
	  niniteExists = True
	End If
  Next
  
  If (Not niniteExists) Then
    Call DownloadAndRunNinite()
  End If
End Function


Function DownloadAndRunNinite()
  Dim objFSO : Set objFSO = CreateObject("Scripting.FileSystemObject")
  tempFullName = objFSO.GetFile(WScript.ScriptFullName).ParentFolder.Path & "\Ninite.exe"
  
  '// Download the latest file from the internet
  Dim xHttp: Set xHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
  Dim bStrm: Set bStrm = CreateObject("Adodb.Stream")
  xHttp.Open "GET", "http://nguyenmp.com/static/Ninite.exe", False
  xHttp.Send
  
  '// Store it temporarily
  With bStrm
    .type = 1 '//Text -- Not Binary
    .open
    .write xHttp.responseBody
    .savetofile tempFullName, 2
  End With
  
  Dim ojbShell : Set objShell = CreateObject("WScript.Shell")
  objShell.Run tempFullName, 1, 1
End Function


Function CleanProfAccount()
  Call CleanDirectory("C:\Users\prof\Desktop\")
  Call CleanDirectory("C:\Users\prof\Downloads\")
  Call CleanDirectory("C:\Users\prof\Documents\")
  Call CleanDirectory("C:\Users\prof\Favorites\")
  Call CleanDirectory("C:\Users\prof\Links\")
  Call CleanDirectory("C:\Users\prof\Favorites\")
  Call CleanDirectory("C:\Users\prof\Music\")
  Call CleanDirectory("C:\Users\prof\Pictures\")
  Call CleanDirectory("C:\Users\prof\Videos\")
  Call CleanDirectory("C:\Users\Public\Documents\")
  Call CleanDirectory("C:\Users\Public\Downloads\")
  Call CleanDirectory("C:\Users\Public\Music\")
  Call CleanDirectory("C:\Users\Public\Pictures\")
  Call CleanDirectory("C:\Users\Public\Videos\")
End Function



Function CleanDirectory(ByRef path)
  '// Remove all files from the directory
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  
  If objFSO.FolderExists(path) Then
    Set objFolder = objFSO.getFolder(path)
    For Each objFile In objFolder.Files
      objFSO.DeleteFile(objFile.Path)
    Next
  End If
End Function



Function RunCCleaner()
  '// Update and autorun CCleaner, then run the UI
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run """C:\Program Files\CCleaner\CCleaner.exe"" /update", 1, 1
  objShell.Run """C:\Program Files\CCleaner\CCleaner.exe"" /AUTO", 1, 1
  objShell.Run """C:\Program Files\CCleaner\CCleaner.exe""", 1, 1
End Function



Function RunEset()
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run """C:\Program Files\ESET\Eset Endpoint Antivirus\egui.exe""", 1, 1
End Function



Call Main()
