from openfilter.filter_runtime.filter import Filter
from openfilter.filter_runtime.filters.video_in import VideoIn
from openfilter.filter_runtime.filters.webvis import Webvis
from filter_optical_character_recognition.filter import FilterOpticalCharacterRecognition
from filter_license_plate_detection.filter import FilterLicensePlateDetection

if __name__ == '__main__':
    Filter.run_multi([
        (VideoIn, dict(
            sources='file://hello.mov!loop',
            outputs=['tcp://*:5554', 'tcp://*:5556'],
        )),
        (FilterOpticalCharacterRecognition, dict(
            sources='tcp://localhost:5554',
            outputs='tcp://*:5552',
            ocr_engine='easyocr',
            forward_ocr_texts=True,
        )),
        (FilterLicensePlateDetection, dict(
            sources='tcp://localhost:5556',
            outputs='tcp://*:5558',
        )),
        (Webvis, dict(
            sources=['tcp://localhost:5552', 'tcp://localhost:5558'],
        )),
    ])
