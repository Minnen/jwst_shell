@ECHO OFF

@TITLE JWST

:menu
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Opciones
ECHO.
ECHO Q - Directorios
ECHO W - Herramientas
ECHO E - Aplicaciones
ECHO R - Aplicaciones dinamicas
ECHO.
ECHO A - Navegador
ECHO S - Panel de control
ECHO.
ECHO 8 - Bloquear
ECHO 9 - Reiniciar
ECHO 0 - Apagar
ECHO.
CHOICE /N /C:1QWERAS890 /M "->"
IF ERRORLEVEL 10 GOTO apagar
IF ERRORLEVEL 9 GOTO reiniciar
IF ERRORLEVEL 8 GOTO bloquear
IF ERRORLEVEL 7 GOTO control
IF ERRORLEVEL 6 GOTO browser
IF ERRORLEVEL 5 GOTO aplicaciones_din
IF ERRORLEVEL 4 GOTO aplicaciones
IF ERRORLEVEL 3 GOTO herramientas
IF ERRORLEVEL 2 GOTO directorios
IF ERRORLEVEL 1 GOTO opciones

:opciones
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Modulos/Scripts
ECHO.
ECHO Q - Iniciar powershell
ECHO W - Copiar informacion del sistema
ECHO E - Perifericos
ECHO R - Gestion de tareas
ECHO.
ECHO A - Propiedades del sistema
ECHO S - Cambiar shell del sistema
ECHO D - Estado de las redes
ECHO F - Nivel de bateria
ECHO.
ECHO Z - Herramientas de Diagnostico y Reparacion
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:1QWERASDFZB /M "->"
IF ERRORLEVEL 11 GOTO menu
IF ERRORLEVEL 10 GOTO repair_menu
IF ERRORLEVEL 9 GOTO batteryrem
IF ERRORLEVEL 8 GOTO networkstatus
IF ERRORLEVEL 7 GOTO shellc
IF ERRORLEVEL 6 GOTO systempropertiesadvanced
IF ERRORLEVEL 5 GOTO tslist
IF ERRORLEVEL 4 GOTO peripheral
IF ERRORLEVEL 3 GOTO sysinfo
IF ERRORLEVEL 2 GOTO powershell
IF ERRORLEVEL 1 GOTO modulos

:modulos
IF NOT EXIST "%~dp0data\data_scripts_din.bat" (
ECHO @ECHO OFF
ECHO SET "SQN=Indefinda"
ECHO SET "SQP=%~dp0scripts\"
ECHO SET "SWN=Indefinda"
ECHO SET "SWP=%~dp0scripts\"
ECHO SET "SEN=Indefinda"
ECHO SET "SEP=%~dp0scripts\"
ECHO SET "SRN=Indefinda"
ECHO SET "SRP=%~dp0scripts\"
ECHO SET "SAN=Indefinda"
ECHO SET "SAP=%~dp0scripts\"
ECHO SET "SSN=Indefinda"
ECHO SET "SSP=%~dp0scripts\"
ECHO SET "SDN=Indefinda"
ECHO SET "SDP=%~dp0scripts\"
ECHO SET "SFN=Indefinda"
ECHO SET "SFP=%~dp0scripts\"
ECHO SET "SZN=Indefinda"
ECHO SET "SZP=%~dp0scripts\"
ECHO SET "SXN=Indefinda"
ECHO SET "SXP=%~dp0scripts\"
ECHO SET "SCN=Indefinda"
ECHO SET "SCP=%~dp0scripts\"
ECHO SET "SVN=Indefinda"
ECHO SET "SVP=%~dp0scripts\"
) > %~dp0data\data_scripts_din.bat
CALL %~dp0data\data_scripts_din.bat
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %SQN%
ECHO W - %SWN%
ECHO E - %SEN%
ECHO R - %SRN%
ECHO.
ECHO A - %SAN%
ECHO S - %SSN%
ECHO D - %SDN%
ECHO F - %SFN%
ECHO.
ECHO Z - %SZN%
ECHO X - %SXN%
ECHO C - %SCN%
ECHO V - %SVN%
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:1QWERASDFZXCVB /M "->"
IF ERRORLEVEL 14 GOTO menu
IF ERRORLEVEL 13 GOTO script_din_v
IF ERRORLEVEL 12 GOTO script_din_c
IF ERRORLEVEL 11 GOTO script_din_x
IF ERRORLEVEL 10 GOTO script_din_z
IF ERRORLEVEL 9 GOTO script_din_f
IF ERRORLEVEL 8 GOTO script_din_d
IF ERRORLEVEL 7 GOTO script_din_s
IF ERRORLEVEL 6 GOTO script_din_a
IF ERRORLEVEL 5 GOTO script_din_r
IF ERRORLEVEL 4 GOTO script_din_e
IF ERRORLEVEL 3 GOTO script_din_W
IF ERRORLEVEL 2 GOTO script_din_q
IF ERRORLEVEL 1 START "" "%WINDIR%\notepad.exe" %~dp0data\data_scripts_din.bat & GOTO menu

