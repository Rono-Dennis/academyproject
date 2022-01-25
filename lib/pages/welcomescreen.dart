import 'package:academyproject/components/widgets/buttonwidget.dart';
import 'package:academyproject/model/user_model.dart';
import 'package:academyproject/pages/login.dart';
import 'package:academyproject/pages/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  FirebaseStorage storage = FirebaseStorage.instance;


  String? url;

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
    // url = downloadURLExample() as String?;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(

                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                      child: ClipOval(
                          child: Image.network(
                            "${loggedInUser.imageUrl}",
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    const SizedBox(height: 45),



                            Text("Email : ${loggedInUser.email}",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              )),




                              Text("Username : ${loggedInUser.userName}",
                              style: const TextStyle(
                                fontSize: 28,

                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              )),



                    const SizedBox(height: 35),
                    const Text("Book readers with this feature can enjoy the favourite novels and mangas straight from your device",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,

                        ), textAlign: TextAlign.center,),
                    const SizedBox(height: 35),
                    ButtonWidget
                      (
                        text: "Update",
                        onClicked: (){
                          Navigator.pushAndRemoveUntil(
                              (context),
                              MaterialPageRoute(builder: (context) => const Update()),
                                  (route) => false);
                        }

                    ),
                    const SizedBox(height: 50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          GestureDetector(
                            onTap: () {
                              logout(context);

                            },
                            child: const Text(
                              "Log out Account",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
