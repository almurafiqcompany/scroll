import 'dart:io';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/services/translation.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'constants.dart';
import 'core/service_locator.dart';
import 'screens/countries/countries_screen.dart';
import 'screens/splash/splash.dart';

//
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   HttpOverrides.global = MyHttpOverrides();
//   await setupLocators();
//
//   runApp(Phoenix(child: MyApp()));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final SharedPreferenceHelper _helper =
      GetIt.instance.get<SharedPreferenceHelper>();
  final String langCode = await _helper.getCodeLang() ?? 'ar';
  runApp(MyApps(langCode: langCode));
  setupDio();
}

// ignore: always_declare_return_types
setupDio() async {
  print('setup dio called');
  final Dio dio = locator<Dio>();
  dio.interceptors.clear();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    print('onHttpClientCreate entered...');
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  dio.options.baseUrl = BaseUrl;
  dio.options.validateStatus = (int? val) => true;
}

class MyApps extends StatefulWidget {
  final String? langCode;
  const MyApps({Key? key, this.langCode}) : super(key: key);
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  void initState() {
    // FirebaseNotifications().configFcm();
    // ignore: flutter_style_todos
    // TODO: implement initState
    super.initState();
  }

  String? l;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: [
        Locale('en', 'US'), // the error appears here
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      translations: Translation(),
      locale: Locale(widget.langCode!),
      fallbackLocale: const Locale('ar'),
      title: widget.langCode == 'ar' ? 'مرافق' : 'Al_Murafiq',
      // title:'مرافق',
      debugShowCheckedModeBanner: false,
      // textDirection: l=='ar'?TextDirection.rtl:TextDirection.ltr,
      // textDirection: TextDirection.rtl,
      theme: ThemeData(
        // fontFamily: 'ltbukra',
        fontFamily: 'IBMPlexSansArabic',
        scaffoldBackgroundColor: const Color(0xFFF1F4FB),
        primaryColor: const Color(0xFF03317C),
        accentColor: const Color(0xFF05B3D6),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: const Color(0xFF03317C).withOpacity(0.2),
          cursorColor: const Color(0xFF03317C),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        // colorScheme: const ColorScheme.light(primary: Colors.white),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        // inputDecorationTheme: InputDecorationTheme(
        //   hintStyle: kTextStyle.copyWith(color: Colors.grey[500]),
        //   errorStyle: kTextStyle.copyWith(fontSize: 12),
        //   enabledBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: Colors.grey[500])),
        //   focusedBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: kPrimaryColor)),
        //   errorMaxLines: 1,
        // ),
      ),

      home:
          // BranchesScreen(),
          // BottomNavBar(),
          // SideMenu(
          //   sideMenuType: SideMenuTypes.Delegate,
          // ),
          // StreamBuilder<Object>(
          //   stream: null,
          //   builder: (context, snapshot) {
          //     return CountriesScreen();
          //   }
          // ),

          // StreamBuilder<int>(
          //     // ignore: always_specify_types
          //     stream: Stream.fromFuture(getIsCountryId()),
          //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          //       if (snapshot.hasData && snapshot.data != null) {
          //         return BottomNavBar();
          //       } else {
          //         return CountriesScreen();
          //
          //       }
          //     }),
          Splash(),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<int> getIsCountryId() async {
    return await helper.getCountryId();
  }
}
//CountriesScreen()

// localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
// AppLocalizations.delegate,
// GlobalCupertinoLocalizations.delegate,
// GlobalMaterialLocalizations.delegate,
// GlobalWidgetsLocalizations.delegate,
// ],
// supportedLocales: Constants.SUPPORTED_LOCALE.map((String s) => Locale(s)),
// localeResolutionCallback:
// (Locale locale, Iterable<Locale> supportedLocales) {
// for (final Locale supportedLocale in supportedLocales) {
// if (supportedLocale?.languageCode == locale?.languageCode) {
// l=supportedLocale.languageCode;
// print('code $l');
// print('code $supportedLocale');
// print('code $locale');
// print('code $l');
// // return supportedLocale;
// return supportedLocales.first;
// }
// }
// l=supportedLocales.first.languageCode;
// print('code2$l');
// return supportedLocales.first;
// },