:script_din_q
START "" "%SQP%"
GOTO menu

:script_din_w
START "" "%SWP%"
GOTO menu

:script_din_e
START "" "%SEP%"
GOTO menu

:script_din_r
START "" "%SRP%"
GOTO menu

:script_din_a
START "" "%SAP%"
GOTO menu

:script_din_s
START "" "%SSP%"
GOTO menu

:script_din_d
START "" "%SDP%"
GOTO menu

:script_din_f
START "" "%SFP%"
GOTO menu

:script_din_z
START "" "%SZP%"
GOTO menu

:script_din_x
START "" "%SXP%"
GOTO menu

:script_din_c
START "" "%SCP%"
GOTO menu

:script_din_v
START "" "%SVP%"
GOTO menu

:powershell
START "" "%WINDIR%\System32\WindowsPowerShell\v1.0\powershell.exe"
GOTO menu

:sysinfo
START "" "%~dp0modulos\modulo_sysinfo.bat"
GOTO menu

:peripheral
control printers
GOTO menu

:tslist
START "" "%~dp0modulos\modulo_taskmanager.bat"
GOTO menu

:systempropertiesadvanced
START "" "%WINDIR%\System32\SystemPropertiesAdvanced.exe"
GOTO menu

:shellc
START "" "%~dp0modulos\modulo_shell.bat"
GOTO menu

:networkstatus
CLS
NETSH INTERFACE SHOW INTERFACE
GOTO networkstatusc

:networkstatusc
ECHO.
CHOICE /N /C:FNB /M "Presione F - REFRESCAR, N - NCPA.CPL o B - VOLVER AL MENU PRINCIPAL? "
IF ERRORLEVEL 3 GOTO menu
IF ERRORLEVEL 2 START "" "%WINDIR%\System32\ncpa.cpl"
IF ERRORLEVEL 1 GOTO networkstatus

:batteryrem
CLS
ECHO.
ECHO Carga estimada restante
WMIC PATH Win32_Battery GET EstimatedChargeRemaining
ECHO Resultado 1/2 - Usando la Bateria/Conectado a corriente alterna
WMIC PATH Win32_Battery GET BatteryStatus
PAUSE
GOTO menu

:repair_menu
START "" "%~dp0modulos\modulo_repairmenu.bat"
GOTO menu

:directorios
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - C:\
ECHO W - %USERNAME%
ECHO E - System32
ECHO R - Downloads
ECHO.
ECHO A - Program Files
ECHO S - Program Files (x86)
ECHO D - AppData
ECHO F - Escritorio
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:QWERASDFB /M "->"
IF ERRORLEVEL 9 GOTO menu
IF ERRORLEVEL 8 GOTO desktop
IF ERRORLEVEL 7 GOTO appdata
IF ERRORLEVEL 6 GOTO program_files_X
IF ERRORLEVEL 5 GOTO program_files
IF ERRORLEVEL 4 GOTO downloads
IF ERRORLEVEL 3 GOTO system32
IF ERRORLEVEL 2 GOTO userdir
IF ERRORLEVEL 1 GOTO cdir

:cdir
START "" "C:\"
GOTO menu

:userdir
START "" "C:\Users\%USERNAME%"
GOTO menu

:system32
START "" "%WINDIR%\System32"
GOTO menu

:downloads
START "" "C:\Users\%USERNAME%\Downloads"
GOTO menu

:program_files
START "" "C:\Program Files"
GOTO menu

:program_files_x
START "" "C:\Program Files (x86)"
GOTO menu

:appdata
START "" "C:\Users\%USERNAME%\AppData"
GOTO menu

:desktop
START "" "C:\Users\%USERNAME%\Desktop"
GOTO menu

