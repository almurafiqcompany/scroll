// import 'dart:async';
//
// import 'package:al_murafiq/api/api_manager.dart';
// import 'package:al_murafiq/base_bloc.dart';
// import 'package:al_murafiq/extensions/extensions.dart';
// import 'package:al_murafiq/models/models.dart';
// import 'package:al_murafiq/core/service_locator.dart';
// import 'package:al_murafiq/utils/utils.dart';
// import 'package:al_murafiq/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
//
// class RegisterUserDelegateBloc with ValidatorsStream implements BaseBloc {
//   bool _obscure = true;
//   final BehaviorSubject<int> _tapBarController = BehaviorSubject<int>();
//   final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
//   final BehaviorSubject<String> _nationalIdController =
//       BehaviorSubject<String>();
//   final BehaviorSubject<String> _genderController = BehaviorSubject<String>();
//   final BehaviorSubject<DateTime> _birthDateController =
//       BehaviorSubject<DateTime>();
//   final BehaviorSubject<String> _languageController = BehaviorSubject<String>();
//   final BehaviorSubject<String> _phoneController = BehaviorSubject<String>();
//   final BehaviorSubject<String> _mailController = BehaviorSubject<String>();
//   final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
//   final BehaviorSubject<String> _confirmPasswordController =
//       BehaviorSubject<String>();
//
//   final TextEditingController nameTextController = TextEditingController();
//   final TextEditingController nationalIdTextController =
//       TextEditingController();
//   final TextEditingController mailTextController = TextEditingController();
//   final TextEditingController passwordTextController = TextEditingController();
//   final TextEditingController confirmPasswordTextController =
//       TextEditingController();
//   final TextEditingController phoneTextController = TextEditingController();
//
//   Function(int) get tapBarChanged => _tapBarController.sink.add;
//
//   Stream<int> get tapBarStream => _tapBarController.stream;
//
//   Function(String) get emailChanged => _mailController.sink.add;
//
//   Stream<String> get email => _mailController.stream.transform(emailValidator);
//
//   Function(String) get phoneChanged => _phoneController.sink.add;
//
//   Stream<String> get phone => _phoneController.stream.transform(phoneValidator);
//
//   Function(String) get nameChanged => _nameController.sink.add;
//
//   Stream<String> get nationalId =>
//       _nationalIdController.stream.transform(nationalIdValidator);
//
//   Function(String) get nationalIdChanged => _nationalIdController.sink.add;
//
//   Stream<String> get name => _nameController.stream.transform(nameValidator);
//
//   Stream<DateTime> get birthDate => _birthDateController.stream;
//
//   Function(String) get passwordChanged => _passwordController.sink.add;
//
//   Stream<String> get password => _passwordController.stream.map((String event) {
//         confirmPasswordChanged(_confirmPasswordController.value);
//         return event;
//       }).transform(passwordValidator);
//
//   Function(String) get confirmPasswordChanged =>
//       _confirmPasswordController.sink.add;
//
//   Stream<String> get confirmPassword => _confirmPasswordController.stream
//           .transform(StreamTransformer<String, String>.fromHandlers(
//               handleData: (String password, EventSink<String> sink) {
//         if (password == _passwordController.value) {
//           sink.add(password);
//         } else {
//           sink.addError('يجب ان يكون الرقم السري متطابق');
//         }
//       }));
//
//   Function(String) get genderChanged => _genderController.sink.add;
//
//   Stream<String> get gender => _genderController.stream;
//
//   Function(String) get languageChanged => _languageController.sink.add;
//
//   Stream<String> get language => _languageController.stream;
//
//   Stream<bool> get submitCheck => Rx.combineLatest9(
//       email,
//       phone,
//       nationalId,
//       name,
//       password,
//       confirmPassword,
//       gender,
//       language,
//       birthDate,
//       (
//         String e,
//         String ph,
//         String nid,
//         String n,
//         String p,
//         String cp,
//         String g,
//         String l,
//         DateTime bD,
//       ) =>
//           true);
//
//   bool get obscure => _obscure;
//
//   void obscureChanged() {
//     _obscure = !_obscure;
//     _passwordController.sink.add(_passwordController.value ?? '');
//     _confirmPasswordController.sink.add(_confirmPasswordController.value ?? '');
//   }
//
//   Future<void> birthDateChanged(BuildContext context) async {
//     final DateTime dateTime = await _gatDateFromPicker(context);
//     if (dateTime != null) {
//       _birthDateController.add(dateTime);
//     }
//   }
//
//   Future<void> submit(BuildContext context, String userType) async {
//     final BuildContext contextForHide =
//         await CustomDialog.showProgressDialog(context);
//     final ResponseApi<RegisterResponseModel> dataOrError =
//         await locator<AccountRepository>().register(
//             email: _mailController.value,
//             password: _passwordController.value,
//             phone: _phoneController.value,
//             name: _nameController.value,
//             nationalId: _nationalIdController.value,
//             birthDate: _birthDateController.value.toIso8601String(),
//             type: userType,
//             gender: _genderController.value,
//             lang: _languageController.value == 'العربية' ? 'ar' : 'en');
//
//     if (dataOrError.status == ApiStatus.SUCCESS) {
//       final RegisterResponseModel userResponse = dataOrError.data;
//       CustomDialog.hideDialog(contextForHide);
//       CustomDialog.showWithOk(
//           context, 'تم تسجيل حسابك', userResponse.user.name);
//     } else {
//       CustomDialog.hideDialog(contextForHide);
//       CustomDialog.showWithOk(context, 'حدثت مشكله!', dataOrError.error);
//     }
//   }
//
//   void continueBtn() {
//     tapBarChanged(0);
//   }
//
//   void clear() {
//     _mailController.add('');
//
//     _passwordController.add('');
//
//     _nameController.add('');
//
//     _nationalIdController.add('');
//
//     _genderController.add('Male');
//
//     _languageController.add('العربية');
//
//     _birthDateController.add(DateTime.now());
//
//     _phoneController.add('');
//
//     _confirmPasswordController.add('');
//
//     nameTextController.clear();
//     nationalIdTextController.clear();
//     mailTextController.clear();
//     passwordTextController.clear();
//     confirmPasswordTextController.clear();
//     phoneTextController.clear();
//   }
//
//   @override
//   Future<void> dispose() async {
//     await _mailController?.drain();
//     await _mailController?.close();
//
//     await _passwordController?.drain();
//     await _passwordController?.close();
//
//     await _nameController?.drain();
//     await _nameController?.close();
//
//     await _nationalIdController?.drain();
//     await _nationalIdController?.close();
//
//     await _genderController?.drain();
//     await _genderController?.close();
//
//     await _birthDateController?.drain();
//     await _birthDateController?.close();
//
//     await _languageController?.drain();
//     await _languageController?.close();
//
//     await _phoneController?.drain();
//     await _phoneController?.close();
//
//     await _confirmPasswordController?.drain();
//     await _confirmPasswordController?.close();
//
//     await _tapBarController?.drain();
//     await _tapBarController?.close();
//   }
//
//   Future<DateTime> _gatDateFromPicker(BuildContext context) async {
//     return await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().subtract(
//         const Duration(days: 4000),
//       ),
//       firstDate: DateTime.now().subtract(
//         const Duration(days: 28000),
//       ),
//       lastDate: DateTime.now().subtract(
//         const Duration(days: 2000),
//       ),
//       builder: (BuildContext context, Widget child) {
//         return Theme(
//           data: ThemeData().copyWith(
//             colorScheme: ColorScheme.light(
//               primary: context.accentColor,
//             ),
//           ),
//           child: child,
//         );
//       },
//     );
//   }
// }
