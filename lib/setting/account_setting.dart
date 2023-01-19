import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precoder/main.dart';
import 'package:precoder/setting/account_information.dart';
import 'package:precoder/setting/account_edit.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Settings",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 0, 105, 120),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountInformationPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB4FFFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            width: 3, color: Color(0xFF006978))),
                  ),
                  child: const Text(
                    "Account Information",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountEditPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB4FFFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            width: 3, color: Color(0xFF006978))),
                  ),
                  child: const Text(
                    "Edit Account",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 350,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    logout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB4FFFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            width: 3, color: Color(0xFF006978))),
                  ),
                  child: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainPage(
              title: 'PreCoder',
            )));
  }
}
