@echo off
SETLOCAL
SET VENV_DIR=venv

IF NOT EXIST "%VENV_DIR%\Scripts\activate.bat" (
    echo no venv. Creating...
    python -m venv %VENV_DIR%
)

echo Starting Venv...
call %VENV_DIR%\Scripts\activate.bat

echo Install dependencies...
pip install -e .[dev] --extra-index-url https://python.openfilter.io/simple

echo Starting chrome in incognito mode for compatibility

start "" "chrome" --incognito  http://localhost:8000
timeout /t 5 > nul

tasklist /FI "IMAGENAME eq chrome.exe" | find /I "chrome.exe" > nul

if %ERRORLEVEL%==0 (
  echo Chrome is running
) else ( 
  echo Chrome did not start, try again
  )

echo Executing openfilter pipeline...

start openfilter run ^
 - VideoIn --sources "file://hello.mov!loop" ^
 - filter_optical_character_recognition.filter.FilterOpticalCharacterRecognition ^
   --ocr_engine easyocr ^
   --forward_ocr_texts true ^
 - Webvis --sources "tcp://localhost:5552"

timeout /t 55

echo Final openfilter..
taskkill /F /IM python.exe > nul 2>&1
 echo Executing unit testes with pytest...
pytest ocr_pytest.py

echo End of pipeline

ENDLOCAL
