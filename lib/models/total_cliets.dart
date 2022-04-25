class TotalClents {
  int? count;

  TotalClents({this.count});

  factory TotalClents.fromJson(json) {
    return TotalClents(
      count: json,
    );
  }
}
