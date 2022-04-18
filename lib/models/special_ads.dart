class Special_Ads_Data {
  List<Slider>? slider;
  List<Banner>? banner;

  Special_Ads_Data({this.slider, this.banner});

  factory Special_Ads_Data.fromJson(json) {
    final List<Slider> slider = [];
    for (var slid in json['sliders']) {
      slider.add(Slider.fromJson(slid));
    }
    print('done sliders');
    final List<Banner> banner = [];
    for (var ban in json['banners']) {
      banner.add(Banner.fromJson(ban));
    }
    print('done banners');
    return Special_Ads_Data(
      slider: slider,
      banner: banner,
    );
  }
}

class Banner {
  int? id;
  int? company_id;
  int? visit_count;
  String? image;
  dynamic total_rating;
  String? name;
  String? address;
  String? distance;
  String? city;

  Banner(
      {this.id,
      this.company_id,
      this.visit_count,
      this.image,
      this.total_rating,
      this.name,
      this.address,
      this.distance,
      this.city});

  factory Banner.fromJson(json) {
    return Banner(
      id: json['id'],
      company_id: json['company_id'],
      visit_count: json['visit_count'],
      image: json['image'],
      total_rating: json['total_rating'],
      name: json['name'],
      address: json['address'],
      distance: json['distance'],
      city: json['city'],
    );
  }
}

class Slider {
  int? id;
  int? company_id;
  int? visit_count;
  String? image;
  dynamic total_rating;
  String? name;
  String? address;
  String? distance;
  String? city;

  Slider(
      {this.id,
      this.company_id,
      this.visit_count,
      this.image,
      this.total_rating,
      this.name,
      this.address,
      this.distance,
      this.city});

  factory Slider.fromJson(json) {
    return Slider(
      id: json['id'],
      company_id: json['company_id'],
      visit_count: json['visit_count'],
      image: json['image'],
      total_rating: json['total_rating'],
      name: json['name'],
      address: json['address'],
      distance: json['distance'],
      city: json['city'],
    );
  }
}
