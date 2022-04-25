import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  final int? status;
  final String? message;
  final Data? data;

  LoginResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
  }) =>
      LoginResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json['status'],
        message: json['message'],
        data: Data.fromJson(json['data']),
      );

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'status': status,
  //       'message': message,
  //       'data': data.toJson(),
  //     };
}

class Data {
  Data({
    this.user,
    this.info,
  });

  final User? user;
  final Info? info;

  Data copyWith({
    User? user,
    Info? info,
  }) =>
      Data(
        user: user ?? this.user,
        info: info ?? this.info,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json['user']),
        info: Info.fromJson(json['info']),
      );

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'user': user.toJson(),
  //       'info': info.toJson(),
  //     };
}

class Info {
  Info({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descAr,
    this.descEn,
    this.addressAr,
    this.addressEn,
    this.pdf,
    this.branchNum,
    this.active,
    this.isOpen,
    this.closedReason,
    this.openFrom,
    this.openTo,
    this.holiday,
    this.parentId,
    this.phone1,
    this.phone2,
    this.tel,
    this.fax,
    this.facebook,
    this.instagram,
    this.twitter,
    this.snapshat,
    this.whatsapp,
    this.googleplus,
    this.website,
    this.email,
    this.visitCount,
    this.lat,
    this.lon,
    this.rateUserCount,
    this.totalRating,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
    this.serviceAr,
    this.serviceEn,
    this.countryId,
    this.cityId,
    this.areaId,
    this.zoneId,
    this.app,
    this.linkedIn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? descAr;
  final String? descEn;
  final String? addressAr;
  final String? addressEn;
  final String? pdf;
  final int? branchNum;
  final int? active;
  final int? isOpen;
  final dynamic closedReason;
  final DateTime? openFrom;
  final DateTime? openTo;
  final Holiday? holiday;
  final int? parentId;
  final String? phone1;
  final dynamic phone2;
  final dynamic tel;
  final dynamic fax;
  final dynamic facebook;
  final dynamic instagram;
  final dynamic twitter;
  final dynamic snapshat;
  final dynamic whatsapp;
  final dynamic googleplus;
  final dynamic website;
  final String? email;
  final int? visitCount;
  final dynamic lat;
  final dynamic lon;
  final int? rateUserCount;
  final int? totalRating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? image;
  final String? serviceAr;
  final String? serviceEn;
  final int? countryId;
  final int? cityId;
  final int? areaId;
  final int? zoneId;
  final int? app;
  final String? linkedIn;

  Info copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
    String? descAr,
    String? descEn,
    String? addressAr,
    String? addressEn,
    String? pdf,
    int? branchNum,
    int? active,
    int? isOpen,
    dynamic closedReason,
    DateTime? openFrom,
    DateTime? openTo,
    Holiday? holiday,
    int? parentId,
    String? phone1,
    dynamic phone2,
    dynamic tel,
    dynamic fax,
    dynamic facebook,
    dynamic instagram,
    dynamic twitter,
    dynamic snapshat,
    dynamic whatsapp,
    dynamic googleplus,
    dynamic website,
    String? email,
    int? visitCount,
    dynamic lat,
    dynamic lon,
    int? rateUserCount,
    int? totalRating,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? image,
    String? serviceAr,
    String? serviceEn,
    int? countryId,
    int? cityId,
    int? areaId,
    int? zoneId,
    int? app,
    String? linkedIn,
  }) =>
      Info(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        descAr: descAr ?? this.descAr,
        descEn: descEn ?? this.descEn,
        addressAr: addressAr ?? this.addressAr,
        addressEn: addressEn ?? this.addressEn,
        pdf: pdf ?? this.pdf,
        branchNum: branchNum ?? this.branchNum,
        active: active ?? this.active,
        isOpen: isOpen ?? this.isOpen,
        closedReason: closedReason ?? this.closedReason,
        openFrom: openFrom ?? this.openFrom,
        openTo: openTo ?? this.openTo,
        holiday: holiday ?? this.holiday,
        parentId: parentId ?? this.parentId,
        phone1: phone1 ?? this.phone1,
        phone2: phone2 ?? this.phone2,
        tel: tel ?? this.tel,
        fax: fax ?? this.fax,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        twitter: twitter ?? this.twitter,
        snapshat: snapshat ?? this.snapshat,
        whatsapp: whatsapp ?? this.whatsapp,
        googleplus: googleplus ?? this.googleplus,
        website: website ?? this.website,
        email: email ?? this.email,
        visitCount: visitCount ?? this.visitCount,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        rateUserCount: rateUserCount ?? this.rateUserCount,
        totalRating: totalRating ?? this.totalRating,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        image: image ?? this.image,
        serviceAr: serviceAr ?? this.serviceAr,
        serviceEn: serviceEn ?? this.serviceEn,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        areaId: areaId ?? this.areaId,
        zoneId: zoneId ?? this.zoneId,
        app: app ?? this.app,
        linkedIn: linkedIn ?? this.linkedIn,
      );

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  factory Info.fromJson(Map<String?, dynamic> json) => Info(
        id: json['id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        descAr: json['desc_ar'],
        descEn: json['desc_en'],
        addressAr: json['address_ar'],
        addressEn: json['address_en'],
        pdf: json['pdf'],
        branchNum: json['branch_num'],
        active: json['active'],
        isOpen: json['is_open'],
        closedReason: json['closed_reason'],
        openFrom: DateTime.parse(json['open_from']),
        openTo: DateTime.parse(json['open_to']),
        holiday: Holiday.fromJson(json['holiday']),
        parentId: json['parent_id'],
        phone1: json['phone1'],
        phone2: json['phone2'],
        tel: json['tel'],
        fax: json['fax'],
        facebook: json['facebook'],
        instagram: json['instagram'],
        twitter: json['twitter'],
        snapshat: json['snapshat'],
        whatsapp: json['whatsapp'],
        googleplus: json['googleplus'],
        website: json['website'],
        email: json['email'],
        visitCount: json['visit_count'],
        lat: json['lat'],
        lon: json['lon'],
        rateUserCount: json['rate_user_count'],
        totalRating: json['total_rating'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at'],
        image: json['image'],
        serviceAr: json['service_ar'],
        serviceEn: json['service_en'],
        countryId: json['country_id'],
        cityId: json['city_id'],
        areaId: json['area_id'],
        zoneId: json['zone_id'],
        app: json['app'],
        linkedIn: json['linked_in'],
      );
}

class Holiday {
  Holiday({
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  final bool? saturday;
  final bool? sunday;
  final bool? monday;
  final bool? tuesday;
  final bool? wednesday;
  final bool? thursday;
  final bool? friday;

  Holiday copyWith({
    bool? saturday,
    bool? sunday,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
  }) =>
      Holiday(
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
      );

  factory Holiday.fromRawJson(String str) => Holiday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        saturday: json['Saturday'],
        sunday: json['Sunday'],
        monday: json['Monday'],
        tuesday: json['Tuesday'],
        wednesday: json['Wednesday'],
        thursday: json['Thursday'],
        friday: json['Friday'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Saturday': saturday,
        'Sunday': sunday,
        'Monday': monday,
        'Tuesday': tuesday,
        'Wednesday': wednesday,
        'Thursday': thursday,
        'Friday': friday,
      };
}

class User {
  User({
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

  final String? provider;
  final String? providerId;
  final String? name;
  final int? userableId;
  final String? userableType;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic rememberToken;
  final String? avatar;
  final dynamic birthDate;
  final dynamic gender;
  final String? defaultLang;
  final String? phone;
  final int? cityId;
  final int? areaId;
  final int? zoneId;
  final String? resetCode;
  final dynamic nationalId;
  final dynamic fcmToken;
  final int? active;
  final String? type;
  final int? countryId;

  User copyWith({
    String? provider,
    String? providerId,
    String? name,
    int? userableId,
    String? userableType,
    String? email,
    dynamic emailVerifiedAt,
    dynamic rememberToken,
    String? avatar,
    dynamic birthDate,
    dynamic gender,
    String? defaultLang,
    String? phone,
    int? cityId,
    int? areaId,
    int? zoneId,
    String? resetCode,
    dynamic nationalId,
    dynamic fcmToken,
    int? active,
    String? type,
    int? countryId,
  }) =>
      User(
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

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
