import 'utils.dart';

class Urls {
  static const String LOGIN = '${Constants.API_URL}/login';
  static const String REGISTER = '${Constants.API_URL}/registers/store';
  static const String FORGET_PASSWORD = '${Constants.API_URL}/reset-password/send-mail';
  static const String FORGET_PASSWORD_CHECK_CODE = '${Constants.API_URL}/reset-password/check-code';
  static const String UPDATE_PASSWORD = '${Constants.API_URL}/reset-password/update-password';
}