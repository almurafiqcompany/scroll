import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // ignore: always_declare_return_types, always_declare_return_types
  setToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  // ignore: always_declare_return_types
  setCountryId(int countryId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    print(countryId);
    await preferences.setInt('countryId', countryId);
  }

  Future<int?> getCountryId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('countryId');
  }

  // ignore: always_declare_return_types
  setNumberOfNotfiction(int numNotif) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('numNotif', numNotif);
  }

  Future<int?> getNumberOfNotfiction() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('numNotif');
  }

  // ignore: always_declare_return_types
  setCityId(int cityId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('cityId', cityId);
  }

  Future<int?> getCityId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('cityId');
  }

  // ignore: always_declare_return_types
  setLng(double long) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setDouble('long', long);
  }

  Future<double?> getLng() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble('long');
  }

  // ignore: always_declare_return_types
  setLat(double lat) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setDouble('lat', lat);
  }

  Future<double?> getLat() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble('lat');
  }

  // ignore: always_declare_return_types
  setLangId(int langId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('langId', langId);
  }

  Future<int?> getLangId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('langId');
  }

  // ignore: always_declare_return_types
  setFirst(int first) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('first', first);
  }

  Future<int?> getFirst() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('first');
  }

  // ignore: always_declare_return_types
  setActive(int active) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('active', active);
  }

  Future<int?> getActive() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('active');
  }

  // ignore: always_declare_return_types
  setCodeLang(String codeLang) async {
    //AppLocalizations(Locale(codeLang));
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('codeLang', codeLang);
  }

  Future<String> getCodeLang() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('codeLang') ?? 'en';
  }

  setActivationMessage(String activationMessage) async {
    //AppLocalizations(Locale(codeLang));
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('activationMessage', activationMessage);
  }

  Future<String?> getActivationMessage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('activationMessage');
  }

  setShareMessage(String shareMessage) async {
    //AppLocalizations(Locale(codeLang));
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('shareMessage', shareMessage);
  }

  Future<String?> getShareMessage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('shareMessage');
  }

  // ignore: always_declare_return_types
  setDefaultLang(String defaultLang) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('defaultLang', defaultLang);
  }

  Future<String?> getDefaultLang() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('defaultLang');
  }

  // ignore: always_declare_return_types
  setName(String name) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', name);
  }

  Future<String?> getName() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('username');
  }

  // ignore: always_declare_return_types
  setCode(String code) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('code', code);
  }

  Future<String?> getCode() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('code');
  }

  // ignore: always_declare_return_types
  setMarketer(String marketerId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('marketerId', marketerId);
  }

  Future<String?> getMarketer() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('marketerId');
  }

  // ignore: always_declare_return_types
  setType(String userType) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('type', userType);
  }

  Future<String?> getType() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('type');
  }

  // ignore: always_declare_return_types
  setAvatar(String avatar) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('avatar', avatar);
  }

  Future<String?> getAvatar() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('avatar');
  }

  // ignore: always_declare_return_types
  setFCMToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('fcm_token', token);
  }

  Future<String?> getFCMToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('fcm_token');
  }

  // ignore: always_declare_return_types
  setEmail(String email) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('email', email);
  }

  Future<String?> getEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('email');
  }

  // ignore: always_declare_return_types
  setSplashIsShown(bool isShown) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('splash', isShown);
  }

  Future<String?> getSplashIsShown() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('splash');
  }

  Future<void> cleanData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
