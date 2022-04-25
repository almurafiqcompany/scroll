class ProfileEditUserAndDelegate {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? birth_date;
  String? gender;
  String? default_lang;
  String? phone;
  int? country_id;
  int? city_id;
  String? national_id;

  ProfileEditUserAndDelegate(
      {this.id,
      this.name,
      this.email,
      this.avatar,
      this.birth_date,
      this.gender,
      this.default_lang,
      this.phone,
      this.country_id,
      this.city_id,
      this.national_id});

  factory ProfileEditUserAndDelegate.fromJson(json) {
    return ProfileEditUserAndDelegate(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      birth_date: json['birth_date'],
      gender: json['gender'],
      default_lang: json['default_lang'],
      phone: json['phone'],
      country_id: json['country_id'],
      city_id: json['city_id'],
      national_id: json['national_id'],
    );
  }
}
