class Eshtrakaty {
  dynamic id;
  dynamic name;
  List<Subscriptions>? subscriptions;

  Eshtrakaty({this.id, this.name, this.subscriptions});

  factory Eshtrakaty.fromJson(json) {
    final List<Subscriptions> subscriptions = [];
    for (var sub in json['subscriptions']) {
      subscriptions.add(Subscriptions.fromJson(sub));
    }
    print('done subscriptions');
    return Eshtrakaty(
      id: json['id'],
      name: json['name'],
      subscriptions: subscriptions,
    );
  }
}

class Subscriptions {
  int? id;
  int? company_id;
  int? subscription_id;
  String? from;
  String? to;
  dynamic price;
  int? slider_num;
  int? banner_num;
  int? days;
  int? paid;
  int? active;
  int? last;
  dynamic currency_symbol;
  Subscription? subscription;

  Subscriptions(
      {this.id,
      this.company_id,
      this.subscription_id,
      this.from,
      this.to,
      this.price,
      this.slider_num,
      this.banner_num,
      this.days,
      this.paid,
      this.active,
      this.last,
      this.currency_symbol,
      this.subscription});

  factory Subscriptions.fromJson(json) {
    var subscription = Subscription.fromJson(json['subscription']);
    final getsubscription = subscription;
    print('done User');
    return Subscriptions(
      id: json['id'],
      company_id: json['company_id'],
      subscription_id: json['subscription_id'],
      from: json['from'],
      to: json['to'],
      price: json['price'],
      slider_num: json['slider_num'],
      banner_num: json['banner_num'],
      days: json['days'],
      paid: json['paid'],
      active: json['active'],
      last: json['last'],
      currency_symbol: json['currency_symbol'],
      subscription: getsubscription,
    );
  }
}

class Subscription {
  int? id;
  String? name;
  String? desc;

  Subscription({this.id, this.name, this.desc});

  factory Subscription.fromJson(json) {
    return Subscription(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
    );
  }
}
