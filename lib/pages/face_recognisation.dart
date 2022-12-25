import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class FacceRecognisation extends StatefulWidget {
  const FacceRecognisation({Key? key}) : super(key: key);

  @override
  State<FacceRecognisation> createState() => _FacceRecognisationState();
}

class _FacceRecognisationState extends State<FacceRecognisation> {
  final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
  String data = 'Select the Image\nto Count Peoples.';

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
                  data,
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
                  onPressed: () => detect_face(source: ImageSource.camera),
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
                onPressed: () => detect_face(source: ImageSource.gallery),
              )
            ],
          )
        ],
      ),
    ));
  }

  detect_face({required ImageSource source}) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);

    final List<Face> faces = await faceDetector.processImage(
      GoogleVisionImage.fromFile(
        File(pickedImage?.path ?? ''),
      ),
    );

    setState(() {
      if (faces.isNotEmpty) {
        data = '${faces.length} Peoples in the\nImage';
      } else {
        data = 'No Face Detected';
      }
    });

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;

      final double? rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double? rotZ =
          face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

      // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      final FaceLandmark? leftEar = face.getLandmark(FaceLandmarkType.leftEar);
      if (leftEar != null) {
        final Offset leftEarPos = leftEar.position;
      }

      // If classification was enabled with FaceDetectorOptions:
      if (face.smilingProbability != null) {
        final double? smileProb = face.smilingProbability;
      }

      // If face tracking was enabled with FaceDetectorOptions:
      if (face.trackingId != null) {
        final int? id = face.trackingId;
      }
    }
  }
}
