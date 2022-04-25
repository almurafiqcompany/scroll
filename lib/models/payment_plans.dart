class PaymentPlans {
  int? id;
  String? name;
  String? desc;
  dynamic price;
  dynamic days;
  dynamic slider_num;
  dynamic banner_num;
  CountrySubscription? country_subscription;

  PaymentPlans(
      {this.id,
      this.name,
      this.desc,
      this.price,
      this.days,
      this.slider_num,
      this.banner_num,
      this.country_subscription});

  factory PaymentPlans.fromJson(json) {
    var countrySubscription = json['country_subscriptions'] != null
        ? CountrySubscription.fromJson(json['country_subscriptions'][0])
        : null;
    final getsubscriptionsymbol = countrySubscription;
    print('abdo');

    return PaymentPlans(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      price: json['price'],
      days: json['days'],
      slider_num: json['slider_num'],
      banner_num: json['banner_num'],
      country_subscription: getsubscriptionsymbol,
    );
  }
}

class CountrySubscription {
  int? id;
  dynamic subscription_id;
  dynamic price;
  String? currency_symbol;

  CountrySubscription(
      {this.id, this.subscription_id, this.price, this.currency_symbol});

  factory CountrySubscription.fromJson(json) {
    return CountrySubscription(
      id: json['id'],
      subscription_id: json['subscription_id'],
      price: json['price'],
      currency_symbol: json['currency_symbol'],
    );
  }
}
