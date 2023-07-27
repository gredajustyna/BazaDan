import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: mainOrange,
      ),
      scaffoldBackgroundColor: mainWhite,
      primaryColor: mainOrange,
      accentColor: mainOrange,
      splashColor: Colors.transparent,
      scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(mainOrange)
      ),
      fontFamily: 'Montserrat',
    );
  }

  // static ThemeData get dark {
  //   return ThemeData(
  //     appBarTheme: const AppBarTheme(
  //       elevation: 0,
  //       color: Colors.black,
  //     ),
  //     scaffoldBackgroundColor: Colors.black12,
  //     dividerColor: Colors.black12,
  //     primaryColor: totpDarkGreen,
  //     accentColor: totpDarkGreen,
  //     splashColor: Colors.transparent,
  //     scrollbarTheme: ScrollbarThemeData().copyWith(
  //         thumbColor: MaterialStateProperty.all(totpDarkGreen)
  //     ),
  //     fontFamily: 'Montserrat',
  //   );
  // }
}