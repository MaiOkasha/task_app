import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.blue, //appBar and button colors not test
    brightness: Brightness.light,//compare the background color with text color if the bck is white it should be white and if bck is black text will be white
  );
  static final dark = ThemeData(
    backgroundColor: Colors.black54,
      primaryColor: Colors.red,
      brightness: Brightness.dark
  );

  /*TextStyle get subHeadingStyle{
    return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,

      )

    );
  }*/
}