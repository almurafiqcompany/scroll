class CompanyOfBranches {
  int? id;
  String? name;
  String? desc;
  String? image;
  // ignore: non_constant_identifier_names
  dynamic total_rating;
  // ignore: non_constant_identifier_names
  dynamic visit_count;
  int? active;
  List<Branches>? branch;

  CompanyOfBranches(
      {this.id,
      this.name,
      this.desc,
      this.image,
      // ignore: non_constant_identifier_names
      this.total_rating,
      this.visit_count,
      this.branch,
      this.active});

  // ignore: always_specify_types
  factory CompanyOfBranches.fromJson(json) {
    final List<Branches> branches = [];
    for (var branch in json['branches']) {
      branches.add(Branches.fromJson(branch));
    }
    print('Done Branches');
    return CompanyOfBranches(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      total_rating: json['total_rating'],
      visit_count: json['visit_count'],
      active: json['active'],
      branch: branches,
    );
  }
}

class Branches {
  int? id;
  String? name;
  String? desc;
  String? image;
  // ignore: non_constant_identifier_names
  int? visit_count;
  // ignore: non_constant_identifier_names
  dynamic total_rating;
  int? active;

  // ignore: non_constant_identifier_names
  Branches(
      {this.id,
      this.name,
      this.desc,
      this.image,
      this.visit_count,
      // ignore: non_constant_identifier_names
      this.total_rating,
      this.active});

  // ignore: always_specify_types
  factory Branches.fromJson(json) {
    return Branches(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      visit_count: json['visit_count'],
      total_rating: json['total_rating'],
      active: json['active'],
    );
  }
}
