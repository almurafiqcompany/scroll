class Favourate {
  int? id;
  int? user_id;
  int? company_id;
  Company? company;

  Favourate({this.id, this.user_id, this.company_id, this.company});

  factory Favourate.fromJson(json) {
    var c = Company.fromJson(json['company']);
    final com = c;
    print('done company');

    return Favourate(
      id: json['id'],
      user_id: json['user_id'],
      company_id: json['company_id'],
      company: com,
    );
  }
}

class Company {
  int? id;
  String? name;
  dynamic total_rating;
  int? country_id;
  int? city_id;
  String? image;
  String? address;
  String? desc;
  String? distance;
  City? city;

  Company(
      {this.id,
      this.name,
      this.total_rating,
      this.country_id,
      this.city_id,
      this.image,
      this.address,
      this.desc,
      this.distance,
      this.city});

  factory Company.fromJson(json) {
    print('qqqqqqqqqqqqqqqqq');
    var c = City.fromJson(json['city']);
    final city = c;
    print('done city');
    return Company(
      id: json['id'],
      name: json['name'],
      total_rating: json['total_rating'],
      country_id: json['country_id'],
      city_id: json['city_id'],
      image: json['image'],
      address: json['address'],
      desc: json['desc'],
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
