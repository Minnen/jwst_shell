@ECHO OFF

@TITLE JWST - Modulo Shell

NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Solicitando permisos de administrador...
    POWERSHELL "Start-Process '%~f0' -Verb RunAs"
    EXIT
)

CLS
ECHO.
ECHO =============================================
ECHO          CAMBIO DE SHELL DEL SISTEMA
ECHO =============================================
ECHO.
ECHO J - JWST
ECHO E - Explorer (Windows normal)
ECHO.
ECHO C - Cancelar
ECHO.
CHOICE /N /C:JEC /M "->"
IF ERRORLEVEL 3 GOTO salir
IF ERRORLEVEL 2 GOTO explorer
IF ERRORLEVEL 1 GOTO jwst

:jwst
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V Shell /T REG_SZ /D "%~dp0jwst.bat" /F >NUL
ECHO.
ECHO Shell cambiado a JWST
GOTO fin

:explorer
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V Shell /T REG_SZ /D "explorer.exe" /F >NUL
ECHO.
ECHO Shell cambiado a Explorer (Windows normal)
GOTO fin

:fin
ECHO.
CHOICE /N /C:SN /M "Reiniciar ahora para aplicar? -> (S/N)"
IF ERRORLEVEL 2 GOTO salir
IF ERRORLEVEL 1 SHUTDOWN /R /T 5

:salir
ECHO.
ECHO Presiona cualquier tecla para cerrar... (Cierre automatico en 3s)
TIMEOUT /T 3 >NUL
EXIT