
import 'package:flutter/material.dart';


class UserNameWidget extends StatelessWidget{

  // final userNameEditingController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  final IconData? iconData;
  final TextInputType? textInputType;
  final String? hintText;
  final double? borderRadius;
  final bool obscureText = false;
  UserNameWidget({Key? key, this.iconData, this.textInputType, this.hintText, this.borderRadius, controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //first name field
    return TextFormField(
        autofocus: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
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
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
        ));
  }

}