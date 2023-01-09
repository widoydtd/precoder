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
          margin: EdgeInsets.only(top: 20),
          width: 300,
          child: Text(
            "Welcome Back",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ),
        Container(
          width: 300,
          child: Text(
            "Login to continue your progress",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );

    final emailField = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          width: 300,
          child: Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
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

    final passwordField = Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 10),
            width: 300,
            child: Text(
              "Password",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            )),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: TextFormField(
            autofocus: false,
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              RegExp rg = new RegExp(r'^.{6,}$');

              if (value!.isEmpty) {
                return ("Password must not be empty");
              } else if (!rg.hasMatch(value)) {
                return ("Password length must be at least 6");
              }
            },
            onSaved: (value) {
              passwordController.text = value!;
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
            ),
          ),
        )
      ],
    );

    final loginButton = Container(
        margin: EdgeInsets.only(top: 20),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 0, 105, 120),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              signIn(emailController.text, passwordController.text);
            },
            child: Text("Login",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ));

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage())),
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
}
