class SocialsOfComapny {
  int? id;
  String? name;
  String? image;
  dynamic total_rating;
  List<SocialData>? socialData;

  SocialsOfComapny(
      {this.id, this.name, this.image, this.total_rating, this.socialData});

  factory SocialsOfComapny.fromJson(json) {
    print('jjjjjjjjson $json');
    final List<SocialData> socials = [];
    for (var soc in json['socials']) {
      socials.add(SocialData.fromJson(soc));
    }
    print('done TicketData');

    return SocialsOfComapny(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      total_rating: json['total_rating'],
      socialData: socials,
    );
  }
}

class SocialData {
  dynamic id;
  dynamic link;
  dynamic icon_type;

  SocialData({this.id, this.link, this.icon_type});

  factory SocialData.fromJson(json) {
    return SocialData(
      id: json['id'],
      link: json['link'],
      icon_type: json['icon_type'],
    );
  }
}