:herramientas
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - cmd
ECHO W - taskmgr
ECHO E - ncpa
ECHO R - sndvol
ECHO.
ECHO A - cleanmgr
ECHO S - msinfo32
ECHO D - dxdiag
ECHO F - appwiz
ECHO.
ECHO Z - regedit
ECHO X - msconfig
ECHO C - services
ECHO V - taskschd
ECHO.
ECHO B - Volver
ECHO N - Siguiente
ECHO.
CHOICE /N /C:QWERASDFZXCVBN /M "->"
IF ERRORLEVEL 14 GOTO second_admintools
IF ERRORLEVEL 13 GOTO menu
IF ERRORLEVEL 12 GOTO taskschd
IF ERRORLEVEL 11 GOTO services
IF ERRORLEVEL 10 GOTO msconfig
IF ERRORLEVEL 9 GOTO regedit
IF ERRORLEVEL 8 GOTO appwiz
IF ERRORLEVEL 7 GOTO dxdiag
IF ERRORLEVEL 6 GOTO msinfo32
IF ERRORLEVEL 5 GOTO cleanmgr
IF ERRORLEVEL 4 GOTO sndvol
IF ERRORLEVEL 3 GOTO ncpa
IF ERRORLEVEL 2 GOTO taskmgr
IF ERRORLEVEL 1 GOTO cmd

:cmd
START "" "%WINDIR%\System32\cmd.exe"
GOTO menu

:taskmgr
START "" "%WINDIR%\System32\taskmgr.exe"
GOTO menu

:ncpa
START "" "%WINDIR%\System32\ncpa.cpl"
GOTO menu

:sndvol
START "" "%WINDIR%\System32\SndVol.exe"
GOTO menu

:cleanmgr
START "" "%WINDIR%\System32\cleanmgr.exe"
GOTO menu

:msinfo32
START "" "%WINDIR%\System32\msinfo32.exe"
GOTO menu

:dxdiag
START "" "%WINDIR%\System32\dxdiag.exe"
GOTO menu

:appwiz
START "" "appwiz.cpl"
GOTO menu

:regedit
START "" "%WINDIR%\regedit.exe"
GOTO menu

:msconfig
START "" "%WINDIR%\System32\msconfig.exe"
GOTO menu

:services
START "" "%WINDIR%\System32\services.msc"
GOTO menu

:taskschd
START "" "%WINDIR%\System32\taskschd.msc"
GOTO menu

:second_admintools
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - defrag
ECHO W - diskpart
ECHO E - eventvwr
ECHO R - perfmon
ECHO.
ECHO A - resmon
ECHO S - devmgmt
ECHO D - compmgmt
ECHO F - diskmgmt
ECHO.
ECHO Z - netplwiz
ECHO X - lusrmgr
ECHO C - mmsys
ECHO V - mstsc
ECHO.
ECHO B - Volver
ECHO M - Menu principal
ECHO.
CHOICE /N /C:QWERASDFZXCVBM /M "->"
IF ERRORLEVEL 14 GOTO menu
IF ERRORLEVEL 13 GOTO herramientas
IF ERRORLEVEL 12 GOTO mstsc
IF ERRORLEVEL 11 GOTO mmsys
IF ERRORLEVEL 10 GOTO lusrmgr
IF ERRORLEVEL 9 GOTO netplwiz
IF ERRORLEVEL 8 GOTO diskmgmt
IF ERRORLEVEL 7 GOTO compmgmt
IF ERRORLEVEL 6 GOTO devmgmt
IF ERRORLEVEL 5 GOTO resmon
IF ERRORLEVEL 4 GOTO perfmon
IF ERRORLEVEL 3 GOTO eventvwr
IF ERRORLEVEL 2 GOTO diskpart
IF ERRORLEVEL 1 GOTO defrag

:defrag
START "" "%WINDIR%\System32\dfrgui.exe"
GOTO menu

:diskpart
START "" "%WINDIR%\System32\diskpart.exe"
GOTO menu

:eventvwr
START "" "%WINDIR%\System32\eventvwr.exe"
GOTO menu

:perfmon
START "" "%WINDIR%\System32\perfmon.exe"
GOTO menu

:resmon
START "" "%WINDIR%\System32\resmon.exe"
GOTO menu

:devmgmt
START "" "%WINDIR%\System32\devmgmt.msc"
GOTO menu

:compmgmt
START "" "%WINDIR%\System32\compmgmt.msc"
GOTO menu

:diskmgmt
START "" "%WINDIR%\System32\diskmgmt.msc"
GOTO menu

:netplwiz
START "" "%WINDIR%\System32\Netplwiz.exe"
GOTO menu

:lusrmgr
START "" "%WINDIR%\System32\lusrmgr.msc"
GOTO menu

:mmsys
START "" "%WINDIR%\System32\mmsys.cpl"
GOTO menu

:mstsc
START "" "%WINDIR%\System32\mstsc.exe"
GOTO menu

