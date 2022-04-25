import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  Color _color = Color.fromARGB(220, 117, 218, 255);

  String? _title;
  String? _content;
  String? _yes;
  String? _no;
  Function? _yesOnPressed;
  Function? _noOnPressed;

  BaseAlertDialog(
      {String? title,
      String? content,
      Function? yesOnPressed,
      Function? noOnPressed,
      String yes = "Yes",
      String no = "No"}) {
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title!),
      content: Text(_content!),
      backgroundColor: _color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        FlatButton(
          child: Text(_yes!),
          textColor: Colors.greenAccent,
          onPressed: () {
            _yesOnPressed!();
            
          },
        ),
        FlatButton(
          child: Text(_no!),
          textColor: Colors.redAccent,
          onPressed: () {
            _noOnPressed!();
          },
        ),
      ],
    );
  }
}
