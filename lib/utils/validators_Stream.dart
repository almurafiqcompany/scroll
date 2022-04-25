import 'dart:async';

import 'package:al_murafiq/utils/utils.dart';

mixin ValidatorsStream {
    StreamTransformer<String, String> nameValidator =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (String name, EventSink<String> sink) =>
        (Validator.isName(name))
            ? sink.add(name)
            : sink.addError('name is not valid'));

    StreamTransformer<String, String> emailValidator =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (String email, EventSink<String> sink) =>
        (Validator.isEmail(email))
            ? sink.add(email)
            : sink.addError('Email is not valid'));
    StreamTransformer<String, String> phoneValidator =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (String phone, EventSink<String> sink) =>
        (Validator.isEGPhoneNumber(phone))
            ? sink.add(phone)
            : sink.addError('phone is not valid'));

    StreamTransformer<String, String> nationalIdValidator =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (String nationalId, EventSink<String> sink) =>
        (Validator.isNationalId(nationalId))
            ? sink.add(nationalId)
            : sink.addError('national Id is not valid'));

    StreamTransformer<String, String> passwordValidator =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (String password, EventSink<String> sink) =>
        (Validator.isPassword(password))
            ? sink.add(password)
            : sink.addError(
            'Password length should be greater than 7 chars.'));

    StreamTransformer<String, String> verificationCodeValidator =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (String password, EventSink<String> sink) =>
        (Validator.isVerificationCode(password))
            ? sink.add(password)
            : sink.addError('Code length should be equal to 6 chars.'));

    StreamTransformer<bool, bool> obscureChanger =
    StreamTransformer<bool, bool>.fromHandlers(
        handleData: (bool obscure, EventSink<bool> sink) =>
            sink.add(!obscure));
}