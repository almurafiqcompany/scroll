class SearchStore {
  int? id;
  String? name;
  List<SearchStoreData>? data;

  SearchStore({this.id, this.name, this.data});

  factory SearchStore.fromJson(json) {
    print('jjjjjjjjson $json');
    print('tic ${json['tickets']}');
    final List<SearchStoreData> ticketData = [];
    for (var tic in json['searches']) {
      ticketData.add(SearchStoreData.fromJson(tic));
    }
    print('done TicketData');

    return SearchStore(
      id: json['id'],
      name: json['name'],
      data: ticketData,
    );
  }
}

class SearchStoreData {
  dynamic id;
  dynamic query;
  dynamic count;
  dynamic time;

  SearchStoreData({this.id, this.query, this.count, this.time});

  factory SearchStoreData.fromJson(json) {
    return SearchStoreData(
      id: json['id'],
      query: json['query'],
      count: json['count'],
      time: json['time'],
    );
  }
}
