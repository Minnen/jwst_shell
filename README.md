# JWST

**JWST** es un archivo _`batch`_ que contiene un conjunto de instrucciones MS-DOS. Cuando se ejecuta este archivo, las órdenes contenidas son ejecutadas en grupo, de forma secuencial, permitiendo reemplazar el shell nativo de windows _`explorer.exe`_.

# Instalacion

## Opcion 1
> Modificacion manual del registro

1. Mover el archivo `jwst.bat` a la carpeta `C:\Windows`.
2. Presionar las teclas `win+r` y ejecutar el comando `regedit`.
3. En el editor de registro navegar hasta `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`.
4. Buscar y cambiar el valor `Shell` de `explorer.exe` por `jwst.bat`