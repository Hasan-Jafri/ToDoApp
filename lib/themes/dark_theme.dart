import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/utils/colors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    // ignore: deprecated_member_use
    cardTheme: const CardTheme(
      color: Colours.topurple,
    ),
    scaffoldBackgroundColor: Colours.todarkpurple,
    appBarTheme: const AppBarTheme(
      elevation: 5,
      backgroundColor: Colours.topurple,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: Colours.tosilver),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colours.topurple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.topurple,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colours.tosilver,
      shape: Border.all(color: Colours.topurple),
    ),
  );
}
