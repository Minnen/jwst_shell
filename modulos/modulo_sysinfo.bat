@ECHO OFF

@TITLE JWST - Modulo Sysinfo

SET "OUT=C:\Users\%USERNAME%\Downloads\%COMPUTERNAME%"
SET "CHOICE=NUL"

NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [i] Solicitando permisos de administrador...
    POWERSHELL "Start-Process '%~f0' -Verb RunAs" >NUL
    EXIT
)

CLS
ECHO.
ECHO =============================================
ECHO          RECOPILACION DE INFORMACION
ECHO =============================================
ECHO.
ECHO Q - Recopilacion basica (rapida)
ECHO W - Recopilacion de msinfo32.nfo (puede tardar)
ECHO.
ECHO C - Cancelar
ECHO.
CHOICE /N /C:QWC /M "->"
IF ERRORLEVEL 3 GOTO final
IF ERRORLEVEL 2 SET "CHOICE=W" & GOTO inicio
IF ERRORLEVEL 1 SET "CHOICE=Q" & GOTO inicio

:inicio
ECHO.
ECHO [+] Recolectando informacion del sistema en:
ECHO     %OUT%
ECHO.
IF NOT EXIST "%OUT%" MD "%OUT%"
IF "%CHOICE%"=="Q" GOTO basico
IF "%CHOICE%"=="W" GOTO full

:basico
wmic baseboard get Product,Manufacturer,SerialNumber,Version /format:list > "%OUT%\baseboard.txt" 2>NUL
wmic computersystem get Name,Manufacturer,Model,TotalPhysicalMemory,SystemType /format:list > "%OUT%\computersystem.txt" 2>NUL
wmic useraccount get Name,SID,Disabled,Lockout,PasswordExpires /format:list > "%OUT%\useraccount.txt" 2>NUL
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed /format:list > "%OUT%\cpu.txt" 2>NUL
wmic bios get Manufacturer,SMBIOSBIOSVersion,ReleaseDate,SerialNumber /format:list > "%OUT%\bios.txt" 2>NUL
wmic diskdrive get Model,Size,SerialNumber,MediaType /format:list > "%OUT%\diskdrive.txt" 2>NUL
wmic os get Caption,Version,OSArchitecture,InstallDate,LastBootUpTime /format:list > "%OUT%\os.txt" 2>NUL
wmic startup get Caption,Command,Location,User /format:list > "%OUT%\startup.txt" 2>NUL
wmic product get Name,Version,Vendor /format:list > "%OUT%\installed_apps.txt" 2>NUL
net start > "%OUT%\services.txt" 2>NUL
systeminfo > "%OUT%\systeminfo.txt" 2>NUL
ipconfig /all > "%OUT%\ipconfig.txt" 2>NUL
GOTO exito

:full
ECHO.
ECHO [i] Generando msinfo32.nfo (puede tardar)...
msinfo32 /nfo "%OUT%\msinfo32.nfo" /categories +systemsummary >NUL 2>&1
GOTO exito

:exito
ECHO.
ECHO [+] Informacion recolectada correctamente.
CHOICE /N /C:SN /M "[?] Copiar a unidad extraible? -> (S/N)"
IF ERRORLEVEL 2 GOTO final
IF ERRORLEVEL 1 (
    SET /P "DRV=Letra de unidad (ej. E) ->"
    IF EXIST "%DRV%:\" (
        XCOPY "%OUT%" "%DRV%:\%COMPUTERNAME%\" /E /I /H /Y >NUL
        ECHO [+] Copiado a %DRV%:\%COMPUTERNAME%
        GOTO final
    ) ELSE (
        ECHO [!] Unidad %DRV%: no encontrada.
        GOTO final
    )
)

:final
ECHO.
ECHO Presiona cualquier tecla para cerrar... (Cierre automatico en 3s)
TIMEOUT /T 3 >NUL
EXIT