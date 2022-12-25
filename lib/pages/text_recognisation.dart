import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class TextRecogisation extends StatefulWidget {
  const TextRecogisation({Key? key}) : super(key: key);

  @override
  State<TextRecogisation> createState() => _TextRecogisationState();
}

class _TextRecogisationState extends State<TextRecogisation> {
  String picked_text = 'Picked text will be displayed here';
  final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  picked_text,
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  color: Colors.blue,
                  child: const Expanded(child: Text('Camera')),
                  onPressed: () =>
                      pickTextFromImage(source: ImageSource.camera),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Colors.blue,
                child: const Expanded(child: Text('Gallery')),
                onPressed: () => pickTextFromImage(source: ImageSource.gallery),
              )
            ],
          )
        ],
      ),
    ));
  }

  pickTextFromImage({required ImageSource source}) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);

    final VisionText visionText = await textRecognizer.processImage(
      GoogleVisionImage.fromFile(
        File(pickedImage?.path ?? ''),
      ),
    );
    setState(() {
      picked_text = visionText.text ?? 'No Text Found.';
    });
  }
}
