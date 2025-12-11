@ECHO OFF

@TITLE JWST - Modulo Wi-Fi

CHCP 65001 >NUL
CLS

:: Verificar adaptador Wi-Fi
NETSH WLAN SHOW INTERFACES >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO.
    ECHO No se detecta adaptador Wi-Fi o esta desactivado.
    ECHO Activalo en Configuracion - Red e Internet.
    PAUSE >NUL
    EXIT
)

ECHO Buscando redes Wi-Fi disponibles...
ECHO.

DEL "%TEMP%\wifi_raw.txt" 2>NUL
NETSH WLAN SHOW NETWORKS MODE=BSSID | FINDSTR /R "SSID" > "%TEMP%\wifi_raw.txt"

DEL "%TEMP%\wifi_list.txt" 2>NUL
FOR /F "TOKENS=2,* DELIMS=:" %%A IN ('TYPE "%TEMP%\wifi_raw.txt"') DO (
    ECHO %%B>> "%TEMP%\wifi_list.txt"
)

IF NOT EXIST "%TEMP%\wifi_list.txt" (
    ECHO No hay redes visibles en este momento.
    PAUSE >NUL
    EXIT
)

SETLOCAL ENABLEDELAYEDEXPANSION
SET COUNT=0
FOR /F "USEBACKQ SKIP=4 DELIMS=" %%A IN ("%TEMP%\wifi_list.txt") DO (
    IF "%%A"=="" GOTO continuar
    SET /A COUNT+=1
    SET "RED[!COUNT!]=%%A"
)

:continuar
IF %COUNT%==0 (
    ECHO No se detectaron redes.
    PAUSE >NUL
    EXIT
)

SET SEL=1

:menu
CLS
ECHO ==========================================
ECHO        SELECCIONA RED WI-FI
ECHO ==========================================
ECHO.
FOR /L %%I IN (1,1,%COUNT%) DO (
    IF %%I==%SEL% (
        ECHO  --> !RED[%%I]!
    ) ELSE (
        ECHO     !RED[%%I]!
    )
)
ECHO.
ECHO Usa flechas arriba/abajo - ENTER conectar - ESC salir

CHOICE /C:8S9K >NUL
IF ERRORLEVEL 4 GOTO salir
IF ERRORLEVEL 3 GOTO conectar
IF ERRORLEVEL 2 IF %SEL% LSS %COUNT% SET /A SEL+=1
IF ERRORLEVEL 1 IF %SEL% GTR 1 SET /A SEL-=1
GOTO menu

:conectar
SET "RED_ELEGIDA=!RED[%SEL%]!"
ECHO.
ECHO Conectando a: !RED_ELEGIDA!
SET "PASS="
SET /P "PASS=Clave Wi-Fi (deja vacio si es abierta): "

IF "%PASS%"=="" (
    NETSH WLAN CONNECT NAME="!RED_ELEGIDA!"
) ELSE (
    NETSH WLAN CONNECT NAME="!RED_ELEGIDA!" KEY="%PASS%"
)

ECHO.
ECHO Intentando conectar...
TIMEOUT /T 6 >NUL
NETSH WLAN SHOW INTERFACES | FINDSTR "Estado SSID"
ECHO.
ECHO Presiona cualquier tecla para volver al menu de modulos...
PAUSE >NUL
EXIT

:salir
ECHO.
ECHO Saliendo del modulo Wi-Fi...
TIMEOUT /T 2 >NUL
EXIT