import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Color.fromARGB(100, 0, 0, 0), // status bar color
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// <Pre-Authentication>
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
              child: Image.asset(
                'assets/PreCoder.png',
                height: 60,
                width: 300,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 60,
              width: 300,
              child: Text(
                'Access algorithm and programming courses and other interesting features from your phone',
              ),
            ),
            Container(
                height: 60,
                width: 300,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage())),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 105, 120))),
                  child: Text('Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                )),
            Container(
                height: 60,
                width: 300,
                margin: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage())),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 105, 120))),
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                )),
          ],
        ),
      ),
    );
  }
}
// </Pre-Authentication>

// <Registration>
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 70),
              height: 30,
              width: 300,
              child: Text('Register',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            ),
            Container(
              //margin: EdgeInsets.only(top: 10),
              height: 30,
              width: 300,
              child: Text('Fill in your data below',
                  style: TextStyle(fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 30,
              width: 300,
              child: Text('Full Name', style: TextStyle(fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 30,
              width: 300,
              child: TextField(),
            ),
          ],
        ),
      ),
    );
  }
}
// </Registration>

// <Login>
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 70),
              height: 60,
              width: 300,
              child: Text('Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
// </Login>