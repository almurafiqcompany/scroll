class Notifications {
  List<Notification>? notification;

  Notifications({this.notification});

  factory Notifications.fromJson(json) {
    final List<Notification> notification = [];
    for (var not in json['notifications']) {
      notification.add(Notification.fromJson(not));
    }
    print('done Notification');

    return Notifications(
      notification: notification,
    );
  }
}

class Notification {
  int? id;
  String? title;
  String? data;
  String? time;
  Pivot? pivot;

  Notification({this.id, this.title, this.data, this.time, this.pivot});

  factory Notification.fromJson(json) {
    var piv = Pivot.fromJson(json['pivot']);
    final pivo = piv;
    print('done User');
    return Notification(
      id: json['id'],
      title: json['title'],
      data: json['data'],
      time: json['time'],
      pivot: pivo,
    );
  }
}

class Pivot {
  int? user_id;
  int? notification_id;

  Pivot({this.user_id, this.notification_id});
  factory Pivot.fromJson(json) {
    return Pivot(
      user_id: json['user_id'],
      notification_id: json['notification_id'],
    );
  }
}
