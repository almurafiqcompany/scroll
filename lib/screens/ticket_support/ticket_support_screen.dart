import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/ticket.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_bloc.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_screen.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TicketSupportScreen extends StatefulWidget {
  @override
  _TicketSupportScreenState createState() => _TicketSupportScreenState();
}

class _TicketSupportScreenState extends State<TicketSupportScreen> {
  AddTicketBloc _addTicketBloc = AddTicketBloc();
  @override
  void initState() {
    _addTicketBloc.fetchAllTickets();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppbar(title: 'text_technical_support'.tr),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(
            Icons.add,
            size: 30,
            color: Color(0xffFFFFFF),
          ),
          backgroundColor: Color(0xff2E5BFF),
          onPressed: () async {

            TicketData ticketData = await  Get.to(AddTicket());
            if (ticketData != null) {
              _addTicketBloc.dataofTicketsofuserSubject
                  .add(_addTicketBloc.dataofTicketsofuserSubject.value..add(ticketData));
            }
          }),
      body: RefreshIndicator(
        onRefresh: () async {

          await _addTicketBloc.fetchAllTickets();
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: StreamBuilder<Tickets>(
            stream: _addTicketBloc.dataofAllTicketSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data.data.length>0){
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SideMenuContainer().addPaddingOnly(bottom: 5),

                          StreamBuilder<List<TicketData>>(
                              stream: _addTicketBloc.dataofTicketsofuserSubject.stream,
                              //initialData: snapshot.data.data,
                              builder: (context, snapshotTicketsofUser) {
                                if(snapshotTicketsofUser.hasData){
                                  if(snapshotTicketsofUser.data.length > 0){
                                    return ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      // reverse: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshotTicketsofUser.data.length,
                                      itemBuilder: (BuildContext context, int index) => ZoomIn(
                                        duration: Duration(milliseconds: 600),
                                        delay: Duration(
                                            milliseconds:
                                            index * 100 > 1000 ? 600 : index * 120),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0),
                                          child: TicketSupport(
                                            subTicket: true,
                                            ticket_id: snapshotTicketsofUser.data[index].id,
                                            name: snapshotTicketsofUser.data[index].subject,
                                            message:'${snapshotTicketsofUser.data[index].details}',
                                            date: snapshotTicketsofUser.data[index].created_at,
                                            status: snapshotTicketsofUser.data[index].status.name,
                                          ).addPaddingHorizontalVertical(
                                              horizontal: 12, vertical: 10),
                                        ),
                                      ),
                                    );
                                  }else{
                                    return SizedBox();
                                  }
                                }else{
                                  return SizedBox();
                                }

                              }
                          )

                      ],
                    ),
                  );
                } else{
                  return SizedBox(
                      height: Get.height,
                      child: const Center(
                          child: Text('Not Found Ticket')));
                }

              } else if(snapshot.hasError){
                return  Center(child: ShowMessageEmtyDialog(message: snapshot.error,pathImg:'assets/images/noDocument.png',));
              }
                else {
                return SizedBox(
                    height: Get.height,
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )));
              }
            }),
      ),
    );
  }
}
