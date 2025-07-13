# OpenFilter Challenge
 This challenge uses CLI and the pipeline with docker!

## Installation

Install OpenFilter with all utility filter dependencies manually:

```bash
pip install openfilter[all]
pip install -e .[dev]
```

## Running CLI
    Use for Windows OS: 

    source /app/hello-ocr
```bash
    openfilter run `
  - VideoIn `
    --sources 'file://hello.mov' `
  - filter_optical_character_recognition.filter.FilterOpticalCharacterRecognition `
    --ocr_engine easyocr `
    --forward_ocr_texts true `
    --outputs 'tcp://*:5552' `
  - Webvis `
    --sources 'tcp://localhost:5552'
```

    For unit tests:
    - pytest ocr_pytest.py

------------------------------
    Use for Linux:

     source /app/hello-ocr

```bash
     openfilter run \
  - VideoIn \
    --sources 'file://hello.mov' \
  - filter_optical_character_recognition.filter.FilterOpticalCharacterRecognition \
    --ocr_engine easyocr \
    --forward_ocr_texts true \
    --outputs 'tcp://*:5552' \
  - Webvis \
    --sources 'tcp://localhost:5552'
```

    For unit tests:
    - pytest ocr_pytest.py


## Running with .bat for Windows OS
 source/hello-ocr

 execute: ./run.bat

 waiting for pipeline and tests running

 for clean yout workspace: ./end.bat
  - end.bat will delete everything that has been done with run.bat


 ## Running with docker-compose

 You must have docker in your OS (docker desktop for windows)

 - souce/hello-ocr
 - docker compose build
 - docker compose up