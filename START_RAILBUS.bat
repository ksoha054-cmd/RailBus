@echo off
setlocal
cd /d "%~dp0backend"
echo =============================================
echo   RAILBUS - MYSURU SHARED BACKEND
echo =============================================
echo Passenger:  http://localhost:3000/passenger/
echo Admin:      http://localhost:3000/admin/
echo Conductor:  http://localhost:3000/conductor/
echo.
echo Keep this window open while using RailBus.
echo Press Ctrl+C to stop the server.
echo.
node server.js
if errorlevel 1 (
  echo.
  echo Could not start RailBus. Ensure Node.js is installed and port 3000 is free.
  pause
)
