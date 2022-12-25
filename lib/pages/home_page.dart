import 'package:ai_app/pages/barcode_scanner.dart';
import 'package:ai_app/pages/face_recognisation.dart';
import 'package:ai_app/pages/fingrprint_recognisation.dart';
import 'package:ai_app/pages/text_recognisation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Functions',
                  style: TextStyle(fontSize: 45),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 3),
                  child: const Text(
                    'by Abhishek',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                function_card(
                  onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => FingreAuth()))),
                  Title: 'Fingreprint Recognisation',
                  Subtitle: 'Please enroll your fingrprint before checking.',
                  displayIcon: const Icon(
                    Icons.fingerprint,
                    color: Colors.greenAccent,
                    size: 35,
                  ),
                ),
                function_card(
                  onClick: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const FacceRecognisation()))),
                  Title: 'Face Recognisation',
                  Subtitle: 'Count the number of persons in picture.',
                  displayIcon: const Icon(
                    Icons.face,
                    color: Colors.greenAccent,
                    size: 35,
                  ),
                ),
                function_card(
                  onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const TextRecogisation()),
                    ),
                  ),
                  Title: 'Text Recognisation',
                  Subtitle: 'Code to seprate text from image.',
                  displayIcon: const Icon(
                    Icons.adf_scanner,
                    color: Colors.greenAccent,
                    size: 35,
                  ),
                ),
                function_card(
                  onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const BarcodeScanner()),
                    ),
                  ),
                  Title: 'Scan Bar Code',
                  Subtitle: 'Scan Bar code in the image.',
                  displayIcon: const Icon(
                    Icons.qr_code,
                    color: Colors.greenAccent,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget function_card(
      {required Function()? onClick,
      required String Title,
      required String Subtitle,
      required Icon displayIcon}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: displayIcon,
                  flex: 1,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Title,
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          Subtitle,
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  flex: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
