import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingreAuth extends StatefulWidget {
  const FingreAuth({Key? key}) : super(key: key);

  @override
  State<FingreAuth> createState() => _FingreAuthState();
}

class _FingreAuthState extends State<FingreAuth> {
  bool isAuth = false;
  var checkSensor = 'Inital';
  bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Fingreprint',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  'Recognisation',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: _checkBiometric,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 4) * 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      !authenticated ? 'Click Here to check' : 'Checked',
                      style: TextStyle(
                          fontSize: 25,
                          color: authenticated ? Colors.orange : Colors.white),
                    ),
                  ),
                  const Icon(
                    Icons.fingerprint_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    !authenticated
                        ? 'Touch here to\ncheck Scanner'
                        : 'Scanner Working\nFine.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void _checkBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    List<BiometricType>? availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics?.isNotEmpty ?? false) {
      availableBiometrics?.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Touch your finger on the sensor to Check',
        // useErrorDialogs: true,
        // stickyAuth: false,
        // androidAuthStrings:
        //     AndroidAuthMessages(signInTitle: "Login to HomePage"),
      );
    } catch (e) {
      print("error using biometric auth: $e");
    }
    setState(() {
      if (authenticated) {
        checkSensor = 'Done';
      } else {
        checkSensor = 'Inital';
      }
      var isAuth = authenticated ? true : false;
    });

    print("authenticated: $authenticated");
  }
}
