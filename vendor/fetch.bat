@echo off
rem vendor\fetch.bat — duplo clique para popular o vendor/ no Windows.
rem Passa -ExecutionPolicy Bypass para contornar politicas restritivas.
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0fetch.ps1"
pause
