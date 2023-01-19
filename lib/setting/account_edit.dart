import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precoder/model/user_model.dart';

class AccountEditPage extends StatefulWidget {
  const AccountEditPage({super.key});

  @override
  State<AccountEditPage> createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Account",
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
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: 350,
                child: ExpansionTile(
                  key: GlobalKey(),
                  title: const Text(
                    "Change Username",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: const Text("Current username:"),
                      subtitle: Text("${loggedInUser.username}"),
                    ),
                    ListTile(
                      title: const Text("New username:"),
                      subtitle: TextField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10)),
                        onChanged: (value) => loggedInUser.username = value,
                      ),
                    ),
                    ListTile(
                      subtitle: ElevatedButton(
                        onPressed: () async {
                          await updateUserInfo();
                          setState(() {
                            loggedInUser.username;
                          });
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 0, 105, 120))),
                        child: const Text('Save Change'),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
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
}
