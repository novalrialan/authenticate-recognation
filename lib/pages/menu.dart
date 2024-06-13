import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  // NAME ROUTE
  static const nameRoute = '/menupage';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isAvailable = false;
  bool isAuthenticated = false;

  String text = "Please Check Biometric Availabilty";
  LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biometric Authentication"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Center(
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(bottom: 6),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.orange),
                          ),
                          child: const Text('Check Biometrics '),
                          onPressed: () async {
                            isAvailable =
                                await localAuthentication.canCheckBiometrics;
                            print(isAvailable);
                            if (isAvailable) {
                              List<BiometricType> types =
                                  await localAuthentication
                                      .getAvailableBiometrics();
                              text = 'Biometrics Available :';
                              for (var item in types) {
                                text += "\n - $item";
                              }
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(bottom: 6),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.lightBlue),
                          ),
                          child: Text('Authenticate'),
                          onPressed: isAvailable
                              ? () async {
                                  isAuthenticated =
                                      await localAuthentication.authenticate(
                                    localizedReason:
                                        'Scan your fingerprint (or face) to authenticate ',
                                    options: const AuthenticationOptions(
                                      useErrorDialogs: true,
                                      stickyAuth: true,
                                    ),
                                  );
                                  setState(() {});
                                }
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isAuthenticated ? Colors.green : Colors.red,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  spreadRadius: 2)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.grey[200],
            child: Center(child: Text(text)),
          )
        ],
      ),
    );
  }
}
