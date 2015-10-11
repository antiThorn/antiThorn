If WScript.Arguments.length =0 Then
	Set objShell = CreateObject("Shell.Application")
	'Pass a bogus argument with leading blank space, say [ uac]
	objShell.ShellExecute "wscript.exe", Chr(34) & _
	WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else
	Dim WshShell, s_start, s_stop
	Set WshShell = WScript.CreateObject("WScript.Shell")
	Set WMI = GetObject("WinMgmts:")
	Set objWMIService = GetObject("winmgmts:")
	Set objProcess = WMI.Get ("Win32_Process")
	Set W=CreateObject("Wscript.Shell")
	Set colMonitorProcess = _
	objWMIService.ExecNotificationQuery _
	("SELECT * FROM __InstanceOperationEvent " _
	& " WITHIN 1 WHERE TargetInstance ISA " _
	& "'Win32_Process'")
	s_start = True
	s_stop = False
	'wscript.echo "Loop"

	Do
		If s_start Then
' ПУТЬ ДО start.bat !!!  при этом тройные ковычки схронить.
			Return = WshShell.Run("C:\_unsystem\antiThornBDO\start.bat", 0, true)
' ПУТЬ ДО ЛАУЧЕРА!!! ЕСЛИ У ВАС ОН ОТЛИЧНЫЙ ОС СТАДРАТНОГО ТО ПОМЕНЯЙТЕ!!! Можно скопировать путь в свойстве ярлыка, при этом тройные ковычки схронить.
			Return = WshShell.Run("""C:\Program Files (x86)\QGNA\qGNA.exe""", 1, true)

			s_start = False
		End If

		Set objLatestEvent = colMonitorProcess.NextEvent

		If objLatestEvent.Path_.Class ="__InstanceDeletionEvent" Then
			If objLatestEvent.TargetInstance.Name="qGNA.exe" Then
' ПУТЬ ДО stop.bat !!!  при этом тройные ковычки схронить.
				Return = WshShell.Run("C:\_unsystem\antiThornBDO\stop.bat", 0, true)
				s_stop = True
			End If
		End If

	Loop Until s_stop = True

	Set WshShell = Nothing
	Set objWMIService = Nothing
	Set objShell = Nothing

End If