:aplicaciones
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO Q - Calculadora
ECHO W - Bloc de notas
ECHO E - Paint
ECHO R - Mapa de carateres
ECHO.
ECHO A - Teclado en pantalla
ECHO.
ECHO B - Volver
ECHO.
CHOICE /N /C:QWERAB /M "->"
IF ERRORLEVEL 6 GOTO menu
IF ERRORLEVEL 5 GOTO osk
IF ERRORLEVEL 4 GOTO charmap
IF ERRORLEVEL 3 GOTO mspaint
IF ERRORLEVEL 2 GOTO notepad
IF ERRORLEVEL 1 GOTO calc

:calc
START "" "https://www.google.com/search?q=calc"
GOTO menu

:notepad
START "" "%WINDIR%\notepad.exe"
GOTO menu

:mspaint
START "" "%WINDIR%\System32\mspaint.exe"
GOTO menu

:charmap
START "" "%WINDIR%\System32\charmap.exe"
GOTO menu

:osk
START "" "%WINDIR%\System32\osk.exe"
GOTO menu

:browser
START "" "www.google.com"
GOTO menu

:aplicaciones_din
IF NOT EXIST "%~dp0data\data_aplicaciones_din.bat" (
ECHO @ECHO OFF
ECHO SET "QN=Indefinda"
ECHO SET "QP=C:\"
ECHO SET "WN=Indefinda"
ECHO SET "WP=C:\"
ECHO SET "EN=Indefinda"
ECHO SET "EP=C:\"
ECHO SET "RN=Indefinda"
ECHO SET "RP=C:\"
ECHO SET "AN=Indefinda"
ECHO SET "AP=C:\"
ECHO SET "SN=Indefinda"
ECHO SET "SP=C:\"
ECHO SET "DN=Indefinda"
ECHO SET "DP=C:\"
ECHO SET "FN=Indefinda"
ECHO SET "FP=C:\"
ECHO SET "ZN=Indefinda"
ECHO SET "ZP=C:\"
ECHO SET "XN=Indefinda"
ECHO SET "XP=C:\"
ECHO SET "CN=Indefinda"
ECHO SET "CP=C:\"
ECHO SET "VN=Indefinda"
ECHO SET "VP=C:\"
ECHO SET "Q2N=Indefinda"
ECHO SET "Q2P=C:\"
ECHO SET "W2N=Indefinda"
ECHO SET "W2P=C:\"
ECHO SET "E2N=Indefinda"
ECHO SET "E2P=C:\"
ECHO SET "R2N=Indefinda"
ECHO SET "R2P=C:\"
ECHO SET "A2N=Indefinda"
ECHO SET "A2P=C:\"
ECHO SET "S2N=Indefinda"
ECHO SET "S2P=C:\"
ECHO SET "D2N=Indefinda"
ECHO SET "D2P=C:\"
ECHO SET "F2N=Indefinda"
ECHO SET "F2P=C:\"
ECHO SET "Z2N=Indefinda"
ECHO SET "Z2P=C:\"
ECHO SET "X2N=Indefinda"
ECHO SET "X2P=C:\"
ECHO SET "C2N=Indefinda"
ECHO SET "C2P=C:\"
ECHO SET "V2N=Indefinda"
ECHO SET "V2P=C:\
ECHO SET "Q3N=Indefinda"
ECHO SET "Q3P=C:\"
ECHO SET "W3N=Indefinda"
ECHO SET "W3P=C:\"
ECHO SET "E3N=Indefinda"
ECHO SET "E3P=C:\"
ECHO SET "R3N=Indefinda"
ECHO SET "R3P=C:\"
ECHO SET "A3N=Indefinda"
ECHO SET "A3P=C:\"
ECHO SET "S3N=Indefinda"
ECHO SET "S3P=C:\"
ECHO SET "D3N=Indefinda"
ECHO SET "D3P=C:\"
ECHO SET "F3N=Indefinda"
ECHO SET "F3P=C:\"
ECHO SET "Z3N=Indefinda"
ECHO SET "Z3P=C:\"
ECHO SET "X3N=Indefinda"
ECHO SET "X3P=C:\"
ECHO SET "C3N=Indefinda"
ECHO SET "C3P=C:\"
ECHO SET "V3N=Indefinda"
ECHO SET "V3P=C:\"
ECHO SET "Q4N=Indefinda"
ECHO SET "Q4P=C:\"
ECHO SET "W4N=Indefinda"
ECHO SET "W4P=C:\"
ECHO SET "E4N=Indefinda"
ECHO SET "E4P=C:\"
ECHO SET "R4N=Indefinda"
ECHO SET "R4P=C:\"
ECHO SET "A4N=Indefinda"
ECHO SET "A4P=C:\"
ECHO SET "S4N=Indefinda"
ECHO SET "S4P=C:\"
ECHO SET "D4N=Indefinda"
ECHO SET "D4P=C:\"
ECHO SET "F4N=Indefinda"
ECHO SET "F4P=C:\"
ECHO SET "Z4N=Indefinda"
ECHO SET "Z4P=C:\"
ECHO SET "X4N=Indefinda"
ECHO SET "X4P=C:\"
ECHO SET "C4N=Indefinda"
ECHO SET "C4P=C:\"
ECHO SET "V4N=Indefinda"
ECHO SET "V4P=C:\"
ECHO SET "Q5N=Indefinda"
ECHO SET "Q4P=C:\"
ECHO SET "W5N=Indefinda"
ECHO SET "W5P=C:\"
ECHO SET "E5N=Indefinda"
ECHO SET "E5P=C:\"
ECHO SET "R5N=Indefinda"
ECHO SET "R5P=C:\"
ECHO SET "A5N=Indefinda"
ECHO SET "A5P=C:\"
ECHO SET "S5N=Indefinda"
ECHO SET "S5P=C:\"
ECHO SET "D5N=Indefinda"
ECHO SET "D5P=C:\"
ECHO SET "F5N=Indefinda"
ECHO SET "F5P=C:\"
ECHO SET "Z5N=Indefinda"
ECHO SET "Z5P=C:\"
ECHO SET "X5N=Indefinda"
ECHO SET "X5P=C:\"
ECHO SET "C5N=Indefinda"
ECHO SET "C5P=C:\"
ECHO SET "V5N=Indefinda"
ECHO SET "V5P=C:\"
ECHO SET "Q6N=Indefinda"
ECHO SET "Q6P=C:\"
ECHO SET "W6N=Indefinda"
ECHO SET "W6P=C:\"
ECHO SET "E6N=Indefinda"
ECHO SET "E6P=C:\"
ECHO SET "R6N=Indefinda"
ECHO SET "R6P=C:\"
ECHO SET "A6N=Indefinda"
ECHO SET "A6P=C:\"
ECHO SET "S6N=Indefinda"
ECHO SET "S6P=C:\"
ECHO SET "D6N=Indefinda"
ECHO SET "D6P=C:\"
ECHO SET "F6N=Indefinda"
ECHO SET "F6P=C:\"
ECHO SET "Z6N=Indefinda"
ECHO SET "Z6P=C:\"
ECHO SET "X6N=Indefinda"
ECHO SET "X6P=C:\"
ECHO SET "C6N=Indefinda"
ECHO SET "C6P=C:\"
ECHO SET "V6N=Indefinda"
ECHO SET "V6P=C:\
) > %~dp0data\data_aplicaciones_din.bat
CALL %~dp0data\data_aplicaciones_din.bat
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %QN%
ECHO W - %WN%
ECHO E - %EN%
ECHO R - %RN%
ECHO.
ECHO A - %AN%
ECHO S - %SN%
ECHO D - %DN%
ECHO F - %FN%
ECHO.
ECHO Z - %ZN%
ECHO X - %XN%
ECHO C - %CN%
ECHO V - %VN%
ECHO.
ECHO B - Volver
ECHO N - Siguiente
ECHO.
CHOICE /N /C:1QWERASDFZXCVBN /M "->"
IF ERRORLEVEL 15 GOTO aplicaciones_din_2
IF ERRORLEVEL 14 GOTO menu
IF ERRORLEVEL 13 GOTO app_din_v
IF ERRORLEVEL 12 GOTO app_din_c
IF ERRORLEVEL 11 GOTO app_din_x
IF ERRORLEVEL 10 GOTO app_din_z
IF ERRORLEVEL 9 GOTO app_din_f
IF ERRORLEVEL 8 GOTO app_din_d
IF ERRORLEVEL 7 GOTO app_din_s
IF ERRORLEVEL 6 GOTO app_din_a
IF ERRORLEVEL 5 GOTO app_din_r
IF ERRORLEVEL 4 GOTO app_din_e
IF ERRORLEVEL 3 GOTO app_din_W
IF ERRORLEVEL 2 GOTO app_din_q
IF ERRORLEVEL 1 GOTO editbat

:editbat
START "" "%WINDIR%\notepad.exe" %~dp0data\data_aplicaciones_din.bat
GOTO menu

:app_din_q
START "" "%QP%"
GOTO menu

:app_din_w
START "" "%WP%"
GOTO menu

:app_din_e
START "" "%EP%"
GOTO menu

:app_din_r
START "" "%RP%"
GOTO menu

:app_din_a
START "" "%AP%"
GOTO menu

:app_din_s
START "" "%SP%"
GOTO menu

:app_din_d
START "" "%DP%"
GOTO menu

:app_din_f
START "" "%FP%"
GOTO menu

:app_din_z
START "" "%ZP%"
GOTO menu

:app_din_x
START "" "%XP%"
GOTO menu

:app_din_c
START "" "%CP%"
GOTO menu

:app_din_v
START "" "%VP%"
GOTO menu

:aplicaciones_din_2
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %Q2N%
ECHO W - %W2N%
ECHO E - %E2N%
ECHO R - %R2N%
ECHO.
ECHO A - %A2N%
ECHO S - %S2N%
ECHO D - %D2N%
ECHO F - %F2N%
ECHO.
ECHO Z - %Z2N%
ECHO X - %X2N%
ECHO C - %C2N%
ECHO V - %V2N%
ECHO.
ECHO B - Volver
ECHO N - Siguiente
ECHO M - Menu principal
ECHO.
CHOICE /N /C:1QWERASDFZXCVBNM /M "->"
IF ERRORLEVEL 16 GOTO menu
IF ERRORLEVEL 15 GOTO aplicaciones_din_3
IF ERRORLEVEL 14 GOTO aplicaciones_din
IF ERRORLEVEL 13 GOTO app_din_2_v
IF ERRORLEVEL 12 GOTO app_din_2_c
IF ERRORLEVEL 11 GOTO app_din_2_x
IF ERRORLEVEL 10 GOTO app_din_2_z
IF ERRORLEVEL 9 GOTO app_din_2_f
IF ERRORLEVEL 8 GOTO app_din_2_d
IF ERRORLEVEL 7 GOTO app_din_2_s
IF ERRORLEVEL 6 GOTO app_din_2_a
IF ERRORLEVEL 5 GOTO app_din_2_r
IF ERRORLEVEL 4 GOTO app_din_2_e
IF ERRORLEVEL 3 GOTO app_din_2_W
IF ERRORLEVEL 2 GOTO app_din_2_q
IF ERRORLEVEL 1 GOTO editbat

:app_din_2_q
START "" "%Q2P%"
GOTO menu

:app_din_2_w
START "" "%W2P%"
GOTO menu

:app_din_2_e
START "" "%E2P%"
GOTO menu

:app_din_2_r
START "" "%R2P%"
GOTO menu

:app_din_2_a
START "" "%A2P%"
GOTO menu

:app_din_2_s
START "" "%S2P%"
GOTO menu

:app_din_2_d
START "" "%D2P%"
GOTO menu

:app_din_2_f
START "" "%F2P%"
GOTO menu

:app_din_2_z
START "" "%Z2P%"
GOTO menu

:app_din_2_x
START "" "%X2P%"
GOTO menu

:app_din_2_c
START "" "%C2P%"
GOTO menu

:app_din_2_v
START "" "%V2P%"
GOTO menu

:aplicaciones_din_3
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %Q3N%
ECHO W - %W3N%
ECHO E - %E3N%
ECHO R - %R3N%
ECHO.
ECHO A - %A3N%
ECHO S - %S3N%
ECHO D - %D3N%
ECHO F - %F3N%
ECHO.
ECHO Z - %Z3N%
ECHO X - %X3N%
ECHO C - %C3N%
ECHO V - %V3N%
ECHO.
ECHO B - Volver
ECHO N - Siguiente
ECHO M - Menu principal
ECHO.
CHOICE /N /C:1QWERASDFZXCVBNM /M "->"
IF ERRORLEVEL 16 GOTO menu
IF ERRORLEVEL 15 GOTO aplicaciones_din_4
IF ERRORLEVEL 14 GOTO aplicaciones_din_2
IF ERRORLEVEL 13 GOTO app_din_3_v
IF ERRORLEVEL 12 GOTO app_din_3_c
IF ERRORLEVEL 11 GOTO app_din_3_x
IF ERRORLEVEL 10 GOTO app_din_3_z
IF ERRORLEVEL 9 GOTO app_din_3_f
IF ERRORLEVEL 8 GOTO app_din_3_d
IF ERRORLEVEL 7 GOTO app_din_3_s
IF ERRORLEVEL 6 GOTO app_din_3_a
IF ERRORLEVEL 5 GOTO app_din_3_r
IF ERRORLEVEL 4 GOTO app_din_3_e
IF ERRORLEVEL 3 GOTO app_din_3_W
IF ERRORLEVEL 2 GOTO app_din_3_q
IF ERRORLEVEL 1 GOTO editbat

:app_din_3_q
START "" "%Q3P%"
GOTO menu

:app_din_3_w
START "" "%W3P%"
GOTO menu

:app_din_3_e
START "" "%E3P%"
GOTO menu

:app_din_3_r
START "" "%R3P%"
GOTO menu

:app_din_3_a
START "" "%A3P%"
GOTO menu

:app_din_3_s
START "" "%S3P%"
GOTO menu

:app_din_3_d
START "" "%D3P%"
GOTO menu

:app_din_3_f
START "" "%F3P%"
GOTO menu

:app_din_3_z
START "" "%Z3P%"
GOTO menu

:app_din_3_x
START "" "%X3P%"
GOTO menu

:app_din_3_c
START "" "%C3P%"
GOTO menu

:app_din_3_v
START "" "%V3P%"
GOTO menu

:aplicaciones_din_4
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %Q4N%
ECHO W - %W4N%
ECHO E - %E4N%
ECHO R - %R4N%
ECHO.
ECHO A - %A4N%
ECHO S - %S4N%
ECHO D - %D4N%
ECHO F - %F4N%
ECHO.
ECHO Z - %Z4N%
ECHO X - %X4N%
ECHO C - %C4N%
ECHO V - %V4N%
ECHO.
ECHO B - Volver
ECHO N - Siguiente
ECHO M - Menu principal
ECHO.
CHOICE /N /C:1QWERASDFZXCVBNM /M "->"
IF ERRORLEVEL 16 GOTO menu
IF ERRORLEVEL 15 GOTO aplicaciones_din_5
IF ERRORLEVEL 14 GOTO aplicaciones_din_3
IF ERRORLEVEL 13 GOTO app_din_4_v
IF ERRORLEVEL 12 GOTO app_din_4_c
IF ERRORLEVEL 11 GOTO app_din_4_x
IF ERRORLEVEL 10 GOTO app_din_4_z
IF ERRORLEVEL 9 GOTO app_din_4_f
IF ERRORLEVEL 8 GOTO app_din_4_d
IF ERRORLEVEL 7 GOTO app_din_4_s
IF ERRORLEVEL 6 GOTO app_din_4_a
IF ERRORLEVEL 5 GOTO app_din_4_r
IF ERRORLEVEL 4 GOTO app_din_4_e
IF ERRORLEVEL 3 GOTO app_din_4_W
IF ERRORLEVEL 2 GOTO app_din_4_q
IF ERRORLEVEL 1 GOTO editbat

:app_din_4_q
START "" "%Q4P%"
GOTO menu

:app_din_4_w
START "" "%W4P%"
GOTO menu

:app_din_4_e
START "" "%E4P%"
GOTO menu

:app_din_4_r
START "" "%R4P%"
GOTO menu

:app_din_4_a
START "" "%A4P%"
GOTO menu

:app_din_4_s
START "" "%S4P%"
GOTO menu

:app_din_4_d
START "" "%D4P%"
GOTO menu

:app_din_4_f
START "" "%F4P%"
GOTO menu

:app_din_4_z
START "" "%Z4P%"
GOTO menu

:app_din_4_x
START "" "%X4P%"
GOTO menu

:app_din_4_c
START "" "%C4P%"
GOTO menu

:app_din_4_v
START "" "%V4P%"
GOTO menu

:aplicaciones_din_5
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %Q5N%
ECHO W - %W5N%
ECHO E - %E5N%
ECHO R - %R5N%
ECHO.
ECHO A - %A5N%
ECHO S - %S5N%
ECHO D - %D5N%
ECHO F - %F5N%
ECHO.
ECHO Z - %Z5N%
ECHO X - %X5N%
ECHO C - %C5N%
ECHO V - %V5N%
ECHO.
ECHO B - Volver
ECHO N - Siguiente
ECHO M - Menu principal
ECHO.
CHOICE /N /C:1QWERASDFZXCVBNM /M "->"
IF ERRORLEVEL 16 GOTO menu
IF ERRORLEVEL 15 GOTO aplicaciones_din_6
IF ERRORLEVEL 14 GOTO aplicaciones_din_4
IF ERRORLEVEL 13 GOTO app_din_5_v
IF ERRORLEVEL 12 GOTO app_din_5_c
IF ERRORLEVEL 11 GOTO app_din_5_x
IF ERRORLEVEL 10 GOTO app_din_5_z
IF ERRORLEVEL 9 GOTO app_din_5_f
IF ERRORLEVEL 8 GOTO app_din_5_d
IF ERRORLEVEL 7 GOTO app_din_5_s
IF ERRORLEVEL 6 GOTO app_din_5_a
IF ERRORLEVEL 5 GOTO app_din_5_r
IF ERRORLEVEL 4 GOTO app_din_5_e
IF ERRORLEVEL 3 GOTO app_din_5_W
IF ERRORLEVEL 2 GOTO app_din_5_q
IF ERRORLEVEL 1 GOTO editbat

:app_din_5_q
START "" "%Q5P%"
GOTO menu

:app_din_5_w
START "" "%W5P%"
GOTO menu

:app_din_5_e
START "" "%E5P%"
GOTO menu

:app_din_5_r
START "" "%R5P%"
GOTO menu

:app_din_5_a
START "" "%A5P%"
GOTO menu

:app_din_5_s
START "" "%S5P%"
GOTO menu

:app_din_5_d
START "" "%D5P%"
GOTO menu

:app_din_5_f
START "" "%F5P%"
GOTO menu

:app_din_5_z
START "" "%Z5P%"
GOTO menu

:app_din_5_x
START "" "%X5P%"
GOTO menu

:app_din_5_c
START "" "%C5P%"
GOTO menu

:app_din_5_v
START "" "%V5P%"
GOTO menu

:aplicaciones_din_6
CLS
ECHO %TIME% - %DATE%
ECHO.
ECHO 1 - Editar
ECHO.
ECHO Q - %Q6N%
ECHO W - %W6N%
ECHO E - %E6N%
ECHO R - %R6N%
ECHO.
ECHO A - %A6N%
ECHO S - %S6N%
ECHO D - %D6N%
ECHO F - %F6N%
ECHO.
ECHO Z - %Z6N%
ECHO X - %X6N%
ECHO C - %C6N%
ECHO V - %V6N%
ECHO.
ECHO B - Volver
ECHO M - Menu principal
ECHO.
CHOICE /N /C:1QWERASDFZXCVBM /M "->"
IF ERRORLEVEL 15 GOTO menu
IF ERRORLEVEL 14 GOTO aplicaciones_din_5
IF ERRORLEVEL 13 GOTO app_din_6_v
IF ERRORLEVEL 12 GOTO app_din_6_c
IF ERRORLEVEL 11 GOTO app_din_6_x
IF ERRORLEVEL 10 GOTO app_din_6_z
IF ERRORLEVEL 9 GOTO app_din_6_f
IF ERRORLEVEL 8 GOTO app_din_6_d
IF ERRORLEVEL 7 GOTO app_din_6_s
IF ERRORLEVEL 6 GOTO app_din_6_a
IF ERRORLEVEL 5 GOTO app_din_6_r
IF ERRORLEVEL 4 GOTO app_din_6_e
IF ERRORLEVEL 3 GOTO app_din_6_W
IF ERRORLEVEL 2 GOTO app_din_6_q
IF ERRORLEVEL 1 GOTO editbat

:app_din_6_q
START "" "%Q6P%"
GOTO menu

:app_din_6_w
START "" "%W6P%"
GOTO menu

:app_din_6_e
START "" "%E6P%"
GOTO menu

:app_din_6_r
START "" "%R6P%"
GOTO menu

:app_din_6_a
START "" "%A6P%"
GOTO menu

:app_din_6_s
START "" "%S6P%"
GOTO menu

:app_din_6_d
START "" "%D6P%"
GOTO menu

:app_din_6_f
START "" "%F6P%"
GOTO menu

:app_din_6_z
START "" "%Z6P%"
GOTO menu

:app_din_6_x
START "" "%X6P%"
GOTO menu

:app_din_6_c
START "" "%C6P%"
GOTO menu

:app_din_6_v
START "" "%V6P%"
GOTO menu

:browser
START www.google.com
GOTO menu

:control
START "" "%WINDIR%\System32\control.exe"
GOTO menu

:bloquear
rundll32.exe user32.dll,LockWorkStation
GOTO menu

:reiniciar
CHOICE /M "Desea Reiniciar el equipo? "
IF ERRORLEVEL 2 GOTO menu
IF ERRORLEVEL 1 shutdown /r /t 00
EXIT

:apagar
CHOICE /M "Desea Apagar el equipo? "
IF ERRORLEVEL 2 GOTO menu
IF ERRORLEVEL 1 shutdown /s /t 00
EXIT