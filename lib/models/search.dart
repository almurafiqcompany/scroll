class Search {
  int? current_page;
  List<DataOfSearch>? data;
  String? first_page_url;
  int? from;
  int? last_page;
  String? last_page_url;
  String? next_page_url;
  String? path;
  String? per_page;
  String? prev_page_url;
  int? to;
  int? total;

  Search(
      {this.current_page,
      this.data,
      this.first_page_url,
      this.from,
      this.last_page,
      this.last_page_url,
      this.next_page_url,
      this.path,
      this.per_page,
      this.prev_page_url,
      this.to,
      this.total});

  factory Search.fromJson(json) {
    final List<DataOfSearch> dataOfSearch = [];
    print('before loop');
    for (var data in json['data']) {
      //print('index of data  $data');
      dataOfSearch.add(DataOfSearch.fromJson(data));
    }
    print('done data');

    print('done ok');
    return Search(
      current_page: json['current_page'],
      data: dataOfSearch,
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      next_page_url: json['next_page_url'],
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class DataOfSearch {
  int? id;
  String? name;
  String? desc;
  String? image;
  dynamic total_rating;
  int? city_id;
  dynamic lat;
  dynamic lon;
  String? distance;
  City? city;

  DataOfSearch(
      {this.id,
      this.name,
      this.desc,
      this.image,
      this.total_rating,
      this.city_id,
      this.lat,
      this.lon,
      this.distance,
      this.city});

  factory DataOfSearch.fromJson(json) {
    var c = City.fromJson(json['city']);
    final city = c;
    print('done city');

    print('get data of company');

    return DataOfSearch(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      total_rating: json['total_rating'],
      city_id: json['city_id'],
      lat: json['lat'],
      lon: json['lon'],
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
