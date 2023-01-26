import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:precoder/home.dart';
import 'package:precoder/login.dart';
import 'package:precoder/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 0, 0, 0), // status bar color
  ));
}

class MyApp extends StatelessWidget {
  final MyApp? myApp;
  const MyApp({super.key, this.myApp});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges().cast<User>(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return const MaterialApp(
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          return const MaterialApp(
            home: MainPage(title: 'PreCoder'),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.zero,
                  child: Image.asset(
                    'assets/PreCoder.png',
                    width: 300,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 300,
                  child: const Text(
                    'Access algorithm and programming courses and other interesting features from your phone',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                    height: 50,
                    width: 300,
                    margin: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 0, 105, 120))),
                      child: const Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    )),
                Container(
                    height: 50,
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 0, 105, 120))),
                      child: const Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
