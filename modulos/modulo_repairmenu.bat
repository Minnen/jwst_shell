@ECHO OFF

@TITLE JWST - Modulo Repair Menu

NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [i] Solicitando permisos de administrador...
    POWERSHELL "Start-Process '%~f0' -Verb RunAs" >NUL
    EXIT
)

:repair_menu
CLS
ECHO.
ECHO =============================================
ECHO   HERRAMIENTAS DE REPARACION Y DIAGNOSTICO
ECHO =============================================
ECHO.
ECHO Q - sfc scannow
ECHO W - mdsched
ECHO E - chkdsk
ECHO.
ECHO S - Salir
ECHO.

CHOICE /N /C:QWES /M "->"
IF ERRORLEVEL 4 GOTO salir
IF ERRORLEVEL 3 GOTO chkdsk
IF ERRORLEVEL 2 GOTO mdsched
IF ERRORLEVEL 1 GOTO sfc_scannow

:sfc_scannow
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - Ejecutar el Comprobador de archivos de sistema
ECHO W - Ver los registros de SFC
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:QWB /M "->"
IF ERRORLEVEL 3 GOTO repair_menu
IF ERRORLEVEL 2 GOTO sfc_logs
IF ERRORLEVEL 1 GOTO run_sfc_scannow

:run_sfc_scannow
CLS
sfc /scannow
ECHO.
CHOICE /N /C:BQ /M "B - VOLVER AL MENU DE REPARACION Q - VER LOS REGISTROS DE SFC? "
IF ERRORLEVEL 2 GOTO sfc_logs
IF ERRORLEVEL 1 GOTO repair_menu

:sfc_logs
START "" "%WINDIR%\Logs\CBS\"
GOTO repair_menu

:mdsched
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - Ejecutar la Herramienta de diagnostico de memoria
ECHO W - Ver los registros de mdsched
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:QWB /M "->"
IF ERRORLEVEL 3 GOTO repair_menu
IF ERRORLEVEL 2 GOTO mdsched_logs
IF ERRORLEVEL 1 GOTO run_mdsched

:run_mdsched
mdsched.exe
GOTO repair_menu

:mdsched_logs
powershell "& ""C:\Users\%USERNAME%\AppData\Roaming\mdsched_results.ps1"""
START "" "C:\Users\%USERNAME%\Downloads\Windows_Memory_Diagnostics_Results.txt"
GOTO repair_menu

:chkdsk
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - Ejecutar la Comprobacion de errores de disco
ECHO W - Ver los registros de chkdsk
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:QWB /M "->"
IF ERRORLEVEL 3 GOTO repair_menu
IF ERRORLEVEL 2 GOTO chkdsk_logs
IF ERRORLEVEL 1 GOTO run_chkdsk

:run_chkdsk
CLS
chkdsk /F
ECHO.
CHOICE /N /C:B9 /M "B - VOLVER AL MENU DE REPARACION 9 - REINICIAR EL EQUIPO AHORA? "
IF ERRORLEVEL 2 shutdown /r /t 00
IF ERRORLEVEL 1 GOTO repair_menu

:chkdsk_logs
powershell "& ""C:\Users\%USERNAME%\AppData\Roaming\chkdsk_results.ps1"""
START "" "C:\Users\%USERNAME%\Downloads\Disk_Check_Results.txt"
GOTO repair_menu

:salir
ECHO.
ECHO Presiona cualquier tecla para cerrar... (Cierre automatico en 3s)
TIMEOUT /T 3 >NUL
EXIT