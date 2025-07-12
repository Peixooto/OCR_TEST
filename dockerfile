FROM python:3.11-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 libgl1-mesa-glx curl build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

RUN pip install --extra-index-url https://python.openfilter.io/simple ".[dev]"

EXPOSE 8000


CMD bash -c "\
     openfilter run \
     - VideoIn --sources file://hello.mov \
     - filter_optical_character_recognition.filter.FilterOpticalCharacterRecognition \
     --ocr_engine easyocr --forward_ocr_texts true \
     - Webvis --sources tcp://localhost:5552 && \
  pid=$!; \
  sleep 2 && \
  echo 'running pytest...' && \
  pytest -v ocr_pytest.py \
  kill $pid \
"