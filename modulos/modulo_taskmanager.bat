@ECHO OFF

@TITLE JWST - Modulo Taskmanager

NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [i] Solicitando permisos de administrador...
    POWERSHELL "Start-Process '%~f0' -Verb RunAs" >NUL
    EXIT
)

:inicio
CLS
TASKLIST
ECHO.
CHOICE /M "Desea detener una tarea? "
ECHO.
IF ERRORLEVEL 2 GOTO salir
IF ERRORLEVEL 1 SET /p PID="PID de la tarea: "
CLS
TASKLIST /v /fi "PID eq %PID%" /FO LIST
ECHO.
CHOICE /M "Esta es la tarea que desea terminar? "
IF ERRORLEVEL 2 GOTO inicio
IF ERRORLEVEL 1 GOTO secfor

:secfor
ECHO.
CHOICE /N /C:SFC /M "De que manera S - SIMPLE F - FORZADO o C - CANCELAR? "
IF ERRORLEVEL 3 GOTO inicio
IF ERRORLEVEL 2 GOTO tkillf
IF ERRORLEVEL 1 GOTO tkills

:tkills
ECHO.
ECHO "Terminando tarea de manera simple... "
ECHO.
TASKKILL /PID %PID% /T
ECHO.
CHOICE /M "Desea terminar otra tarea? "
IF ERRORLEVEL 2 GOTO salir
IF ERRORLEVEL 1 GOTO tslist

:tkillf
ECHO.
ECHO "Terminando tarea de manera forzada... "
ECHO.
TASKKILL /F /PID %PID% /T
ECHO.
CHOICE /M "Desea terminar otra tarea?"
IF ERRORLEVEL 2 GOTO salir
IF ERRORLEVEL 1 GOTO tslist

:salir
ECHO.
ECHO Presiona cualquier tecla para cerrar... (Cierre automatico en 3s)
TIMEOUT /T 3 >NUL
EXIT