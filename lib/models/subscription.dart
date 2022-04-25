class SubscriptionData {
  int? id;
  String? name;
  int? active;

  SubscriptionData({this.id, this.name, this.active});

  factory SubscriptionData.fromJson(json) {
    return SubscriptionData(
      id: json['id'],
      name: json['name'],
      active: json['active'],
    );
  }
}
