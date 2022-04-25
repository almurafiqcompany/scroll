class Tickets {
  int? id;
  String? name;
  List<TicketData>? data;

  Tickets({this.id, this.name, this.data});

  factory Tickets.fromJson(json) {
    print('jjjjjjjjson $json');
    print('tic ${json['tickets']}');
    final List<TicketData> ticketData = [];
    for (var tic in json['tickets']) {
      ticketData.add(TicketData.fromJson(tic));
    }
    print('done TicketData');

    return Tickets(
      id: json['id'],
      name: json['name'],
      data: ticketData,
    );
  }
}

class TicketData {
  dynamic id;
  dynamic user_id;
  dynamic subject;
  dynamic code;
  dynamic details;
  dynamic created_at;
  dynamic viewed;
  Status? status;

  TicketData(
      {this.id,
      this.user_id,
      this.subject,
      this.code,
      this.details,
      this.created_at,
      this.viewed,
      this.status});

  factory TicketData.fromJson(json) {
    var status = Status.fromJson(json['status']);
    final s = status;
    print('done User');
    return TicketData(
      id: json['id'],
      code: json['code'],
      user_id: json['user_id'],
      subject: json['subject'],
      details: json['details'],
      viewed: json['viewed'],
      created_at: json['created_at'],
      status: s,
    );
  }
}

class Status {
  dynamic name;

  Status({this.name});

  factory Status.fromJson(json) {
    return Status(
      name: json['name'],
    );
  }
}
