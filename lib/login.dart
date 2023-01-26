import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:precoder/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final logintext = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.zero,
          width: 300,
          child: const Text(
            "Welcome Back",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          width: 300,
          child: const Text(
            "Login to continue your progress",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );

    final emailField = Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: 300,
          child: const Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: TextFormField(
            autofocus: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Email must be filled");
              } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please enter a valid email");
              }
              return null;
            },
            onSaved: (value) {
              emailController.text = value!;
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

    final passwordField = Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 10),
            width: 300,
            child: const Text(
              "Password",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18),
            )),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: TextFormField(
            autofocus: false,
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              RegExp rg = RegExp(r'^.{6,}$');

              if (value!.isEmpty) {
                return ("Password must not be empty");
              } else if (!rg.hasMatch(value)) {
                return ("Password length must be at least 6");
              }
              return null;
            },
            onSaved: (value) {
              passwordController.text = value!;
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
            ),
          ),
        )
      ],
    );

    final loginButton = Container(
        margin: const EdgeInsets.only(top: 30),
        width: 300,
        height: 50,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 0, 105, 120),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              signIn(emailController.text, passwordController.text);
            },
            child: const Text("Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ));

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
                children: [logintext, emailField, passwordField, loginButton]),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false),
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
      }
    }
  }
}
