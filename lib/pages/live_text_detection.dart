import 'dart:async';
import 'dart:io';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:flutter/material.dart';

class LiveTextDetection extends StatefulWidget {
  const LiveTextDetection({Key? key}) : super(key: key);

  @override
  State<LiveTextDetection> createState() => _LiveTextDetectionState();
}

class _LiveTextDetectionState extends State<LiveTextDetection> {
  late final String _imagePath;
  late final TextRecognizer textRecognizer;

  @override
  void initState() {
    // TODO: implement initState
    textRecognizer = GoogleVision.instance.textRecognizer();
    _recognizTexts();
    super.initState();
  }

  void _recognizTexts() async {
    // Creating an InputImage object using the image path
    final inputImage = GoogleVisionImage.fromFilePath(_imagePath);
    // Retrieving the RecognisedText from the InputImage
    final text = await textRecognizer.processImage(inputImage);
    // Finding text String(s)
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        print('text: ${line.text}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
