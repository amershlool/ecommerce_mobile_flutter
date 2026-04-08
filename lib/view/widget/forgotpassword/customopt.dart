import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CustomOpt extends StatefulWidget {
  final void Function(String) onSubmit;
  const CustomOpt({super.key, required this.onSubmit});

  @override
  State<CustomOpt> createState() => _CustomOptState();
}

class _CustomOptState extends State<CustomOpt> {
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      borderRadius: BorderRadius.circular(15),
      autoFocus: true,
      enabledBorderColor: Colors.black54,
      focusedBorderColor: Colors.white,
      cursorColor: Colors.grey[800],
      borderWidth: 1,
      clearText: true,
      textStyle: TextStyle(
        color: Colors.grey[800],
        fontFamily: "Amiri",
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      numberOfFields: 5,
      showFieldAsBox: true,
      onCodeChanged: (String code) {
      },
      onSubmit:widget.onSubmit
    );
  }
}
