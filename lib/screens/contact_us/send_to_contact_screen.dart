import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/contact_us/send_to_contact_bloc.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_bloc.dart';
import 'package:al_murafiq/widgets/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get/get.dart';

class SendContactScreen extends StatefulWidget {
  @override
  _SendContactScreenState createState() => _SendContactScreenState();
}

class _SendContactScreenState extends State<SendContactScreen> {
  SendToContactBloc _sendToContactBloc = SendToContactBloc();

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
                    'side_contactus'.tr,
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
                        stream: _sendToContactBloc.subjectSubject.stream,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black54),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFFC2C3DF)),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(width: 1)),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.red.shade800)),
                              hintText: 'hint_subject'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText:
                                  snapshot.data! ? null : 'email_error'.tr,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            onChanged: (val) =>
                                _sendToContactBloc.changesubject(val),
                            controller: _sendToContactBloc.subjectController,
                          );
                        }),
                    SizedBox(height: 25),
                    StreamBuilder<bool>(
                        stream: _sendToContactBloc.detailSubject.stream,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black54),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFFC2C3DF)),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(width: 1)),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.red.shade800)),
                              hintText: 'message'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText:
                                  snapshot.data! ? null : 'details_error'.tr,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => node.unfocus(),
                            onChanged: (val) =>
                                _sendToContactBloc.changeDetail(val),
                            controller: _sendToContactBloc.detailsController,
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
                'bt_send'.tr,
                style: kTextStyle.copyWith(color: Colors.white),
              ),
              controller: _sendToContactBloc.loadingButtonController,
              color: Color(0xff2E5BFF),
              onPressed: () async {
                _sendToContactBloc.loadingButtonController.start();
                await _sendToContactBloc.addSendToContact(context);
                _sendToContactBloc.loadingButtonController.stop();
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
