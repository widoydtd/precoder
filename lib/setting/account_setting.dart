import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precoder/home.dart';
import 'package:precoder/model/user_model.dart';
import 'package:precoder/main.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Settings",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(255, 0, 105, 120),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 350,
              child: TextField(
                decoration: InputDecoration(labelText: 'New username'),
                onChanged: (value) =>
                    setState(() => loggedInUser.username = value),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 350,
              child: TextField(
                decoration: InputDecoration(labelText: 'New email'),
                onChanged: (value) =>
                    setState(() => loggedInUser.email = value),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 350,
              child: ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  await updateUserInfo();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 0, 105, 120))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 350,
              alignment: Alignment.center,
              child: Text(
                "Or",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 350,
              child: ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    logout(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateUserInfo() async {
    final User? user = await FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'username': loggedInUser.username,
        'fullname': loggedInUser.fullname
      });
      // Update successful, show a message to the user
    } catch (e) {
      // An error occurred, show the error message to the user
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainPage(
              title: 'PreCoder',
            )));
  }
}
