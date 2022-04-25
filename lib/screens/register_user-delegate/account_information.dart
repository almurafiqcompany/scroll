import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_user-delegate/register_user_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInformation extends StatefulWidget {
  final RegisterUserBloc? bloc;

  const AccountInformation({Key? key, this.bloc}) : super(key: key);

  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return ListView(
      physics: iosScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text('text_email'.tr,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600))
                    .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                    .addPaddingOnly(top: 15),
              ],
            ),
            StreamBuilder<bool>(
                stream: widget.bloc!.emailOrPhoneSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E7FF),
                      contentPadding: EdgeInsets.all(9),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: context.accentColor),
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
                      hintText: 'hint_email'.tr,
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF9797AD)),
                      errorText: snapshot.data! ? null : 'email_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => widget.bloc!.changeEmailOrPhone(val),
                    controller: widget.bloc!.emailOrPhoneController,
                  );
                }),
            Row(
              children: [
                Text('text_password'.tr,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600))
                    .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                    .addPaddingOnly(top: 15),
              ],
            ),
            StreamBuilder<bool>(
                stream: widget.bloc!.passwordSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return StreamBuilder<bool>(
                      stream: widget.bloc!.obscurePasswordSubject.stream,
                      initialData: true,
                      builder: (context, obscureSnapshot) {
                        return TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE0E7FF),
                            contentPadding: EdgeInsets.all(9),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red.shade800)),
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Color(0xFF9797AD)),
                            errorText: snapshot.data! ? null : 'pass_error'.tr,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  widget.bloc!.obscurePasswordSubject.sink.add(
                                      !widget
                                          .bloc!.obscurePasswordSubject.value);
                                },
                                child: Icon(obscureSnapshot.data!
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (val) => widget.bloc!.changePassword(val),
                          controller: widget.bloc!.passwordController,
                          obscureText: obscureSnapshot.data!,
                        );
                      });
                }),
            Row(
              children: [
                Text('text_confirm_pass'.tr,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600))
                    .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                    .addPaddingOnly(top: 15),
              ],
            ),
            StreamBuilder<bool>(
                stream: widget.bloc!.confirmePasswordSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return StreamBuilder<bool>(
                      stream:
                          widget.bloc!.obscureConfirmePasswordSubject.stream,
                      initialData: true,
                      builder: (context, obscureCoSnapshot) {
                        return TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE0E7FF),
                            contentPadding: EdgeInsets.all(9),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                  width: 1, color: context.accentColor),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red.shade800)),
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Color(0xFF9797AD)),
                            errorText: snapshot.data! ? null : 'pass_error'.tr,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  widget
                                      .bloc!.obscureConfirmePasswordSubject.sink
                                      .add(!widget
                                          .bloc!
                                          .obscureConfirmePasswordSubject
                                          .value);
                                },
                                child: Icon(obscureCoSnapshot.data!
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (val) =>
                              widget.bloc!.changeConfirmePassword(val),
                          controller: widget.bloc!.confirmePasswordController,
                          obscureText: obscureCoSnapshot.data!,
                        );
                      });
                }),
            Row(
              children: [
                Text('text_phone'.tr,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600))
                    .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                    .addPaddingOnly(top: 15),
              ],
            ),
            StreamBuilder<bool>(
                stream: widget.bloc!.phoneSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E7FF),
                      contentPadding: EdgeInsets.all(9),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: context.accentColor),
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
                      hintText: '',
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF9797AD)),
                      errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => node.unfocus(),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) => widget.bloc!.changePhone(val),
                    controller: widget.bloc!.phoneController,
                  );
                }),
            // StreamBuilder<bool>(
            //     stream: locator<RegisterUserDelegateBloc>().submitCheck,
            //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            //       return CustomedButton(
            //         text: context.translate('sure'),
            //         height: 50,
            //         onPressed:
            //         // snapshot.data ?? false
            //         //     ? () =>
            //             // locator<RegisterUserDelegateBloc>()
            //             //     .submit(context, userType)
            //             // :
            //         // null,
            //       null).addPaddingAll(22);
            //     }),
            SizedBox(
              height: 15,
            ),
            const AlreadyHaveAnAccount(
              textColor: Colors.black,
            )
          ],
        ).addPaddingOnly(bottom: 28),
      ],
    );
  }
}
