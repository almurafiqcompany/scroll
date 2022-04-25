import 'package:al_murafiq/models/categories.dart';

class SubCategories_Data {
  List<SubCategories>? sub_categories;
  List<Ads>? ads;

  SubCategories_Data({this.sub_categories, this.ads});

  factory SubCategories_Data.fromJson(json) {
    final List<SubCategories> subCategories = [];
    for (var sub in json['data']) {
      subCategories.add(SubCategories.fromJson(sub));
    }
    print('done sub');
    final List<Ads> allads = [];
    for (var ads in json['ads']) {
      allads.add(Ads.fromJson(ads));
    }
    print('done ads');
    return SubCategories_Data(
      sub_categories: subCategories,
      ads: allads,
    );
  }
}

// class Ads {
//   int id;
//   int company_id;
//   String image;
//   dynamic total_rating;
//   String name;
//   String address;
//   String distance;
//   String city;
//
//   Ads({this.id, this.company_id, this.image, this.total_rating, this.name,
//       this.address, this.distance, this.city});
//   factory Ads.fromJson(json) {
//
//     return Ads(
//       id: json['id'],
//       company_id: json['company_id'],
//       image: json['image'],
//       total_rating: json['total_rating'],
//       name: json['name'],
//       address: json['address'],
//       distance: json['distance'],
//       city: json['city'],
//
//     );
//   }
// }

// class SubCategories {
//   int id;
//   String name;
//   String image;
//   String color;
//
//   SubCategories({this.id, this.name, this.image, this.color});
//   factory SubCategories.fromJson(json) {
//
//     return SubCategories(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       color: json['color'] !=null?json['color'].replaceAll("#", ""):'#862D7D'.replaceAll("#", ""),
//
//     );
//   }
//
// }

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
    for (var sub_sub in json['sub_subcategories']) {
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

// class SubSubCategories {
//   int id;
//   String name;
//   String image;
//   String color;
//
//   SubSubCategories({this.id, this.name, this.image, this.color});
//
//   factory SubSubCategories.fromJson(json) {
//     return SubSubCategories(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       color: json['color'] != null
//           ? json['color'].replaceAll("#", "")
//           : '#862D7D'.replaceAll("#", ""),
//     );
//   }
// }