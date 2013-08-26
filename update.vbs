


Function Main()
  Call RunWindowsUpdate()
  Call RunNinite()
  Call CleanProfAccount()
  Call RunCCleaner()
  Call RunEset()
End Function



Function RunWindowsUpdate()
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run """C:\Windows\System32\wuauclt.exe"" /detectnow", 1, 1
  objShell.Run """C:\Windows\System32\wuauclt.exe"" /ShowWUAutoScan", 1, 1
End Function


Function RunNinite()
  Dim objShell
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run """C:\Users\meadmin\Desktop\Ninite Air CutePDF FileZilla Firefox Flash Installer.exe""", 1, 1
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
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objFolder = objFSO.getFolder(path)
  For Each objFile In objFolder.Files
    objFSO.DeleteFile(objFile.Path)
  Next
End Function



Function RunCCleaner()
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
