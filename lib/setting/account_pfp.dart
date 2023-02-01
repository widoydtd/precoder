import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precoder/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountPfpPage extends StatefulWidget {
  const AccountPfpPage({super.key});

  @override
  State<AccountPfpPage> createState() => _AccountPfpPageState();
}

class _AccountPfpPageState extends State<AccountPfpPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String downloadedUrl = "";

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
          "Change Profile Picture",
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
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Image.network(loggedInUser.pfp.toString())),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 250,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF006978))),
                    onPressed: () {
                      uploadtoStorage();
                    },
                    child: const Text("Choose an Image"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadtoStorage() async {
    String uid = loggedInUser.uid.toString();
    final ref = FirebaseStorage.instance.ref().child('/images/users/$uid/pfp');
    final ImagePicker picker = ImagePicker();

    var metadata = SettableMetadata(
      contentType: "image/jpeg",
    );
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File selectedImagePath = File(image.path);
      await ref.putFile(selectedImagePath, metadata).whenComplete(() {
        debugPrint("The file has been uploaded");
        postDetailsToFirestore();
      });
    } else {
      debugPrint("No file selected");
    }
  }

  Future<String> getImageUrlFromFirebase() async {
    String uid = loggedInUser.uid.toString();
    final ref = FirebaseStorage.instance.ref().child('images/users/$uid/pfp');
    String pfp = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'pfp': pfp});
    return pfp;
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = loggedInUser.username;
    userModel.fullname = loggedInUser.fullname;
    userModel.phone = loggedInUser.phone;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) =>
            getImageUrlFromFirebase().then((value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPfpPage(),
                  ),
                )));
  }
}
