import 'package:al_murafiq/screens/ticket_support/ticket_support_reply_screen.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get/get.dart';

class TicketSupportReplay extends StatelessWidget {
  final String name, message, date,type;

  const TicketSupportReplay(
      {Key key,
      @required this.name,
      @required this.message,
      @required this.type,
      @required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    date,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade900),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ).addPaddingOnly(bottom: 10, right: 5),
              Text(
                message,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,),
              ),
            ],
          )),
    );
  }
}
