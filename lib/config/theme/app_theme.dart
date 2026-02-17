import 'package:flutter/material.dart';

const colorList = <Color>[
  Color.fromARGB(255, 91, 82, 76),
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.green,
  Colors.purple,
  Colors.pink,
  Color.fromARGB(255, 74, 255, 64)
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({this.selectedColor = 0, this.isDarkmode = true})
      : assert(selectedColor >= 0, "El selectedColor debe ser mayor a cero"),
        assert(selectedColor < colorList.length,
            "El selectedColor debe ser menor a ${colorList.length - 1}");

  ThemeData getTheme() => ThemeData(
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  AppTheme copyWith({int? selectedColor, bool? isDarkmode}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
