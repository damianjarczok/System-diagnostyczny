@echo off
setlocal EnableDelayedExpansion

REM ===== CONFIGURATION =====
set PYTHON_VERSION_OK=0
set DESIRED_PYTHON_VERSION=3.10.11
set PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe
set PYTHON_INSTALLER=python-3.10.11-amd64.exe
set APP_FOLDER=%~dp0diagnostyka_app
set VENV_FOLDER=%~dp0venv
set REQUIREMENTS_FILE=%~dp0requirements.txt

echo ===============================================
echo     Initializing diagnostic environment
echo ===============================================

REM ===== CHECK PYTHON VERSION =====
python --version > temp_pyver.txt 2>&1
for /f "tokens=2 delims= " %%i in (temp_pyver.txt) do set PYVER=%%i
del temp_pyver.txt

for /f "tokens=1,2 delims=." %%a in ("!PYVER!") do (
    set MAJOR=%%a
    set MINOR=%%b
)

if "!MAJOR!"=="3" (
    if !MINOR! LSS 12 (
        set PYTHON_VERSION_OK=1
    )
)

if !PYTHON_VERSION_OK!==1 (
    echo [INFO] Detected Python version: !PYVER!
) else (
    echo [WARNING] Python version !PYVER! is not supported.
    echo [INFO] Installing Python !DESIRED_PYTHON_VERSION!...

    if not exist "%~dp0%PYTHON_INSTALLER%" (
        echo [INFO] Downloading Python installer...
        powershell -Command "Invoke-WebRequest -Uri '%PYTHON_INSTALLER_URL%' -OutFile '%PYTHON_INSTALLER%'"
    )

    if exist "%~dp0%PYTHON_INSTALLER%" (
        echo [INFO] Installing Python...
        %PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    ) else (
        echo [ERROR] Failed to download Python installer.
        pause
        exit /b
    )

    echo.
    echo [INFO] Python installation completed.
    echo [INFO] Please close this window and re-run the .bat file.
    pause
    exit /b
)

REM ===== CREATE VENV =====
if not exist "%VENV_FOLDER%" (
    echo [INFO] Creating virtual environment...
    python -m venv "%VENV_FOLDER%"
) else (
    echo [INFO] Virtual environment already exists — skipping creation.
)

REM ===== ACTIVATE VENV =====
call "%VENV_FOLDER%\Scripts\activate"

REM ===== UPDATE PIP =====
echo [INFO] Updating pip...
python -m pip install --upgrade pip

REM ===== INSTALL DEPENDENCIES =====
echo [INFO] Installing required packages...
pip install numpy==1.24.3 six==1.17.0 wheel setuptools
pip install -r "%REQUIREMENTS_FILE%"

if errorlevel 1 (
    echo [ERROR] Package installation failed.
    pause
    exit /b
)

REM ===== RUN DJANGO APP =====
cd /d "%APP_FOLDER%"
echo [INFO] Starting Django application...
python manage.py runserver

pause