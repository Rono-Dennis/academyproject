
import 'package:flutter/material.dart';


class PasswordFieldWidget extends StatefulWidget{

  final IconData? iconData;
  final TextInputType? textInputType;
  final String? hintText;
  final double? borderRadius;
  final TextInputAction? textInputAction;


  const PasswordFieldWidget({Key? key, this.iconData, this.textInputType, this.hintText, this.borderRadius, controller, required this.textInputAction}) : super(key: key);

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  // final userNameEditingController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  //toggle password
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        controller: controller,
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
          controller.text = value!;
        },

        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
          suffixIcon: IconButton(
            icon: toggle ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
          onPressed: togglepassword,
          )
          // suffixIcon: IconButton(
            //
            //     icon: Icon(
            //         obscureText ? Icons.visibility : Icons.visibility_off),
            //     onPressed: () {
            //       setState(() {
            //         obscureText = false;
            //       });
            //     })
           ),
        );
  }

  void togglepassword()
  {
   setState(() {
     toggle =!toggle;
   });
  }
}

