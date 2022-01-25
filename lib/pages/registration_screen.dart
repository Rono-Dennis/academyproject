import 'dart:io';
import 'package:academyproject/components/widgets/TextFormFieldWidget.dart';
import 'package:academyproject/components/widgets/buttonwidget.dart';
import 'package:academyproject/model/user_model.dart';
import 'package:academyproject/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  //instancePicking Image
  File? pickedImage;

  String? userID;


  //FirebaseStorage
  FirebaseStorage storage = FirebaseStorage.instance;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final userNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final FocusNode nameEditingControllerFocus = FocusNode();
  final FocusNode passEditingControllerFocus = FocusNode();

  final postID = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();

  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref('images/defaultProfile.png');

  //extract data from our model
  UserModel userModel = UserModel();

  //toggle password
  bool toggle1 = true;
  //toggle password
  bool toggle = true;

  @override
  Widget build(BuildContext context) {

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
      // backgroundColor: Colors.white,
      //   body: Container(
      //
      //   ),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: const Text("Entertainment App"),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/redvector.jpg"),
                fit: BoxFit.cover,
              ),
            ),
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
                      child: pickedImage != null
                          ? Image.file(
                        pickedImage!,
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      )
                          : GestureDetector(
                        onTap: () {
                          pickImage(ImageSource.gallery);
                        },
                        child: Image.asset(
                          'assets/addcircularbutton.png',
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  const SizedBox(height: 45),
                  const Text("ENTA",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      )),
                  const SizedBox(height: 20),

                  TextFormField(
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
                        // return null;
                      },
                      onSaved: (value) {
                        userNameEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle),
                        contentPadding: const EdgeInsets.fromLTRB(
                            20, 15, 20, 15),
                        hintText: "UserName",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),

                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  // TextFormFieldWidget(
                  //   hintText: "Username",
                  //   textInputType: TextInputType.text,
                  //   actionKeyboard: TextInputAction.next,
                  //   functionValidate: commonValidation,
                  //   controller: nameEditingController,
                  //   focusNode: nameEditingControllerFocus,
                  //   onSubmitField: () {
                  //     // Use this method to change cursor focus
                  //     // First param - Current Controller
                  //     // Second param - The Controller you want to focus on the next button press
                  //     changeFocus(context, nameEditingControllerFocus,
                  //         passEditingControllerFocus);
                  //   },
                  //   parametersValidate: "Please enter Username.",
                  //   prefixIcon: const Icon(
                  //       Icons.insert_emoticon), defaultText: 'enter name', onFieldTap: (){},
                  //     // Don't pass image in case of no prefix Icon
                  // ),
              //email field
              TextFormField(
                  autofocus: false,
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userNameEditingController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    contentPadding: const EdgeInsets.fromLTRB(
                        20, 15, 20, 15),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),

              const SizedBox(height: 20),
              //password field
              TextFormField(
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
                    contentPadding: const EdgeInsets.fromLTRB(
                        20, 15, 20, 15),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      suffixIcon: IconButton(
                        icon: toggle ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                        onPressed: togglepassword,
                      )
                  )),


              const SizedBox(height: 20),
              TextFormField(
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
                    contentPadding: const EdgeInsets.fromLTRB(
                        20, 15, 20, 15),
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      suffixIcon: IconButton(
                        icon: toggle ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                        onPressed: toggleConformpassword,
                      )
                  )),
              const SizedBox(height: 20),
                      ButtonWidget
                        (
                          text: "Create",
                          onClicked: () {
                            signUp(emailEditingController.text,
                                passwordEditingController.text);

                            if (pickedImage != null) {
                              uploadImage();
                            } else {
                              Fluttertoast.showToast(msg: "Image not selected");
                            }
                          }
                      ),
              const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginScreen()));
                              },
                              child: const Text(
                                "SignIn",
                                style: TextStyle(
                                    color: Colors.cyanAccent,
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
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
        .child('/upload_images')
        .child('images${_auth.currentUser!.uid}')
        .putFile(pickedImage!);

    try {
      // Storage tasks function as a Delegating Future so we can await them.
      firebase_storage.TaskSnapshot snapshot = await task;

      String downLoadUrl = await snapshot.ref.getDownloadURL();

      postDetailsToFirestore(downLoadUrl);
    } on FirebaseException catch (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`

      if (e.code == 'permission-denied') {}
      // ...
    }
  }

  // postDetailsToFirestoe() async {
  // //
  // // }

  Future<void> postDetailsToFirestore(String downLoadUrl) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = userNameEditingController.text;
    userModel.dateTime = postID;
    userModel.imageUrl = downLoadUrl;
    userModel.password = passwordEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
  }

  void toggleConformpassword()
  {
    {
      setState(() {
        toggle1 =!toggle1;
      });
    }
  }

  void togglepassword()
  {
    {
      setState(() {
        toggle =!toggle;
      });
    }
  }
}
