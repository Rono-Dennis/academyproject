
import 'package:flutter/material.dart';


class UserNameWidget extends StatefulWidget{

  // final userNameEditingController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  final IconData? iconData;
  final TextInputType? textInputType;
  final String? hintText;
  final double? borderRadius;
  final TextInputAction? textInputAction;
  final bool obscureText = false;


  UserNameWidget({Key? key, this.iconData, this.textInputType, this.hintText, this.borderRadius, controller, this.textInputAction}) : super(key: key);

  @override
  State<UserNameWidget> createState() => UserNameWidgetState();
}

class UserNameWidgetState extends State<UserNameWidget> {
  // final userNameEditingController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  //toggle password
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    //first name field
    return TextFormField(
        autofocus: false,
        controller: controller,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
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
          controller.text = value!;
        },
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.iconData),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
        ));
  }

  void togglepassword()
  {
   setState(() {
     toggle =!toggle;
   });
  }
}

