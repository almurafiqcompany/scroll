import 'package:flutter/material.dart';

final ThemeData themeDataDark = themeDataLight.copyWith(
  brightness: Brightness.dark,
);
final ThemeData themeDataLight = ThemeData(
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
  colorScheme: const ColorScheme.light(primary: Colors.white),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
);
const TextStyle appbarTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  letterSpacing: 1.1,
  fontWeight: FontWeight.w700,
);
const TextStyle TextFiledStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFFC6C6D2),
  letterSpacing: 1.1,
);
const TextStyle buttonTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
  letterSpacing: 1.1,
);
const TextStyle buttonTextStyle1 = TextStyle(
  fontSize: 18,
  color: Colors.white,
  letterSpacing: 1.1,
);
const TextStyle buttonTextStyle2 = TextStyle(
  fontSize: 20,
  color: Colors.white,
  letterSpacing: 1.1,
);
const TextStyle headerTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.1,
);
const TextStyle headerTextStyle1 = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.1,
);
const TextStyle headerTextStyle2 = TextStyle(
  fontSize: 22,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.1,
);
const TextStyle headerTextStyle3 = TextStyle(
  fontSize: 28,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.1,
);
const TextStyle paragraphTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w300,
  letterSpacing: 1.1,
);

const TextStyle cardHeaderTextStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFF42436A),
  fontWeight: FontWeight.w700,
  letterSpacing: 1.1,
);
const TextStyle cardHeaderTextStyle1 = TextStyle(
  fontSize: 18,
  color: Color(0xFF42436A),
  fontWeight: FontWeight.w700,
  letterSpacing: 1.1,
);
const TextStyle cardParagraphTextStyle = TextStyle(
  color: Color(0xFF42436A),
  fontSize: 14,
  fontWeight: FontWeight.w300,
);
