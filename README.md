# Introduccion

**JWST** es un archivo _`batch`_ que contiene un conjunto de instrucciones MS-DOS que permiten llevar a cabo todas las funciones que se encuentran normalmente en el GUI/Shell nativo de windows `explorer.exe`, pero utilizando de manera practicamente exclusiva el teclado.

# Instalacion

1. Mover el archivo `jwst.bat` a la carpeta `C:\Windows`.
2. Presionar las teclas `win+r` y ejecutar el comando `regedit`.
3. En el editor de registro navegar hasta `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`.
4. Buscar y cambiar el valor `Shell` de `explorer.exe` por `jwst.bat`.

# Requisitos

En caso de utilizar JWST en una laptop es necesario descargar e instalar previamente el asistente de configuración de red [*NetSetMan*](https://www.netsetman.com/es/freeware), esto es devido a que no es posible crear/conectar perfiles WiFi que no hayan sido preconfigurados previo al reemplazo del shell.