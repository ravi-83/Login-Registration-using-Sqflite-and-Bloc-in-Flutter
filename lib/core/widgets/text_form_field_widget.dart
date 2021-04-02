import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String Function (String ) callBack;

  TextFormFieldWidget({this.controller, this.hintText="", this.callBack});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onChanged: (value) {},
    );
  }
}
