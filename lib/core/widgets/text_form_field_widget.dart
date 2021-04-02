import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String Function (String ) callBack;
  final bool obscureText;

  TextFormFieldWidget({this.controller, this.hintText="", this.callBack,this.obscureText=false});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      obscuringCharacter: "*",
      controller: widget.controller,
      validator: (value) => widget.callBack(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black12,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        letterSpacing: 1,
      ),
      onChanged: (value) {},
    );
  }
}
