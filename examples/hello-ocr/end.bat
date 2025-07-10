clean
echo Cleaning...

if exist venv (
    echo Deleting venv...
    rmdir /S /Q venv
) else (
    echo venv does not exists.
)

for /d /r %%d in (__pycache__) do (
    echo Cleaning cache on %%d
    rmdir /S /Q "%%d"
)

if exist output\ocr_results.json (
    echo Cleaning output/ocr_results.json
    del /Q output\ocr_results.json
) else (
    echo output/ocr_results.json does not exists.
)

echo Clean complete.
goto :eof