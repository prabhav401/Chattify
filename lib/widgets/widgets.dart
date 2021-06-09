import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Text("CHATTIFY", style: TextStyle(fontStyle: FontStyle.italic),),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
    ),
  );
}

TextStyle simpleTextField(){
  return TextStyle(
      color: Colors.white,
    fontSize: 16,
  );
}

TextStyle mediumTextField(){
  return TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );
}