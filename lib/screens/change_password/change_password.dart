import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/core/service_locator.dart';
import 'package:al_murafiq/screens/change_password/change_pass_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ChangePassword extends StatefulWidget {
  final String? code;
  final String? email;

  const ChangePassword({Key? key, this.code, this.email}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  changePassBloc _bloc = changePassBloc();
  @override
  void initState() {
    // TODO: implement initState
    _bloc.sendEmailSubject.sink.add(widget.email!);
    _bloc.codeSubject.sink.add(widget.code!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //locator<ChangePasswordBloc>().clear();
    final node = FocusScope.of(context);
    return Stack(
      children: [
        Scaffold(
            appBar: GradientAppbar(),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height / 3,
                      ),
                      Container(
                        height: Get.height * 0.5,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/keys.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: Get.height,
                    child: ListView(
                      physics: iosScrollPhysics(),
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: AutoSizeText(
                                    'text_enter_new_pass'.tr,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 20),
                                    minFontSize: 20, maxFontSize: 25,
                                  ).addPaddingOnly(top: 40),
                                ),
                                Image.asset(
                                  Assets.KEY1,
                                  width: 130,
                                ),
                              ],
                            ),
                            Text('text_new_pass'.tr,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade600))
                                .addPaddingOnly(right: 22, left: 10, top: 15),
                            StreamBuilder<bool>(
                                stream: _bloc.passwordSubject.stream,
                                initialData: true,
                                builder: (context, snapshot) {
                                  return StreamBuilder<bool>(
                                      stream:
                                          _bloc.obscurePasswordSubject.stream,
                                      initialData: true,
                                      builder: (context, obscureSnapshot) {
                                        return TextField(
                                          style: TextStyle(fontSize: 18),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color(0xFFE0E7FF),
                                            contentPadding: EdgeInsets.all(9),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: context.accentColor),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black54),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFC2C3DF)),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                borderSide:
                                                    BorderSide(width: 1)),
                                            errorBorder:
                                                const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(6)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors
                                                            .red.shade800)),
                                            hintStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF9797AD)),
                                            errorText: snapshot.data!
                                                ? null
                                                : 'pass_error'.tr,
                                            suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _bloc.obscurePasswordSubject
                                                      .sink
                                                      .add(!_bloc
                                                          .obscurePasswordSubject
                                                          .value);
                                                },
                                                child: Icon(obscureSnapshot
                                                        .data!
                                                    ? Icons.visibility
                                                    : Icons.visibility_off)),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          onChanged: (val) =>
                                              _bloc.changePassword(val),
                                          controller: _bloc.passwordController,
                                          obscureText: obscureSnapshot.data!,
                                        );
                                      });
                                }),
                            Text('text_confirm_pass'.tr,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade600))
                                .addPaddingOnly(right: 22, left: 10, top: 15),
                            StreamBuilder<bool>(
                                stream: _bloc.confirmePasswordSubject.stream,
                                initialData: true,
                                builder: (context, snapshot) {
                                  return StreamBuilder<bool>(
                                      stream: _bloc
                                          .obscureConfirmePasswordSubject
                                          .stream,
                                      initialData: true,
                                      builder: (context, obscureCoSnapshot) {
                                        return TextField(
                                          style: TextStyle(fontSize: 18),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color(0xFFE0E7FF),
                                            contentPadding: EdgeInsets.all(9),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: context.accentColor),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black54),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFC2C3DF)),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                borderSide:
                                                    BorderSide(width: 1)),
                                            errorBorder:
                                                const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(6)),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors
                                                            .red.shade800)),
                                            hintStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF9797AD)),
                                            errorText: snapshot.data!
                                                ? null
                                                : 'pass_error'.tr,
                                            suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _bloc
                                                      .obscureConfirmePasswordSubject
                                                      .sink
                                                      .add(!_bloc
                                                          .obscureConfirmePasswordSubject
                                                          .value);
                                                },
                                                child: Icon(obscureCoSnapshot
                                                        .data!
                                                    ? Icons.visibility
                                                    : Icons.visibility_off)),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          onSubmitted: (_) => node.unfocus(),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          onChanged: (val) =>
                                              _bloc.changeConfirmePassword(val),
                                          controller:
                                              _bloc.confirmePasswordController,
                                          obscureText: obscureCoSnapshot.data!,
                                        );
                                      });
                                }),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: RoundedLoadingButton(
                                child: Text(
                                  'bt_sure'.tr,
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                                height: 50,
                                controller: _bloc.loadingButtonController,
                                color: Colors.blue.shade800,
                                onPressed: () async {
                                  _bloc.loadingButtonController.start();
                                  await _bloc.updatePass(context);
                                  _bloc.loadingButtonController.stop();
                                },
                              ),
                            ),
                          ],
                        ).addPaddingAll(22),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        const Positioned(
            right: 30,
            top: 70,
            child: Image(
              image: AssetImage('assets/images/sign.png'),
            )),
      ],
    );
  }
}
