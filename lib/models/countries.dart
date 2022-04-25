class CountriesData {
  int? id;
  String? name;
  String? icon;
  String? default_lang;
  List<CitiesData>? cities;
  List<Languages>? languages;

  CountriesData(
      {this.id,
      this.name,
      this.icon,
      this.default_lang,
      this.cities,
      this.languages});

  factory CountriesData.fromJson(json) {
    final List<CitiesData> cities = [];
    for (var city in json['cities']) {
      cities.add(CitiesData.fromJson(city));
    }
    // final List<Languages> languages = [];
    // for (var language in json['languages']) {
    //   languages.add(Languages.fromJson(language));
    // }
    return CountriesData(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      // default_lang: json['default_lang'],
      cities: cities,
      // languages:languages,
    );
  }
}

class Languages {
  int? id;
  String? name;
  String? code;
  int? defult;

  Languages({this.id, this.name, this.code, this.defult});

  factory Languages.fromJson(json) {
    return Languages(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      defult: json['default'],
    );
  }
}

class CitiesData {
  int? id;
  String? name;

  List<AreaCityData>? areas;

  CitiesData({this.id, this.name, this.areas});

  factory CitiesData.fromJson(json) {
    // final List<AreaCityData> areas = [];
    // for (var area in json['areas']) {
    //   areas.add(AreaCityData.fromJson(area));
    // }
    return CitiesData(
      id: json['id'],
      name: json['name'],
      // areas: areas,
    );
  }
}

class AreaCityData {
  int? id;
  String? name;
  List<ZoneCityData>? zones;

  AreaCityData({this.id, this.name, this.zones});

  factory AreaCityData.fromJson(json) {
    final List<ZoneCityData> zones = [];
    for (var zone in json['zones']) {
      zones.add(ZoneCityData.fromJson(zone));
    }
    return AreaCityData(
      id: json['id'],
      name: json['name'],
      zones: zones,
    );
  }
}

class ZoneCityData {
  int? id;
  String? name;

  ZoneCityData({this.id, this.name});

  factory ZoneCityData.fromJson(json) {
    return ZoneCityData(
      id: json['id'],
      name: json['name'],
    );
  }
}
