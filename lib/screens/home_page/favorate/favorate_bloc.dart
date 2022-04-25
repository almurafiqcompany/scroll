import 'package:al_murafiq/models/favorate.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class FavorateBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfFavorateSubject = BehaviorSubject<List<Favourate>>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchFavorate() async {
    try {
      String? token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      double? lat = await _helper.getLat();
      double? lng = await _helper.getLng();
      final Response res = await _dio.get(
        '/wishlists?country_id=$countryID&lat=$lat&lng=$lng',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      List<Favourate> fav = [];
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']) {
          fav.add(Favourate.fromJson(obj));
        }

        dataOfFavorateSubject.sink.add(fav);
      } else if (res.data['status'] == 400) {
        dataOfFavorateSubject.sink.addError(res.data['message']);
      } else {
        dataOfFavorateSubject.sink.addError('');
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      dataOfFavorateSubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfFavorateSubject.stream.drain();
    dataOfFavorateSubject.close();
  }
}
