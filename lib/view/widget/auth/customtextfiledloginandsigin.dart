import 'package:flutter/material.dart';

class CustomTextFiledSigInAndSignup extends StatefulWidget {
  final String hintText;
  final String label;
  final Widget prefixIcon;
  final TextEditingController? myController;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
 final IconButton? suffixIcon ;

  const CustomTextFiledSigInAndSignup(
      {super.key,
      required this.hintText,
      required this.label,
      required this.prefixIcon,
      required this.myController,
       this.obscureText,
      required this.keyboardType,
      required this.validator,
      this.suffixIcon,
      });

  @override
  State<CustomTextFiledSigInAndSignup> createState() => _CustomTextFiledSigInAndSignupState();
}

class _CustomTextFiledSigInAndSignupState extends State<CustomTextFiledSigInAndSignup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 30,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: TextFormField(
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        controller: widget.myController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.only(left: 45),
          label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.label,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              )),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black26, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2),
          ),
        ),
      ),
    );
  }
}
