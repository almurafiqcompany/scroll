import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/ticket_replay.dart';
import 'package:al_murafiq/screens/ticket_support/ticket_support_replay_bloc.dart';
import 'package:al_murafiq/utils/scroll_physics_like_ios.dart';
import 'package:al_murafiq/widgets/ticket_support_replay_widget.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketSupportReplyScreen extends StatefulWidget {
  final int ticket_id;

  const TicketSupportReplyScreen({Key key, this.ticket_id}) : super(key: key);
  @override
  _TicketSupportReplyScreenState createState() => _TicketSupportReplyScreenState();
}

class _TicketSupportReplyScreenState extends State<TicketSupportReplyScreen> {
  TicketSupportReplayBloc _ticketSupportReplayBloc=TicketSupportReplayBloc();

  @override
  void initState() {
    _ticketSupportReplayBloc.fetchAllTicketsSupportReplay(ticket_id: widget.ticket_id);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GradientAppbar(title: 'text_technical_support'.tr),

      body: Stack(
        children: [
          StreamBuilder<TicketsSupportReplay>(
              stream: _ticketSupportReplayBloc.dataofAllTicketSupportReplaySubject.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: iosScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     CircleAvatar(
                        //       backgroundColor: const Color(0xFFCDECF5),
                        //       radius: 25,
                        //       child: FaIcon(FontAwesomeIcons.solidQuestionCircle,
                        //           color: Colors.blue.shade900),
                        //     ),
                        //     const SizedBox(width: 20),
                        //     Text(
                        //       context.translate('da3m'),
                        //       style: const TextStyle(
                        //           fontSize: 25,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ).addPaddingOnly(top: 30, bottom: 10),
                        SizedBox(height: 20,),
                        TicketSupport(
                          subTicket: false,
                          ticket_id: snapshot.data.data[0].id,
                          name: snapshot.data.data[0].subject,
                          message:
                          snapshot.data.data[0].details,
                          date: snapshot.data.data[0].created_at,
                          status: snapshot.data.data[0].status.name,
                        ).addPaddingOnly(left: 10, right: 10, bottom: 20),

                        if (snapshot.data.data[0].data != null)
                          Container(
                            height: Get.height*0.5,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.data[0].data.length,
                              itemBuilder: (BuildContext context, int index) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                  child:
                                  TicketSupportReplay(
                                    type: snapshot.data.data[0].data[index].user.type,
                                    name: snapshot.data.data[0].data[index].user.name,
                                    message:
                                    snapshot.data.data[0].data[index].reply,
                                    date: snapshot.data.data[0].data[index].created_at,
                                  ).addPaddingOnly(left: snapshot.data.data[0].data[index].user.type=='Admin'?10:50,
                                      right: snapshot.data.data[0].data[index].user.type=='Admin'?50:10,
                                      bottom: 20)
                              ),
                            ),
                          ) else SizedBox() ,
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         child: StreamBuilder<bool>(
                        //             stream: _ticketSupportReplayBloc.sendReplaySubject.stream,
                        //             initialData: true,
                        //             builder: (context, snapshot) {
                        //               return TextField(
                        //                 onChanged: (val) => _ticketSupportReplayBloc.changeDetail(val),
                        //                 controller: _ticketSupportReplayBloc.sendReplayController,
                        //                 textAlign: TextAlign.center,
                        //                 decoration: InputDecoration(
                        //                   errorText: snapshot.data
                        //                       ? null
                        //                       :'enter message',
                        //                   contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                        //                   hintText: 'hint_your_problem'.tr,
                        //                   hintStyle: const TextStyle(color: Colors.grey),
                        //                   enabledBorder: OutlineInputBorder(
                        //                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        //                     borderSide:
                        //                     BorderSide(color: Colors.grey.shade400, width: 0.7),
                        //                   ),
                        //                   focusedBorder: OutlineInputBorder(
                        //                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        //                     borderSide:
                        //                     BorderSide(color: Colors.grey.shade400, width: 0.7),
                        //                   ),
                        //                 ),
                        //               ).addPaddingAll(10);
                        //             }
                        //         ),
                        //       ),
                        //
                        //       RoundedLoadingButton(
                        //         child: Text(
                        //           'bt_send'.tr,
                        //           style: kTextStyle.copyWith(color: Colors.white),
                        //         ),
                        //         controller: _ticketSupportReplayBloc.loadingButtonController,
                        //         color: Color(0xff2E5BFF),
                        //         onPressed: () async {
                        //           _ticketSupportReplayBloc.loadingButtonController.start();
                        //           await _ticketSupportReplayBloc.addsendReplay(ticket_id: widget.ticket_id,context: context);
                        //           _ticketSupportReplayBloc.loadingButtonController.stop();
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),

                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                      height: Get.height,
                      child: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                          )));
                }
                // return SingleChildScrollView(
                //   physics: iosScrollPhysics(),
                //   child: Column(
                //     children: <Widget>[
                //       // Row(
                //       //   mainAxisAlignment: MainAxisAlignment.center,
                //       //   children: <Widget>[
                //       //     CircleAvatar(
                //       //       backgroundColor: const Color(0xFFCDECF5),
                //       //       radius: 25,
                //       //       child: FaIcon(FontAwesomeIcons.solidQuestionCircle,
                //       //           color: Colors.blue.shade900),
                //       //     ),
                //       //     const SizedBox(width: 20),
                //       //     Text(
                //       //       context.translate('da3m'),
                //       //       style: const TextStyle(
                //       //           fontSize: 25,
                //       //           color: Colors.black,
                //       //           fontWeight: FontWeight.bold),
                //       //     ),
                //       //   ],
                //       // ).addPaddingOnly(top: 30, bottom: 10),
                //       SizedBox(height: 20,),
                //       const TicketSupport(
                //         name: 'Layila Said Ahmed',
                //         message:
                //             'A Terms and Conditions agreement is not legally required. However,having one comes with a number of important benefits for both you and your users/customers',
                //         date: '20 Jun. 2020',
                //       ).addPaddingOnly(left: 10, right: 10, bottom: 20),
                //
                //       Container(
                //         height: (Get.height/3),
                //         child: ListView.builder(
                //           physics: ClampingScrollPhysics(),
                //           shrinkWrap: true,
                //           scrollDirection: Axis.vertical,
                //           itemCount: 3,
                //           itemBuilder: (BuildContext context, int index) => Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 0),
                //             child: const TicketSupport(
                //               name: 'Layila Said Ahmed',
                //               message:
                //               'A Terms and Conditions agreement is not legally required. However,having one comes with a number of important benefits for both you and your users/customers',
                //               date: '20 Jun. 2020',
                //             ).addPaddingOnly(left: 50, right: 10,bottom: 20),
                //           ),
                //         ),
                //       ),
                //       Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Column(
                //           children: [
                //             Container(
                //               child: TextField(
                //                 textAlign: TextAlign.center,
                //                 decoration: InputDecoration(
                //                   contentPadding: const EdgeInsets.only(top: 20, bottom: 70),
                //                   hintText: 'Leave Your Complaint Here',
                //                   hintStyle: const TextStyle(color: Colors.grey),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                //                     borderSide:
                //                         BorderSide(color: Colors.grey.shade400, width: 0.7),
                //                   ),
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                //                     borderSide:
                //                         BorderSide(color: Colors.grey.shade400, width: 0.7),
                //                   ),
                //                 ),
                //               ).addPaddingAll(12),
                //             ),
                //             Container(
                //               width: 150,
                //               height: 50,
                //               child: RaisedButton(
                //                 color: Colors.blue.shade800,
                //                 onPressed: () {},
                //                 child: Text(
                //                   context.translate('sure'),
                //                   style: const TextStyle(color: Colors.white),
                //                 ),
                //               ),
                //             ).addPaddingOnly(bottom: 12),
                //           ],
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // );
              }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: StreamBuilder<bool>(
                      stream: _ticketSupportReplayBloc.sendReplaySubject.stream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: (val) => _ticketSupportReplayBloc.changeDetail(val),
                          controller: _ticketSupportReplayBloc.sendReplayController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            errorText: snapshot.data
                                ? null
                                :'enter message',
                            contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                            hintText: 'hint_your_problem'.tr,
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 0.7),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 0.7),
                            ),
                          ),
                        ).addPaddingAll(10);
                      }
                  ),
                ),

                RoundedLoadingButton(
                  child: Text(
                    'bt_send'.tr,
                    style: kTextStyle.copyWith(color: Colors.white),
                  ),
                  controller: _ticketSupportReplayBloc.loadingButtonController,
                  color: Color(0xff2E5BFF),
                  onPressed: () async {
                    _ticketSupportReplayBloc.loadingButtonController.start();
                    await _ticketSupportReplayBloc.addsendReplay(ticket_id: widget.ticket_id,context: context);
                    _ticketSupportReplayBloc.loadingButtonController.stop();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
