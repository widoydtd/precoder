import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precoder/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final fAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? errorMessage;

  final emailEditingController = TextEditingController();
  final reAuthPasswordEditingController = TextEditingController();

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
          "Change Email",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 0, 105, 120),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.zero,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 350,
                    child: const Text(
                      "Current email: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    )),
                Container(
                    margin: EdgeInsets.zero,
                    width: 350,
                    child: Text(
                      "${loggedInUser.email}",
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 350,
                    child: const Text(
                      "New email: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    )),
                Container(
                  margin: EdgeInsets.zero,
                  width: 350,
                  child: TextFormField(
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    onSaved: (value) {
                      emailEditingController.text = value!;
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 350,
                    child: const Text(
                      "Your password (required): ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    )),
                Container(
                  margin: EdgeInsets.zero,
                  width: 350,
                  child: TextFormField(
                    controller: reAuthPasswordEditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    onSaved: (value) {
                      reAuthPasswordEditingController.text = value!;
                    },
                  ),
                ),
                // Container(
                //     margin: EdgeInsets.zero,
                //     width: 350,
                //     child: ExpansionTile(
                //       title: const Text(
                //         "Change Email",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, color: Colors.black),
                //       ),
                //       children: <Widget>[
                //         ListTile(
                //           title: const Text(
                //             "Current email",
                //             style: TextStyle(fontWeight: FontWeight.w500),
                //           ),
                //           subtitle: Text("${loggedInUser.email}"),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(bottom: 20),
                //           child: ListTile(
                //             title: const Text(
                //               "New email",
                //               style: TextStyle(fontWeight: FontWeight.w500),
                //             ),
                //             subtitle: TextFormField(
                //               controller: emailEditingController,
                //               keyboardType: TextInputType.emailAddress,
                //               decoration: const InputDecoration(
                //                   contentPadding:
                //                       EdgeInsets.symmetric(vertical: 10)),
                //               onSaved: (value) {
                //                 emailEditingController.text = value!;
                //               },
                //             ),
                //           ),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(bottom: 20),
                //           child: ListTile(
                //             title: const Text(
                //               "Current password (required)",
                //               style: TextStyle(fontWeight: FontWeight.w500),
                //             ),
                //             subtitle: TextFormField(
                //               controller: reAuthPasswordEditingController,
                //               obscureText: true,
                //               decoration: const InputDecoration(
                //                   contentPadding:
                //                       EdgeInsets.symmetric(vertical: 10)),
                //               onSaved: (value) {
                //                 reAuthPasswordEditingController.text = value!;
                //               },
                //             ),
                //           ),
                //         ),
                //       ],
                //     )),
                Container(
                  width: 350,
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      signIn(loggedInUser.email.toString(),
                          reAuthPasswordEditingController.text);
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
        ),
      ),
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

    if (emailEditingController.text == "") {
      emailEditingController.text = loggedInUser.email!;
    }

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.email = emailEditingController.text;
    userModel.username = loggedInUser.username;
    userModel.fullname = loggedInUser.fullname;
    userModel.phone = loggedInUser.phone;
    userModel.pfp = loggedInUser.pfp;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update({'email': userModel.email}).then(
            (value) => user.updateEmail(emailEditingController.text));
    Fluttertoast.showToast(msg: "Email changed successfully");

    Navigator.pushReplacement((context),
        MaterialPageRoute(builder: (context) => const ChangeEmailPage()));
  }
}
