import 'package:al_murafiq/screens/ticket_support/ticket_support_reply_screen.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get/get.dart';

class TicketSupport extends StatelessWidget {
  final String? name, message, date,status;
  final int? ticket_id;
  final bool? subTicket;
  const TicketSupport(
      {Key? key,
      @required this.name,
      @required this.message,
      @required this.ticket_id,
      @required this.subTicket,
      @required this.status,
      @required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: (){
          subTicket!?Get.to(TicketSupportReplyScreen(ticket_id: ticket_id!,)):null;
        },
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
                    Column(
                      children: [
                        Text(
                          date!,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade900),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          status!,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade900),
                        ),


                      ],
                    ),
                    Text(
                      name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ).addPaddingOnly(bottom: 10, right: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subTicket!? GestureDetector(
                      onTap: (){
                        subTicket!?Get.to(TicketSupportReplyScreen(ticket_id: ticket_id!,)):null;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                       width: Get.width/6,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'enter'.tr,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ):SizedBox(),
                    Expanded(
                      child: Text(
                        message!,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,),
                      ),
                    ),

                  ],
                ),
              ],
            )),
      ),
    );
  }
}
