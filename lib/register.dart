import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precoder/model/user_model.dart';
import 'package:precoder/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final usernameEditingController = new TextEditingController();
  final fullnameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registertext = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          width: 300,
          child: Text(
            "Register",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ),
        Container(
          width: 300,
          child: Text(
            "Fill in your data below",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );

    //username field
    final usernameField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          width: 300,
          child: Text(
            "Username",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: TextFormField(
            autofocus: false,
            controller: usernameEditingController,
            keyboardType: TextInputType.name,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{8,}$');
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
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    //full name field
    final fullnameField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: Text(
            "Full Name",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: fullnameEditingController,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Full name must not be empty");
                }
                return null;
              },
              onSaved: (value) {
                fullnameEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    //email field
    final emailField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Email address must not be empty");
                }
                // reg expression for email validation
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
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    //phone field
    final phoneField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: Text(
            "Phone Number",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: phoneEditingController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{10,14}$');
                if (value!.isEmpty) {
                  return ("Phone number must not be empty");
                }
                // reg expression for email validation
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
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    //password field
    final passwordField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: Text(
            "Password",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: TextFormField(
              autofocus: false,
              controller: passwordEditingController,
              obscureText: true,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{8,}$');
                if (value!.isEmpty) {
                  return ("Password must not be empty");
                }
                if (!regex.hasMatch(value)) {
                  return ("Password must be at least 8 characters long");
                }
              },
              onSaved: (value) {
                passwordEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    //confirm password field
    final confirmPasswordField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 300,
          child: Text(
            "Confirm Password",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
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
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
        margin: EdgeInsets.only(top: 30),
        child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 0, 105, 120),
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  signUp(emailEditingController.text,
                      passwordEditingController.text);
                },
                child: Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))));

    return Scaffold(
      body: Center(
        child: Container(
            margin: EdgeInsets.only(top: 20),
            width: 300,
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "The email you entered is incorrect";
            break;
          case "wrong-password":
            errorMessage = "The password you entered is incorrect";
            break;
          case "user-not-found":
            errorMessage = "The account doesn't exist";
            break;
          default:
            errorMessage = "An unknown error has occured. Please try again";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = usernameEditingController.text;
    userModel.fullname = fullnameEditingController.text;
    userModel.phone = phoneEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
