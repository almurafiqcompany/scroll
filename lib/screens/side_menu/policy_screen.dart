import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/policy.dart';
import 'package:al_murafiq/screens/side_menu/about_us_bloc.dart';
import 'package:al_murafiq/screens/side_menu/policy_bloc.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  PolicyBloc _policyBloc = PolicyBloc();

  @override
  void initState() {
    _policyBloc.fetchPolicy();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppbar(),
      body: SingleChildScrollView(
        physics: iosScrollPhysics(),
        child: StreamBuilder<Policy>(
            stream: _policyBloc.dataOfPolicySubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: const Color(0xFFCDECF5),
                          radius: 25,
                          child: FaIcon(FontAwesomeIcons.exclamationCircle,
                              color: Colors.blue.shade900),
                        ),
                        const SizedBox(width: 22),
                        Text(
                          snapshot.data!.name!,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black),
                        ),
                      ],
                    ).addPaddingOnly(top: 30, bottom: 10, left: 10, right: 10),
                    // Image.asset(Assets.GOOGLE,
                    //   height: 220,
                    //   width: (Get.width)-10,
                    //   fit: BoxFit.cover,
                    // ),
                    Image.network(
                      '$ImgUrl${snapshot.data!.image}',
                      height: 220,
                      width: (Get.width) - 10,
                      fit: BoxFit.cover,
                    ),
                    Container(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 22, right: 12, left: 12),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  snapshot.data!.desc!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ))
                        .addPaddingHorizontalVertical(
                            horizontal: 15, vertical: 15)
                  ],
                ).addPaddingOnly(bottom: 15);
              } else if (snapshot.hasError) {
                return Container(
                    height: Get.height * 0.8,
                    child: Center(
                        child: ShowMessageEmtyDialog(
                      message: 'snapshot.error',
                      pathImg: 'assets/images/noDocument.png',
                    )));
              } else {
                //return SizedBox();
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
