class HomePageData {
  List<SliderData>? slider;
  List<BannerData>? banner;
  // BannerData banner;
  List<CategoriesData>? categories;
  List<ReviewsData>? reviews;
  List<LatestCompaniesData>? latest_companies;
  // Settings settings;
  //

  HomePageData(
      {this.slider,
      this.banner,
      this.categories,
      this.reviews,
      this.latest_companies});

  factory HomePageData.fromJson(json) {
    print('a$json');
    final List<CategoriesData> categories = [];
    for (var category in json['categories']) {
      categories.add(CategoriesData.fromJson(category));
    }
    print('done categro');

    final List<SliderData> sliderr = [];
    for (var slider in json['slider']) {
      sliderr.add(SliderData.fromJson(slider));
    }
    print('done slider');

    final List<BannerData> bannerr = [];
    for (var ban in json['banner']) {
      bannerr.add(BannerData.fromJson(ban));
    }
    print('done banner');

    // var ban=BannerData.fromJson(json['banner']);
    // final  bannerr = ban ;
    // print('done banner');
    // var set=Settings.fromJson(json['settings']);
    // final  setting = set ;
    // print('done banner');

    final List<LatestCompaniesData> latest_companie = [];
    for (var latestcompanie in json['latest_companies']) {
      latest_companie.add(LatestCompaniesData.fromJson(latestcompanie));
    }
    print('qqq${latest_companie}'); //ReviewsData
    final List<ReviewsData> reviews = [];
    for (var review in json['reviews']) {
      reviews.add(ReviewsData.fromJson(review));
    }
    print('done Reviews');
    return HomePageData(
      categories: categories,
      slider: sliderr,
      banner: bannerr,
      // settings:setting,
      reviews: reviews,
      latest_companies: latest_companie,
    );
  }
}

class LatestCompaniesData {
  int? id;
  String? name;
  String? desc;
  dynamic total_rating;
  String? image;
  int? city_id;
  String? distance;
  City? city;

  LatestCompaniesData(
      {this.id,
      this.name,
      this.desc,
      this.total_rating,
      this.image,
      this.city_id,
      this.distance,
      this.city});

  factory LatestCompaniesData.fromJson(json) {
    var c = json['city'] != null ? City.fromJson(json['city']) : null;
    final city = c;
    print('done city');

    return LatestCompaniesData(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      total_rating: json['total_rating'],
      image: json['image'],
      city_id: json['city_id'],
      distance: json['distance'],
      city: city,
    );
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});
  factory City.fromJson(json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class User {
  int? id;
  String? name;
  String? avatar;

  User({this.id, this.name, this.avatar});

  factory User.fromJson(json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}

class Company {
  int? id;
  String? name;
  String? image;

  Company({this.id, this.name, this.image});

  factory Company.fromJson(json) {
    return Company(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class ReviewsData {
  int? id;
  String? comment;
  dynamic rate;
  dynamic created_at;
  int? user_id;
  User? user;
  Company? company;

  ReviewsData(
      {this.id,
      this.comment,
      this.rate,
      this.created_at,
      this.user_id,
      this.user,
      this.company});

  factory ReviewsData.fromJson(json) {
    var u = User.fromJson(json['user']);
    final user = u;
    print('done User');
    var com = Company.fromJson(json['company']);
    final company = com;
    print('done company');

    return ReviewsData(
      id: json['id'],
      comment: json['comment'],
      rate: json['rate'],
      created_at: json['created_at'],
      user_id: json['user_id'],
      user: user,
      company: company,
    );
  }
}

class BannerData {
  int? id;
  int? company_id;
  String? image;
  String? name;
  String? des;
  dynamic total_rating;

  BannerData(
      {this.id,
      this.company_id,
      this.image,
      this.name,
      this.des,
      this.total_rating});

  factory BannerData.fromJson(json) {
    print('banner $json');
    if (json == null) {
      //return null;
    }
    print('bannerrr $json');
    return BannerData(
      id: json['id'],
      name: json['name'],
      company_id: json['company_id'],
      image: json['image'],
      des: json['desc'],
      total_rating: json['total_rating'],
    );
  }
}

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

class SliderData {
  int? id;
  int? company_id;
  String? image;
  String? name;
  String? address;
  String? city;
  dynamic total_rating;
  String? distance;

  SliderData(
      {this.id,
      this.company_id,
      this.image,
      this.name,
      this.address,
      this.city,
      this.total_rating,
      this.distance});
  factory SliderData.fromJson(json) {
    return SliderData(
      id: json['id'],
      name: json['name'],
      company_id: json['company_id'],
      image: json['image'],
      address: json['address'],
      city: json['city'],
      total_rating: json['total_rating'],
      distance: json['distance'],
    );
  }
}

class CategoriesData {
  int? id;
  String? name;
  String? image;
  String? color;

  CategoriesData({this.id, this.name, this.image, this.color});

  factory CategoriesData.fromJson(json) {
    return CategoriesData(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      color: json['color'] != null
          ? json['color'].replaceAll("#", "")
          : '#862D7D'.replaceAll("#", ""),
    );
  }
}
