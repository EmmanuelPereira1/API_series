
import 'package:flutter/material.dart';

myDialog(
  BuildContext mycontext,
  String titleText,
  String contentText,
  String buttonText,
  Function()? onpressed,
) {
  return showDialog(
    context: mycontext,
    builder: (context) => AlertDialog(
      contentPadding:  const EdgeInsets.fromLTRB(20,20,20,20), 
      
      title: Text(
        titleText,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
           ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        contentText,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: onpressed,
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 12,
                ),
          ),
        )
      ],
    ),
  );
}