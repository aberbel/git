@echo off
setlocal

set "HOOKS_DIR=%USERPROFILE%\.git_templates\hooks"
set "PRECOMMIT_FILE=%HOOKS_DIR%\pre-commit"
set "PREMERGE_FILE=%HOOKS_DIR%\pre-merge-commit"
set "INIT_TEMPLATE_DIR="

for /f "delims=" %%i in ('git config --global init.templateDir 2^>nul') do set "INIT_TEMPLATE_DIR=%%i"

if defined INIT_TEMPLATE_DIR (
    echo init.templateDir actual: "%INIT_TEMPLATE_DIR%"
    set /p "CAMBIAR=Quieres cambiarlo y continuar con la configuracion? (s/n): "
    goto VALIDAR_RESPUESTA
) else (
    echo init.templateDir no esta configurado. Se ejecutara la configuracion completa.
    goto CONTINUAR
)

:VALIDAR_RESPUESTA
set "CAMBIAR=%CAMBIAR: =%"
if /I "%CAMBIAR%"=="s" goto CONTINUAR
if /I "%CAMBIAR%"=="si" goto CONTINUAR
echo No se realizaron cambios.
exit /b 0

:CONTINUAR

echo [1/3] Creando carpeta de hooks en "%HOOKS_DIR%"...
if not exist "%HOOKS_DIR%" (
    mkdir "%HOOKS_DIR%"
)

echo [2/3] Configurando git init.templateDir global...
git config --global init.templateDir "%USERPROFILE%\.git_templates"
if errorlevel 1 (
    echo Error: no se pudo ejecutar "git config --global init.templateDir".
    exit /b 1
)

echo [3/5] Creando hook pre-commit en "%PRECOMMIT_FILE%"...
(
    echo #!/bin/sh
    echo.
    echo # 1. Obtiene el nombre de la rama actual
    echo BRANCH=$(git rev-parse --abbrev-ref HEAD^)
    echo.
    echo # 2. Evalua el nombre de la rama
    echo case "$BRANCH" in
    echo   desa^|prep^|pro^)
    echo     echo "Error: No puedes hacer commits directos en la rama '$BRANCH'."
    echo     echo "Por favor, trabaja en una rama de caracteristicas y haz un Pull Request / Merge."
    echo     exit 1
    echo     ;;
    echo   *^)
    echo     # Permitir el commit en cualquier otra rama
    echo     exit 0
    echo     ;;
    echo esac
) > "%PRECOMMIT_FILE%"

if errorlevel 1 (
    echo Error: no se pudo crear el fichero pre-commit.
    exit /b 1
)

echo [4/5] Creando hook pre-merge-commit en "%PREMERGE_FILE%"...
(
    echo #!/bin/sh
    echo.
    echo # 1. Obtiene la rama destino del merge
    echo TARGET_BRANCH=$(git rev-parse --abbrev-ref HEAD^)
    echo.
    echo # 2. Obtiene la rama origen a partir de MERGE_HEAD
    echo SOURCE_BRANCH=""
    echo MERGE_HEAD_FILE=$(git rev-parse --git-path MERGE_HEAD^)
    echo if [ -f "$MERGE_HEAD_FILE" ]; then
    echo   SOURCE_COMMIT=$(cat "$MERGE_HEAD_FILE"^)
    echo   SOURCE_BRANCH=$(git name-rev --name-only --refs='refs/heads/*' "$SOURCE_COMMIT" 2^>/dev/null ^| cut -d'~' -f1 ^| cut -d'^' -f1^)
    echo fi
    echo.
    echo # 3. Detecta si origen y destino son ramas protegidas
    echo TARGET_PROTECTED=0
    echo SOURCE_PROTECTED=0
    echo case "$TARGET_BRANCH" in
    echo   desa^|prep^|pro^) TARGET_PROTECTED=1 ;;
    echo esac
    echo case "$SOURCE_BRANCH" in
    echo   desa^|prep^|pro^) SOURCE_PROTECTED=1 ;;
    echo esac
    echo.
    echo # 4. Bloquea merge entre ramas protegidas
    echo if [ "$TARGET_PROTECTED" = "1" ] ^&^& [ "$SOURCE_PROTECTED" = "1" ]; then
    echo   echo "Error: No se permite mergear entre ramas protegidas ('desa', 'prep', 'pro')."
    echo   echo "Crea una rama intermedia y usa Pull Request para promover cambios."
    echo   exit 1
    echo fi
    echo.
    echo exit 0
) > "%PREMERGE_FILE%"

if errorlevel 1 (
    echo Error: no se pudo crear el fichero pre-merge-commit.
    exit /b 1
)

echo.
echo [5/5] Ejecutando git init en el repositorio actual...
git init
if errorlevel 1 (
    echo Error: no se pudo ejecutar git init.
    exit /b 1
)

echo Completado. Configuracion aplicada y git init ejecutado.
endlocal