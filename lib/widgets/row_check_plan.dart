import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter/material.dart';

class RowCheckPlan extends StatelessWidget {
  final String text;

  const RowCheckPlan({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 10),
        const Icon(
          Icons.done,
          color: Colors.deepPurple,
          size: 15,
        ),
        const SizedBox(width: 5),
        Flexible(

          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
      ],
    ).addPaddingOnly(bottom: 10, right: 10);
  }
}
