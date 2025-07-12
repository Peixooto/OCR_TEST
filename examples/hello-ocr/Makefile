 ---------------------------------
# Repo-specific variables
# ---------------------------------
VENV_DIR := .venv
VERSION ?= $(shell cat VERSION)
export VERSION

# ---------------------------------
# Local pipeline definition
# ---------------------------------
PIPELINE := \
	- VideoIn \
		--sources 'file://hello.mov!loop' \
	- filter_optical_character_recognition.filter.FilterOpticalCharacterRecognition \
		--ocr_engine easyocr \
		--forward_ocr_texts true \
	- Webvis

# ---------------------------------
# Targets
# ---------------------------------

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.?## .$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install:  ## Install package with dev dependencies
	@if [ ! -d "$(VENV_DIR)" ]; then \
		python3 -m venv $(VENV_DIR); \
	fi
	@if [ ! -f "$(VENV_DIR)/bin/pip" ]; then \
		curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
		$(VENV_DIR)/bin/python get-pip.py && rm get-pip.py; \
	fi
	$(VENV_DIR)/bin/pip install --upgrade pip
	$(VENV_DIR)/bin/pip install -e .[dev] \
		--extra-index-url https://python.openfilter.io/simple

.PHONY: run
run:  ## Open the browser and run the filters
	@echo "Starting browser..."
	( sleep 3 && xdg-open http://localhost:8000 >/dev/null 2>&1 & )
	openfilter run $(PIPELINE)
	@echo "Running pytest..."
	$(VENV_DIR)/bin/pytest -v ocr_pytest.py