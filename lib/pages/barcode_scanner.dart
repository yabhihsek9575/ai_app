import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  String data = 'Select the Image\nto Scan barCode.';
  final BarcodeDetector barcodeDetector =
      GoogleVision.instance.barcodeDetector();

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
                  onPressed: () => scanBarCode(source: ImageSource.camera),
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
                onPressed: () => scanBarCode(source: ImageSource.gallery),
              )
            ],
          )
        ],
      ),
    ));
  }

  scanBarCode({required ImageSource source}) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);

    final List<Barcode> barcodes = await barcodeDetector.detectInImage(
      GoogleVisionImage.fromFile(
        File(pickedImage?.path ?? ''),
      ),
    );

    for (Barcode barcode in barcodes) {
      final Rect? boundingBox = barcode.boundingBox;
      final List<Offset> cornerPoints = barcode.cornerPoints;

      final String? rawValue = barcode.rawValue;

      final BarcodeValueType valueType = barcode.valueType;

      // See API reference for complete list of supported types
      final String? ssid, password, title, url;
      final BarcodeWiFiEncryptionType type;

      switch (valueType) {
        case BarcodeValueType.wifi:
          ssid = barcode.wifi?.ssid;
          password = barcode.wifi?.password;
          type = barcode.wifi!.encryptionType;
          setState(() {
            data = '$ssid, $password, $type';
          });
          break;
        case BarcodeValueType.url:
          title = barcode.url?.title;
          url = barcode.url?.url;
          setState(() {
            data = '$title, $url';
          });
          break;
        case BarcodeValueType.unknown:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.contactInfo:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.email:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.isbn:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.phone:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.product:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.sms:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.text:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.geographicCoordinates:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.calendarEvent:
          // TODO: Handle this case.
          break;
        case BarcodeValueType.driverLicense:
          // TODO: Handle this case.
          break;
      }
    }
  }
}
