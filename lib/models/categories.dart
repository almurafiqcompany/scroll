// ignore: camel_case_types
class Categories_Data {
  int? id;
  String? name;
  String? image;
  String? color;

// ignore: non_constant_identifier_names
  List<SubCategories>? sub_categories;

  List<Ads>? ads;

  Categories_Data(
      {this.id,
      this.name,
      this.image,
      this.color,
      // ignore: non_constant_identifier_names
      this.sub_categories,
      this.ads});

  factory Categories_Data.fromJson(json) {
    final List<SubCategories> subCategories = [];
    for (var sub in json['sub_categories']) {
      subCategories.add(SubCategories.fromJson(sub));
    }

    print('done sub');
    final List<Ads> allads = [];
    for (var ads in json['ads']) {
      allads.add(Ads.fromJson(ads));
    }
    print('done ads');
    return Categories_Data(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      color: json['color'] != null
          ? json['color'].replaceAll("#", "")
          : '#862D7D'.replaceAll("#", ""),
      // json['color'].replaceAll('#', ''),
      sub_categories: subCategories,

      ads: allads,
    );
  }
}

class Ads {
  int? id;
  int? company_id;
  int? visit_count;
  String? image;
  dynamic total_rating;
  String? name;
  String? address;
  String? distance;
  String? city;

  Ads(
      {this.id,
      this.company_id,
      this.visit_count,
      this.image,
      this.total_rating,
      this.name,
      this.address,
      this.distance,
      this.city});

  factory Ads.fromJson(json) {
    return Ads(
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

class SubCategories {
  int? id;
  String? name;
  String? image;
  String? color;
  List<SubSubCategories>? sub_sub_categories;

  SubCategories(
      {this.id, this.name, this.image, this.color, this.sub_sub_categories});

  factory SubCategories.fromJson(json) {
    final List<SubSubCategories> subSubCategories = [];
    for (var sub_sub in json['sub_sub_categories']) {
      subSubCategories.add(SubSubCategories.fromJson(sub_sub));
      print('sub_sub_categories');
    }
    return SubCategories(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      sub_sub_categories: subSubCategories,
      color: json['color'] != null
          ? json['color'].replaceAll("#", "")
          : '#862D7D'.replaceAll("#", ""),
    );
  }
}

class SubSubCategories {
  int? id;
  String? name;
  String? image;
  String? color;

  SubSubCategories({this.id, this.name, this.image, this.color});

  factory SubSubCategories.fromJson(json) {
    return SubSubCategories(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      color: json['color'] != null
          ? json['color'].replaceAll("#", "")
          : '#862D7D'.replaceAll("#", ""),
    );
  }
}
