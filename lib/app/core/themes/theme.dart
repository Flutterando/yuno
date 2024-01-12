import 'package:flutter/material.dart';

part 'color_schemes.g.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    appBarTheme: _appBarTheme,
  );
}

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    appBarTheme: _appBarTheme,
  );
}

AppBarTheme get _appBarTheme {
  return const AppBarTheme(
    centerTitle: false,
  );
}
