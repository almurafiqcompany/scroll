class Settings {
  int? id;
  String? logo;
  String? favicon;
  String? lat;
  String? lon;
  String? site;
  String? address;
  List<Social>? social;

  Settings(
      {this.id,
      this.logo,
      this.favicon,
      this.lat,
      this.lon,
      this.site,
      this.address,
      this.social});

  factory Settings.fromJson(json) {
    final List<Social> social = [];
    for (var soc in json['social']) {
      social.add(Social.fromJson(soc));
    }
    print('done Social');

    return Settings(
      id: json['id'],
      logo: json['logo'],
      favicon: json['favicon'],
      lat: json['lat'],
      lon: json['lng'],
      site: json['site'],
      address: json['address'],
      social: social,
    );
  }
}

class Social {
  int? id;
  String? link;
  String? icon_type;
  int? socialable_id;
  String? socialable_type;

  Social(
      {this.id,
      this.link,
      this.icon_type,
      this.socialable_id,
      this.socialable_type});

  factory Social.fromJson(json) {
    return Social(
      id: json['id'],
      link: json['link'],
      icon_type: json['icon_type'],
      socialable_id: json['socialable_id'],
      socialable_type: json['socialable_type'],
    );
  }
}
