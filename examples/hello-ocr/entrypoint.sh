#!/bin/bash
set -e
set -x
echo "Starting pipeline..."

openfilter run \
  - VideoIn --sources file://hello.mov!loop \
  - filter_optical_character_recognition.filter.FilterOpticalCharacterRecognition \
    --ocr_engine easyocr --forward_ocr_texts true \
  - Webvis --sources tcp://localhost:5552 &

pid=$!
sleep 30

echo "Running tests..."
pytest -v ocr_pytest.py

echo "End..."
kill $pid
