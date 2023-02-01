import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precoder/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final fAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? errorMessage;

  final currPasswordEditingController = TextEditingController();
  final newPasswordEditingController = TextEditingController();

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
          "Change Password",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 0, 105, 120),
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.zero,
                width: 350,
                child: const Text(
                  "Current password:",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                width: 350,
                child: TextFormField(
                  controller: currPasswordEditingController,
                  obscureText: true,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{8,}$');
                    if (value!.isEmpty) {
                      return ("Password must not be empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Password must be at least 8 characters long");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    currPasswordEditingController.text = value!;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 350,
                child: const Text(
                  "New password:",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                width: 350,
                child: TextFormField(
                  controller: newPasswordEditingController,
                  obscureText: true,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{8,}$');
                    if (value!.isEmpty) {
                      return ("Password must not be empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Password must be at least 8 characters long");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newPasswordEditingController.text = value!;
                  },
                ),
              ),
              Container(
                width: 350,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    signIn(loggedInUser.email.toString(),
                        currPasswordEditingController.text);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 0, 105, 120))),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> signIn(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user!.reauthenticateWithCredential(credential);
      postDetailsToFirestore();
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        default:
          errorMessage =
              "Authentication failed due to wrong email/password. Please try again";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    UserModel userModel = UserModel();
    User? user = fAuth.currentUser;

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = loggedInUser.username;
    userModel.fullname = loggedInUser.fullname;
    userModel.phone = loggedInUser.phone;
    userModel.pfp = loggedInUser.pfp;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then(
            (value) => user.updatePassword(newPasswordEditingController.text));
    Fluttertoast.showToast(msg: "Password changed successfully");

    Navigator.pushReplacement((context),
        MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
  }
}
