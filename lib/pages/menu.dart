import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobilerecognition/services/local_auth_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  // NAME ROUTE
  static const nameRoute = '/menupage';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // String text = "Please Check Biometric Availabilty";

  bool authenticated = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometric Authentication"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.lightBlue),
              ),
              onPressed: () async {
                final authenticate = await LocalAuth.authenticate();
                setState(() {
                  authenticated = authenticate;
                });
              },
              child: authenticated
                  ? Text('Authenticate')
                  : Text("You are auhenticated"),
            ),
          ],
        ),
      ),
    );
  }
}
