import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:precoder/model/user_model.dart';
import 'package:precoder/setting/account_pfp.dart';
import 'package:precoder/setting/account_email.dart';
import 'package:precoder/setting/account_password.dart';

class AccountEditPage extends StatefulWidget {
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  State<AccountEditPage> createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  final user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? errorMessage;

  final pfpEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();
  final fullnameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();

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
        child: Container(
          margin: EdgeInsets.zero,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.zero,
                  width: 350,
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountPfpPage()),
                        );
                      },
                      title: const Text("Change Profile Picture",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  width: 350,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 2, color: Color(0xFF006978)))),
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangeEmailPage()),
                        );
                      },
                      title: const Text("Change Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  width: 350,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 2, color: Color(0xFF006978)))),
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePasswordPage()),
                        );
                      },
                      title: const Text("Change Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ),
                Container(
                    margin: EdgeInsets.zero,
                    width: 350,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 2, color: Color(0xFF006978)))),
                    child: ExpansionTile(
                      title: const Text(
                        "Change Username",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text(
                            "Current username",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text("${loggedInUser.username}"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            title: const Text(
                              "New username",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: TextFormField(
                                controller: usernameEditingController,
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{8,}$');
                                  if (!regex.hasMatch(value!)) {
                                    return ("Username must be at least 8 characters long");
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                onSaved: (value) {
                                  usernameEditingController.text = value!;
                                }),
                          ),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.zero,
                    width: 350,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 2, color: Color(0xFF006978)))),
                    child: ExpansionTile(
                      title: const Text(
                        "Change Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text(
                            "Current name",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text("${loggedInUser.fullname}"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            title: const Text(
                              "New name",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: TextFormField(
                              controller: fullnameEditingController,
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              onSaved: (value) {
                                fullnameEditingController.text = value!;
                              },
                            ),
                          ),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.zero,
                    width: 350,
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        width: 2,
                        color: Color(0xFF006978),
                      ),
                    )),
                    child: ExpansionTile(
                      title: const Text(
                        "Change Phone Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text(
                            "Current phone number",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text("${loggedInUser.phone}"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            title: const Text(
                              "New phone number",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: TextFormField(
                              controller: phoneEditingController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{10,14}$');
                                if (!regex.hasMatch(value!)) {
                                  return ("Please enter a valid phone number");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                phoneEditingController.text = value!;
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  width: 350,
                  margin: EdgeInsets.zero,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateUserInfo();
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

  Future<void> updateUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // pfpEditingController.text = loggedInUser.pfp!;

    // if (pfpEditingController.text == loggedInUser.pfp) {
    //   debugPrint(pfpEditingController.text);
    // }

    if (usernameEditingController.text.isEmpty) {
      usernameEditingController.text = loggedInUser.username!;
    }
    if (fullnameEditingController.text.isEmpty) {
      fullnameEditingController.text = loggedInUser.fullname!;
    }
    if (phoneEditingController.text.isEmpty) {
      phoneEditingController.text = loggedInUser.phone!;
    }

    userModel.email = user!.email;
    userModel.uid = user.uid;
    // userModel.pfp = pfpEditingController.text;
    userModel.username = usernameEditingController.text;
    userModel.fullname = fullnameEditingController.text;
    userModel.phone = phoneEditingController.text;

    final QuerySnapshot snapshotUid = await firebaseFirestore
        .collection("users")
        .where("uid", isEqualTo: userModel.uid)
        .get();

    if (snapshotUid.docs.isNotEmpty) {
      final QuerySnapshot snapshotUsername = await firebaseFirestore
          .collection("users")
          .where("username", isEqualTo: userModel.username)
          .get();

      final QuerySnapshot snapshotPhone = await firebaseFirestore
          .collection("users")
          .where("phone", isEqualTo: userModel.phone)
          .get();

      if (snapshotUsername.docs.isNotEmpty &&
          userModel.username != loggedInUser.username) {
        Fluttertoast.showToast(msg: "The username already exists");
      } else if (userModel.username.toString().length < 8) {
        Fluttertoast.showToast(
            msg: "Username must be at least 8 characters long");
      } else if (snapshotPhone.docs.isNotEmpty &&
          userModel.phone != loggedInUser.phone) {
        Fluttertoast.showToast(msg: "The phone number already exists");
      } else if (!RegExp(r'^\d{10,14}$').hasMatch(userModel.phone.toString())) {
        Fluttertoast.showToast(msg: "Please enter a valid phone number");
      } else {
        debugPrint(userModel.pfp.toString());

        await firebaseFirestore.collection("users").doc(user.uid).update({
          'username': userModel.username,
          'fullname': userModel.fullname,
          'phone': userModel.phone
        }).then((value) => setState(() {
              debugPrint(userModel.pfp.toString());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountEditPage(),
                ),
              );
            }));
        // Update successful, show a message to the user
      }
    }
  }
}
