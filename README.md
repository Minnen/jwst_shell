# Introducción

**JWST** es un archivo _`batch`_ que contiene un conjunto de instrucciones MS-DOS para realizar muchas de las funciones del GUI/Shell nativo de Windows (`explorer.exe`) usando principalmente el teclado. Está pensado para entornos donde se prefiere una interacción por teclado o para administradores que necesiten un shell ligero y personalizable.

## Características

- Interfaz orientada al teclado (sin depender del ratón).
- Conjunto modular de comandos y scripts en `modulos/` y `scripts/`.
- Funciones para controlar procesos comunes (ej.: `kill_steam.bat`, `kill_discord.bat`).
- Fácil personalización mediante archivos `.bat` en la carpeta del proyecto.

## Requisitos del sistema

- Windows 7/8/10/11 (probado en versiones modernas de Windows 10/11).
- Permisos de administrador para cambiar el `Shell` en el registro.
- Se recomienda probar en una máquina virtual antes de aplicarlo en sistemas de producción.

## Instalación

IMPORTANTE: Cambiar el `Shell` del sistema puede dejar el sistema inaccesible si hay errores. Haga un `backup` del registro y pruebe primero en una VM o con una cuenta de prueba.

Pasos resumidos:

1. Respaldar `README.md` y el estado actual del registro:

```powershell
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Winlogon-backup.reg"
copy README.md README.md.bak
```

2. Mover la carpeta `jwst_shell` a `%APPDATA%` (por usuario):

```powershell
Move-Item -Path .\jwst_shell -Destination "$Env:APPDATA" -Force
# Resultado esperado: C:\Users\<Usuario>\AppData\Roaming\jwst_shell
```

3. Opciones para establecer el `Shell`:

- Opción segura (recomendado para pruebas): editar `Shell` en `HKCU` (usuario actual). Esto evita afectar a otros usuarios del sistema, pero **algunas versiones de Windows esperan `Shell` en `HKLM`**.

```powershell
# Ejecutar como administrador si modifica HKLM
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "%APPDATA%\\jwst_shell\\jwst.bat" /f
```

- Opción global (cambia el shell del sistema — requiere admin):

```powershell
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "C:\\Users\\%USERNAME%\\AppData\\Roaming\\jwst_shell\\jwst.bat" /f
```

4. Reiniciar el equipo para que los cambios surtan efecto.

5. Si necesita volver a `explorer.exe`:

```powershell
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "explorer.exe" /f
```

O usar el archivo de respaldo:

```powershell
reg import Winlogon-backup.reg
```

## Uso básico

- Ejecutar `jwst.bat` manualmente para probar sin reiniciar: abra una consola con privilegios de usuario y ejecute:

```powershell
"%APPDATA%\\jwst_shell\\jwst.bat"
```

- Estructura principal del repositorio:

- `modulos/`: módulos agrupados por funcionalidad.
- `scripts/`: utilidades y scripts listos para ejecutar.
- `jwst.bat`: script principal que arranca la interfaz.

## Personalización

- Añada nuevos comandos creando archivos `.bat` en `scripts/` o `modulos/`.
- Mantenga las modificaciones en ramas o copias si colabora con varios usuarios.

## Recuperación y precauciones

- Si el `Shell` falla y no arranca sesión gráfica, inicie en Modo Seguro o use la consola de recuperación para restaurar el valor de `Shell` a `explorer.exe` o importe el respaldo del registro.
- Cree un punto de restauración antes de cambios críticos.

## Contribuir

1. Cree un `issue` describiendo el problema o la mejora.
2. Envíe un `pull request` con cambios claros y pequeños.
3. Mantenga estilo de código consistente con los `.bat` existentes.

## Licencia

Vibes are free, Kopimi.
CC0 1.0 Universal.

## Contacto

Para preguntas, issues o propuestas, abre un `issue` en el repositorio o contacta al mantenedor.