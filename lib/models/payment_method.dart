class PaymentMethod {
  int? id;
  String? name;
  String? type;

  PaymentMethod({this.id, this.name, this.type});

  factory PaymentMethod.fromJson(json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}
