import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_bloc.dart';
import 'package:al_murafiq/widgets/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get/get.dart';
class AddTicket extends StatefulWidget {
  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  AddTicketBloc _addTicketBloc=AddTicketBloc();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: GradientAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'text_add_ticket'.tr,
                    style: kTextStyle.copyWith(fontSize: 17),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [

                    StreamBuilder<bool>(
                        stream: _addTicketBloc.subjectSubject.stream,
                        initialData: true,
                        builder: (context, snapshot) {
                          return TextField(
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFE0E7FF),
                              contentPadding: EdgeInsets.all(9),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                BorderSide(width: 1, color: kAccentColor),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(width: 1, color: Colors.black54),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(width: 1)),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(width: 1, color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.red.shade800)),
                              hintText: 'hint_subject'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText: snapshot.data
                                  ? null
                                  :'hint_subject_error'.tr,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            onChanged: (val) => _addTicketBloc.changesubject(val),
                            controller: _addTicketBloc.subjectController,
                          );
                        }),
                    SizedBox(height: 25),
                    StreamBuilder<bool>(
                      stream: _addTicketBloc.detailSubject.stream,
                        initialData: true,
                        builder: (context, snapshot) {
                          return TextField(
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.multiline,
                            maxLines: 40,
                            minLines: 5,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFE0E7FF),
                              contentPadding: EdgeInsets.all(9),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                BorderSide(width: 1, color: kAccentColor),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(width: 1, color: Colors.black54),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(width: 1)),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(width: 1, color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.red.shade800)),
                              hintText: 'hint_details'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText: snapshot.data
                                  ? null
                                  :'hint_details_error'.tr,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => node.unfocus(),
                            onChanged: (val) => _addTicketBloc.changeDetail(val),
                             controller: _addTicketBloc.detailsController,
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RoundedLoadingButton(
              child: Text(
               'bt_add'.tr,
                style: kTextStyle.copyWith(color: Colors.white),
              ),
              controller: _addTicketBloc.loadingButtonController,
              color: Color(0xff2E5BFF),
              onPressed: () async {
                _addTicketBloc.loadingButtonController.start();
                await _addTicketBloc.addTicketPost(context);
                _addTicketBloc.loadingButtonController.stop();
              },
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
