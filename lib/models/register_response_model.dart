import 'dart:convert';

class RegisterResponseModel {
  RegisterResponseModel({
    this.status,
    this.user,
    this.message,
  });

  final int? status;
  final UserRegister? user;
  final String? message;

  RegisterResponseModel copyWith({
    int? status,
    UserRegister? user,
    String? message,
  }) =>
      RegisterResponseModel(
        status: status ?? this.status,
        user: user ?? this.user,
        message: message ?? this.message,
      );

  factory RegisterResponseModel.fromRawJson(String str) =>
      RegisterResponseModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json['status'],
        user: UserRegister.fromJson(json['user']),
        message: json['message'],
      );

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'status': status,
  //       'user': user.toJson(),
  //       'message': message,
  //     };
}

class UserRegister {
  UserRegister({
    this.provider,
    this.providerId,
    this.name,
    this.userableId,
    this.userableType,
    this.email,
    this.emailVerifiedAt,
    this.rememberToken,
    this.avatar,
    this.birthDate,
    this.gender,
    this.defaultLang,
    this.phone,
    this.cityId,
    this.areaId,
    this.zoneId,
    this.resetCode,
    this.nationalId,
    this.fcmToken,
    this.active,
    this.type,
    this.countryId,
  });

  final dynamic provider;
  final dynamic providerId;
  final String? name;
  final int? userableId;
  final String? userableType;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic rememberToken;
  final dynamic avatar;
  final dynamic birthDate;
  final dynamic gender;
  final String? defaultLang;
  final String? phone;
  final int? cityId;
  final int? areaId;
  final int? zoneId;
  final dynamic resetCode;
  final dynamic nationalId;
  final dynamic fcmToken;
  final int? active;
  final String? type;
  final int? countryId;

  UserRegister copyWith({
    dynamic provider,
    dynamic providerId,
    String? name,
    int? userableId,
    String? userableType,
    String? email,
    dynamic emailVerifiedAt,
    dynamic rememberToken,
    dynamic avatar,
    dynamic birthDate,
    dynamic gender,
    String? defaultLang,
    String? phone,
    int? cityId,
    int? areaId,
    int? zoneId,
    dynamic resetCode,
    dynamic nationalId,
    dynamic fcmToken,
    int? active,
    String? type,
    int? countryId,
  }) =>
      UserRegister(
        provider: provider ?? this.provider,
        providerId: providerId ?? this.providerId,
        name: name ?? this.name,
        userableId: userableId ?? this.userableId,
        userableType: userableType ?? this.userableType,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        rememberToken: rememberToken ?? this.rememberToken,
        avatar: avatar ?? this.avatar,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        defaultLang: defaultLang ?? this.defaultLang,
        phone: phone ?? this.phone,
        cityId: cityId ?? this.cityId,
        areaId: areaId ?? this.areaId,
        zoneId: zoneId ?? this.zoneId,
        resetCode: resetCode ?? this.resetCode,
        nationalId: nationalId ?? this.nationalId,
        fcmToken: fcmToken ?? this.fcmToken,
        active: active ?? this.active,
        type: type ?? this.type,
        countryId: countryId ?? this.countryId,
      );

  factory UserRegister.fromRawJson(String str) =>
      UserRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        provider: json['provider'],
        providerId: json['provider_id'],
        name: json['name'],
        userableId: json['userable_id'],
        userableType: json['userable_type'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        rememberToken: json['remember_token'],
        avatar: json['avatar'],
        birthDate: json['birth_date'],
        gender: json['gender'],
        defaultLang: json['default_lang'],
        phone: json['phone'],
        cityId: json['city_id'],
        areaId: json['area_id'],
        zoneId: json['zone_id'],
        resetCode: json['reset_code'],
        nationalId: json['national_id'],
        fcmToken: json['fcm_token'],
        active: json['active'],
        type: json['type'],
        countryId: json['country_id'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'provider': provider,
        'provider_id': providerId,
        'name': name,
        'userable_id': userableId,
        'userable_type': userableType,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'remember_token': rememberToken,
        'avatar': avatar,
        'birth_date': birthDate,
        'gender': gender,
        'default_lang': defaultLang,
        'phone': phone,
        'city_id': cityId,
        'area_id': areaId,
        'zone_id': zoneId,
        'reset_code': resetCode,
        'national_id': nationalId,
        'fcm_token': fcmToken,
        'active': active,
        'type': type,
        'country_id': countryId,
      };
}
