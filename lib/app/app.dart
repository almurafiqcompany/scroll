import 'package:al_murafiq/core/service_locator.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_bloc.dart';
import 'app_localizations.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    locator<AppBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState>(
      stream: locator<AppBloc>().stream.distinct(),
      initialData: AppBloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<AppState> snapshot) {
        return MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales:
              Constants.SUPPORTED_LOCALE.map((String s) => Locale(s)),
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            for (final Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          locale: snapshot.data?.locale,
          debugShowCheckedModeBanner: false,
          theme: snapshot.data?.themeData,
          ////onGenerateRoute: Routes.generateRoute,
          initialRoute: PageRouteName.INITIAL,
          // home: PayPlansScreen(),
        );
      },
    );
  }
}
