class PaymentBankInformation {
  int? id;
  String? bank_name;
  String? branch_name;
  String? owner_name;
  String? logo;
  String? swift_num;
  String? account_num;

  PaymentBankInformation(
      {this.id,
      this.bank_name,
      this.branch_name,
      this.owner_name,
      this.logo,
      this.swift_num,
      this.account_num});

  factory PaymentBankInformation.fromJson(json) {
    return PaymentBankInformation(
      id: json['id'],
      bank_name: json['bank_name'],
      branch_name: json['branch_name'],
      owner_name: json['owner_name'],
      logo: json['logo'],
      swift_num: json['swift_num'],
      account_num: json['account_num'],
    );
  }
}
