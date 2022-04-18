class TicketsSupportReplay {
  int? id;
  String? name;
  List<TicketData>? data;

  TicketsSupportReplay({this.id, this.name, this.data});

  factory TicketsSupportReplay.fromJson(json) {
    print('jjjjjjjjson $json');
    final List<TicketData> ticketData = [];
    for (var tic in json['tickets']) {
      ticketData.add(TicketData.fromJson(tic));
    }
    print('done TicketData');

    return TicketsSupportReplay(
      id: json['id'],
      name: json['name'],
      data: ticketData,
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

class TicketData {
  dynamic id;
  dynamic user_id;
  dynamic subject;
  dynamic code;
  dynamic details;
  dynamic created_at;
  dynamic viewed;
  List<TicketReply>? data;
  Status? status;

  TicketData(
      {this.id,
      this.user_id,
      this.subject,
      this.code,
      this.details,
      this.created_at,
      this.viewed,
      this.data,
      this.status});

  factory TicketData.fromJson(json) {
    final List<TicketReply> ticketReply = [];
    for (var replys in json['ticket_reply']) {
      ticketReply.add(TicketReply.fromJson(replys));
    }
    print('done TicketReply');
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
      data: ticketReply,
      status: s,
    );
  }
}

class TicketReply {
  int? id;
  int? ticket_id;
  int? user_id;
  String? reply;
  String? created_at;
  UserTicketReply? user;

  TicketReply(
      {this.id,
      this.ticket_id,
      this.user_id,
      this.reply,
      this.created_at,
      this.user});

  factory TicketReply.fromJson(json) {
    var u = UserTicketReply.fromJson(json['user']);
    final getUser = u;
    print('done User');
    return TicketReply(
      id: json['id'],
      ticket_id: json['ticket_id'],
      user_id: json['user_id'],
      reply: json['reply'],
      created_at: json['created_at'],
      user: getUser,
    );
  }
}

class UserTicketReply {
  int? id;
  String? name;
  String? type;

  UserTicketReply({this.id, this.name, this.type});

  factory UserTicketReply.fromJson(json) {
    return UserTicketReply(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}
