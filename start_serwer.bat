@echo off
cd /d "%~dp0diagnostyka_app"
call ..\venv\Scripts\activate
python manage.py runserver
pause
