class Policy {
  int? id;
  String? name;
  String? desc;
  String? image;
  dynamic created_at;

  Policy({this.id, this.name, this.desc, this.image, this.created_at});

  factory Policy.fromJson(json) {
    return Policy(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      created_at: json['created_at'],
    );
  }
}
