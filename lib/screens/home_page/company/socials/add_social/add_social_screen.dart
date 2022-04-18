import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/home_page/company/socials/add_social/add_social_bloc.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_bloc.dart';
import 'package:al_murafiq/widgets/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
class AddSocialScreen extends StatefulWidget {
  final int company_id;

  const AddSocialScreen({Key key, this.company_id}) : super(key: key);
  @override
  _AddSocialScreenState createState() => _AddSocialScreenState();
}

class _AddSocialScreenState extends State<AddSocialScreen> {
  AddSocialBloc _addSocialBloc=AddSocialBloc();


  var socialItemsNames = {
    'facebook'.tr : 'facebook',
    'twitter'.tr : 'twitter',
    'instagram'.tr : 'instagram',
    'whatsapp'.tr : 'whatsapp',
    'snapshat'.tr : 'snapshat',
    'googleplus'.tr : 'googleplus',
    'website'.tr : 'website',
    'other'.tr : 'other',
  };
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
                    'text_add_social'.tr,
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
                    Container(
                      decoration: const BoxDecoration(
                        color:Color(0xFFE0E7FF) ,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),

                      child: DropDown<SocialItem>(

                        items: _addSocialBloc.socialItems,
                        hint: Text('text_social'.tr),
                        isExpanded: true,
                        customWidgets:_addSocialBloc.socialItems.map((e) {
                          return Row(
                            children: [
                              Icon(e.icon),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Text(
                                    e.name,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ],
                          );
                        }).toList(),
                        onChanged: (SocialItem item) {

                          // widget.controller.socialItem = item;
                          _addSocialBloc.typeSocialSubject.sink.add(socialItemsNames[item.name]);
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    StreamBuilder<bool>(
                        stream: _addSocialBloc.linkSubject.stream,
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
                              hintText: 'hint_link'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText: snapshot.data
                                  ? null
                                  :'link_error'.tr,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            onChanged: (val) => _addSocialBloc.changeLink(val),
                            controller: _addSocialBloc.linkController,
                          );
                        }),


                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15),
                    //   child: StreamBuilder<List<SocialController>>(
                    //       stream: _addBranchesOfCompanyBloc.socialSubject.stream,
                    //       initialData: [SocialController()],
                    //       builder: (context, snapshot) {
                    //         print(
                    //             'sasa${_addBranchesOfCompanyBloc.socialSubject.stream.value}');
                    //         return Column(
                    //           children:
                    //           List.generate(snapshot.data.length, (index) {
                    //             return SocialWidget(
                    //               socialItems: _addBranchesOfCompanyBloc.socialItems,
                    //               controller: snapshot.data[index],
                    //             );
                    //           }),
                    //         );
                    //       }),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 25),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           _addBranchesOfCompanyBloc.socialSubject.sink.add(
                    //               _addBranchesOfCompanyBloc.socialSubject.value
                    //                 ..add(SocialController()));
                    //         },
                    //         child: Container(
                    //           decoration: const BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius:
                    //               BorderRadius.all(Radius.circular(8.0)),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   spreadRadius: 5,
                    //                   color: Color(0xffB7B6B6),
                    //                   blurRadius: 7,
                    //                   offset: Offset(0, 4),
                    //                 ),
                    //               ]),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(12.0),
                    //             child: Text(
                    //               'Add new social media account',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold, fontSize: 17),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
              controller: _addSocialBloc.loadingButtonController,
              color: Color(0xff2E5BFF),
              onPressed: () async {
                _addSocialBloc.loadingButtonController.start();
                await _addSocialBloc.addSocial(widget.company_id,context);
                _addSocialBloc.loadingButtonController.stop();
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
