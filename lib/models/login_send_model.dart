import 'dart:convert';

class LoginSendModel {
  LoginSendModel(this.email, this.password);

  final String email;

  final String password;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  String toRawJson() => json.encode(toJson());
}
