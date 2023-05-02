import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 65, 63, 63),
  primarySwatch: Colors.yellow,
  appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Color.fromARGB(255, 65, 63, 63),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      )),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white54,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);
