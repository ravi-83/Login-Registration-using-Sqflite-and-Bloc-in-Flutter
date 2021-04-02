import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton({this.colour,this.buttonName, @required this.onPressed});
  final Color colour;
  final String buttonName;
  final Function onPressed ;

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: widget.colour,//Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: widget.onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            widget.buttonName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}