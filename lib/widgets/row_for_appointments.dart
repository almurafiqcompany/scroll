import 'package:flutter/material.dart';

class RowForAppointments extends StatelessWidget {
  final String? text, appointment;

  const RowForAppointments(
      {Key? key, @required this.text, @required this.appointment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(text!, style: const TextStyle(fontSize: 17)),
        const SizedBox(width: 15),
        Text('${appointment!.split('T')[0].trim()}',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600))
      ],
    );
  }
}
