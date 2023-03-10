import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precoder/model/user_model.dart';
import 'package:precoder/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  final usernameEditingController = TextEditingController();
  final fullnameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registertext = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.zero,
          width: 300,
          child: const Text(
            "Register",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          width: 300,
          child: const Text(
            "Fill in your data below",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );

    final usernameField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: 300,
          child: const Text(
            "Username",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
            autofocus: false,
            controller: usernameEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              RegExp regex = RegExp(r'^.{8,}$');
              if (value!.isEmpty) {
                return ("Username cannot be Empty");
              }
              if (!regex.hasMatch(value)) {
                return ("Username must be at least 8 characters long");
              }
              return null;
            },
            onSaved: (value) {
              usernameEditingController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFF006978), width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFF006978), width: 3),
              ),
            ),
          ),
        )
      ],
    );

    final fullnameField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 300,
          child: const Text(
            "Name",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: fullnameEditingController,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Name must not be empty");
                }
                return null;
              },
              onSaved: (value) {
                fullnameEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
              )),
        )
      ],
    );

    final emailField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 300,
          child: const Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Email address must not be empty");
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return ("Please enter a valid email address");
                }
                return null;
              },
              onSaved: (value) {
                emailEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
              )),
        )
      ],
    );

    final phoneField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 300,
          child: const Text(
            "Phone Number",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: phoneEditingController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                RegExp regex = RegExp(r'^.{10,14}$');
                if (value!.isEmpty) {
                  return ("Phone number must not be empty");
                }
                if (!regex.hasMatch(value)) {
                  return ("Please enter a valid phone number");
                }
                return null;
              },
              onSaved: (value) {
                phoneEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
              )),
        )
      ],
    );

    final passwordField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 300,
          child: const Text(
            "Password",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: passwordEditingController,
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
                passwordEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
              )),
        )
      ],
    );

    final confirmPasswordField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 300,
          child: const Text(
            "Confirm Password",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: confirmPasswordEditingController,
              obscureText: true,
              validator: (value) {
                if (confirmPasswordEditingController.text !=
                    passwordEditingController.text) {
                  return "Password does not match";
                }
                return null;
              },
              onSaved: (value) {
                confirmPasswordEditingController.text = value!;
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF006978), width: 3),
                ),
              )),
        )
      ],
    );

    final signUpButton = Container(
        margin: const EdgeInsets.only(top: 30),
        width: 300,
        height: 50,
        child: Material(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 0, 105, 120),
            child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  signUp(emailEditingController.text,
                      passwordEditingController.text);
                },
                child: const Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))));

    return Scaffold(
      body: Center(
        child: Container(
            margin: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    registertext,
                    usernameField,
                    fullnameField,
                    emailField,
                    phoneField,
                    passwordField,
                    confirmPasswordField,
                    signUpButton,
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        postDetailsToFirestore();
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          default:
            errorMessage = "The email address already exists";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }

  Future<void> deleteUser() async {
    User? user = _auth.currentUser;
    await user!.delete();
  }

  Future<String> getImageUrlFromFirebase() async {
    User? user = _auth.currentUser;
    final ref = FirebaseStorage.instance
        .ref()
        .child('images/defaultpfp/defaultpfp.jpg');
    String pfp = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'pfp': pfp});
    return pfp;
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = usernameEditingController.text;
    userModel.fullname = fullnameEditingController.text;
    userModel.phone = phoneEditingController.text;

    final QuerySnapshot snapshotUsername = await firebaseFirestore
        .collection("users")
        .where("username", isEqualTo: userModel.username)
        .get();
    final QuerySnapshot snapshotPhone = await firebaseFirestore
        .collection("users")
        .where("phone", isEqualTo: userModel.phone)
        .get();
    if (snapshotUsername.docs.isNotEmpty) {
      Fluttertoast.showToast(msg: "The username already exists");
      deleteUser();
    } else if (snapshotPhone.docs.isNotEmpty) {
      Fluttertoast.showToast(msg: "The phone number already exists");
      deleteUser();
    } else {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) => getImageUrlFromFirebase());
      Fluttertoast.showToast(msg: "Account created successfully");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    }
  }
}
