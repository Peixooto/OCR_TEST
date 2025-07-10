import json
from filter_optical_character_recognition.filter import FilterOpticalCharacterRecognition

OCR_RESULTS_PATH = "output/ocr_results.json"

def load_ocr_results():
    frames = []
    with open(OCR_RESULTS_PATH, "r", encoding="utf-8") as f:
        for line in f:
            frames.append(json.loads(line))
    return frames

def test_ocr_text_extraction():
    frames = load_ocr_results()
    assert len(frames) > 0, "No processed frames."
    
    expected_text = "Hello World"
    texts = []
    for frame in frames:
        texts.extend(frame.get("texts", []))

    assert any(expected_text in text for text in texts), f"'{expected_text}' not found in any frame."

def test_filter_config_acceptance():
    config = {
        "ocr_engine": "easyocr",
        "forward_ocr_texts": True,
    }
    filter_instance = FilterOpticalCharacterRecognition(config=config)
    assert filter_instance.config["ocr_engine"].value == "easyocr"
    assert filter_instance.config["forward_ocr_texts"] is True

def test_all_frames_have_ocr_texts():
    frames = load_ocr_results()
    assert len(frames) > 0, "No frames processed."

    # frames_without_text = [idx for idx, frame in enumerate(frames) if not frame.get("texts")]
    # allowed_empty_frames = 2  # por exemplo

    # assert len(frames_without_text) <= allowed_empty_frames, (
    #     f"Too many frames without OCR texts: {frames_without_text}")

    # this script below identified frame failure when executing .mov, in some moments we have no failure

    for idx, frame in enumerate(frames):
        texts = frame.get("texts", [])
        assert isinstance(texts, list), f"{idx} frame contains no text list."
        assert len(texts) > 0, f"{idx} frame no OCR texts detected."