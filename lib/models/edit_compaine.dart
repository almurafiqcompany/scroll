class EditCompany {
  int? id;
  String? name_en;
  String? desc_en;
  String? address_en;
  dynamic pdf;
  dynamic open_to;
  dynamic open_from;
  dynamic phone1;
  dynamic phone2;
  dynamic tel;
  dynamic fax;
  String? email;
  dynamic lat;
  dynamic lng;
  String? image;
  dynamic country_id;
  dynamic city_id;
  dynamic cat_id;
  dynamic sub_cat_id;
  dynamic week_from;
  dynamic week_to;

  EditCompany(
      {this.id,
      this.name_en,
      this.desc_en,
      this.address_en,
      this.pdf,
      this.open_to,
      this.open_from,
      this.phone1,
      this.phone2,
      this.tel,
      this.fax,
      this.email,
      this.lat,
      this.lng,
      this.image,
      this.country_id,
      this.city_id,
      this.cat_id,
      this.sub_cat_id,
      this.week_from,
      this.week_to});

  factory EditCompany.fromJson(json) {
    print('done ok');
    return EditCompany(
      id: json['id'],
      name_en: json['name_en'],
      desc_en: json['desc_en'],
      address_en: json['address_en'],
      pdf: json['pdf'],
      open_from: json['open_from'],
      open_to: json['open_to'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      tel: json['tel'],
      fax: json['fax'],
      email: json['email'],
      lat: json['lat'],
      lng: json['lng'],
      image: json['image'],
      country_id: json['country_id'],
      city_id: json['city_id'],
      cat_id: json['cat_id'],
      sub_cat_id: json['sub_cat_id'],
      week_from: json['week_from'],
      week_to: json['week_to'],
    );
  }
}
