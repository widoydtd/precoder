import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precoder/model/user_model.dart';
import 'package:precoder/home.dart';
import 'package:precoder/setting/account_pfp.dart';

class AccountEditPage extends StatefulWidget {
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  State<AccountEditPage> createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  final user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final _formKey = GlobalKey<FormState>();

  final usernameEditingController = TextEditingController();
  final fullnameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

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
                            top: BorderSide(
                                width: 2, color: Color(0xFF006978)))),
                    child: ExpansionTile(
                      key: GlobalKey(),
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
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              onSaved: (value) => loggedInUser.username = value,
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
                                width: 2, color: Color(0xFF006978)))),
                    child: ExpansionTile(
                      key: GlobalKey(),
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
                            subtitle: TextField(
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              onChanged: (value) =>
                                  loggedInUser.fullname = value,
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
                      key: GlobalKey(),
                      title: const Text(
                        "Change Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text(
                            "Current email",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text("${loggedInUser.email}"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            title: const Text(
                              "New email",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: TextField(
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              onChanged: (value) {
                                loggedInUser.email = value;
                              },
                            ),
                          ),
                        ),
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
                      key: GlobalKey(),
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
                            subtitle: TextField(
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              onChanged: (value) {
                                loggedInUser.phone = value;
                              },
                            ),
                          ),
                        ),
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
                      key: GlobalKey(),
                      title: const Text(
                        "Change Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text(
                            "Current password",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text("${loggedInUser.email}"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            title: const Text(
                              "New password",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: TextField(
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10)),
                              onChanged: (value) {
                                loggedInUser.email = value;
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
                      setState(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
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
                    child: const Text('Save Changes'),
                  ),
                )
              ],
            ),
          ),
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
        'fullname': loggedInUser.fullname,
        'email': loggedInUser.email,
        'phone': loggedInUser.phone,
      });
      // Update successful, show a message to the user
    } catch (e) {
      // An error occurred, show the error message to the user
    }
  }
}
