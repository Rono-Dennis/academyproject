import 'dart:io';
import 'package:academyproject/components/widgets/buttonwidget.dart';
import 'package:academyproject/model/user_model.dart';
import 'package:academyproject/pages/welcomescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  //instancePicking Image
  File? pickedImage;

  String? userID;

  // URL
  String? downloadUrl;
  //FirebaseStorage
  FirebaseStorage storage = FirebaseStorage.instance;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final userNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();


  final postID = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();


  UserModel userModel = UserModel();


  ImagePicker imagePicker = ImagePicker();
  File? file;

  //toggle password
  bool toggle1 = false;
  //toggle password
  bool toggle = false;

  getImage() async
  {
    var img = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }


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
    //first name field
    final userNameField = TextFormField(
        autofocus: false,
        controller: userNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          userNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "${loggedInUser.userName}- name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));



    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: toggle,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          userNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "${loggedInUser.password}- password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            suffixIcon: IconButton(
              icon: toggle ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
              onPressed: togglepassword,
            )
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: toggle1,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "${loggedInUser.password}- confirm password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            suffixIcon: IconButton(
              icon: toggle1 ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
              onPressed: toggleConformpassword,
            )
        ));



    //pickImage
    pickImage(ImageSource imageType) async {
      try {
        final photo = await ImagePicker().pickImage(source: imageType);
        if (photo == null) return;
        final tempImage = File(photo.path);
        setState(() {
          pickedImage = tempImage;
        });

        Get.back();
      } catch (error) {
        debugPrint(error.toString());
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            // passing this to our root
            // Navigator.of(context).pop();
            Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    (route) => false);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: ClipOval(
                        child:
                        pickedImage != null
                            ? Image.file(
                          pickedImage!,
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                        ) :
                        GestureDetector(
                          onTap: (){pickImage(ImageSource.gallery);},
                          child: Image.network(
                            '${loggedInUser.imageUrl}',
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,

                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 45),
                      Text("${loggedInUser.email}",
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        )),
                    const SizedBox(height: 20),
                    userNameField,
                    // const SizedBox(height: 20),
                    // emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    ButtonWidget
                      (
                        text: "Update",
                        onClicked: (){
                          uploadImage();
                        }

                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await
            user?.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: password))
            .then((value) => {uploadImage()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "enter correct email address.";
            break;
          case "wrong-password":
            errorMessage = "enter correct password.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "you have been blocked";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);

      }
    }
  }

  // upload image

  Future<void> uploadImage() async {
    // Reference ref = FirebaseStorage.instance.ref().child("profileImages").child("${_auth.currentUser!.uid}image");

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('/upload_images').child('images${_auth.currentUser!.uid}')
        .putFile(pickedImage!);

    try {
      // Storage tasks function as a Delegating Future so we can await them.
      firebase_storage.TaskSnapshot snapshot = await task;

      String downLoadUrl = await snapshot.ref.getDownloadURL();

      postDetailsToFirestore(downLoadUrl);
    } on FirebaseException catch (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`


      if (e.code == 'permission-denied') {
       }
      // ...
    }
  }


  Future<void> postDetailsToFirestore(String downLoadUrl) async {
    // calling our firestore
    // calling our user model
    // sedning these values


     User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user?.email;
    userModel.uid = _auth.currentUser?.uid;
    userModel.userName = userNameEditingController.text;
    userModel.password =  passwordEditingController.text;
    userModel.dateTime = postID;
    userModel.imageUrl = downLoadUrl;


    CollectionReference users = FirebaseFirestore.instance.collection("users");


    await users.doc(_auth.currentUser?.uid).update(userModel.toMap()).then((value) =>
        Fluttertoast.showToast(msg: "Details updated successfully"))
    .catchError((onError) => Fluttertoast.showToast(msg: "Failed to updated"));


    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (route) => false);
  }

  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');



  void togglepassword()
  {
    {
      setState(() {
        toggle =!toggle;
      });
    }
  }

  void toggleConformpassword()
  {
    {
      setState(() {
        toggle1 =!toggle1;
      });
    }
  }
}