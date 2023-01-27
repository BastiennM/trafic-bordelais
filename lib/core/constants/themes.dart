import 'package:flutter/material.dart';

abstract class Themes {
  static Color primary = const Color(0xff246EE9);
  static Color primaryLight = const Color(0xff246EE9);
  static Color primaryDark = const Color(0xff246EE9);
  static Color primaryDeep = const Color(0xff032d66);
  static Color accentLight = Colors.black;
  static Color iconColor = const Color(0xffF3F5F9);
  static Color error = const Color(0xffFF1B1B);
  static Color border = const Color(0xFF979797);

  static const Color _lightWhite = Colors.white;
  static const Color _lightBlack = Colors.black87;
  static const Color _lightGreyText = Colors.grey;
  static const Color _lightOnPrimaryColor = Colors.black;
  static Color accentDark = Colors.white;
  static final Color? _lightUnselectedIconColor = Colors.grey[500];
  static const Color _lightGrey100 = Color(0xFFB2B2B2);
  static final Color? _lightGrey50 = Colors.grey[50];


  static const Color _darkWhite = Colors.white;
  static const Color _darkBlack = Colors.black;
  static const Color _darkPrimaryVariantColor = Color(0xFF212121);
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkBackgroundColor = Color(0xFF2F2F2F);
  static final Color? _darkGrey50 = Colors.grey[50];
  static const Color _darkGrey100 = Color(0xFFB2B2B2);
  static const Color _darkGrey200 = Color(0xFF7E7E7E);
  static const Color _darkGrey300 = Color(0xFF303030);
  static final Color? _darkGrey700 = Colors.grey[700];
  static final Color? _darkGrey900 = Colors.grey[900];

  static final ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryLight,
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: _lightWhite,
      selectedIconTheme: IconThemeData(color: primaryLight),
      unselectedIconTheme: IconThemeData(color: _lightUnselectedIconColor),
      selectedLabelTextStyle: TextStyle(color: primaryLight),
      unselectedLabelTextStyle: const TextStyle(color: _lightBlack),
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: primaryLight,         //  <-- light color
        textTheme: ButtonTextTheme.primary, //  <-- dark text for light background
    ),
    focusColor:_lightGrey50,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: primaryLight),
      selectedItemColor: primaryLight,
      unselectedIconTheme: IconThemeData(color: _lightUnselectedIconColor),
      unselectedItemColor: _lightBlack,
    ),
    colorScheme: ColorScheme(
      primary: primaryLight,
      secondary: accentLight,
      background: Colors.white,
      surface: Colors.white,
      onBackground: Colors.white,
      error: error,
      onError: error,
      onPrimary: primaryLight,
      onSecondary: accentLight,
      onSurface: Colors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      iconTheme: const IconThemeData(color: _lightWhite),
    ),
    textTheme: _lightTextTheme
  );

  static final ThemeData darkTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryDark,
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: _darkBackgroundColor,
      selectedIconTheme: IconThemeData(color: primaryDark),
      unselectedIconTheme: const IconThemeData(color: _darkGrey200),
      selectedLabelTextStyle: TextStyle(color: primaryDark),
      unselectedLabelTextStyle: const TextStyle(color: _darkGrey100),
    ),
    focusColor: _darkGrey50,
    bottomAppBarColor: _darkPrimaryVariantColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkBackgroundColor,
      selectedIconTheme: IconThemeData(color: primaryDark),
      unselectedIconTheme: IconThemeData(color: _darkGrey700),
      selectedItemColor: primaryDark,
      unselectedItemColor: _darkGrey100,
    ),
    primaryIconTheme: const IconThemeData(color: _darkWhite),
    scaffoldBackgroundColor: _darkGrey300,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      iconTheme: const IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme(
      primary: primaryDark,
      secondary: accentDark,
      background: Colors.white,
      surface: Colors.white,
      onBackground: Colors.white,
      error: error,
      onError: error,
      onPrimary: primaryDark,
      onSecondary: accentDark,
      onSurface: Colors.white,
      brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: iconColor),
    textTheme: _darkTextTheme,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    caption: _darkScreenHeadingTextStyle,
    button: _darkScreenHeadingTextStyle,
    overline: _darkScreenHeadingTextStyle,
    bodyText1: _darkScreenTaskNameTextStyle,
    bodyText2: _darkScreenTaskDurationTextStyle,
    headline2: _darkScreenHeadingTextStyle,
    headline1: _darkScreenHeadingTextStyle,
    headline3: _darkScreenHeadingTextStyle,
    headline4: _darkScreenHeadingTextStyle,
    headline5: _darkScreenHeadingTextStyle,
    headline6: _darkScreenHeadingTextStyle,
    subtitle1: _darkScreenHeadingTextStyle,
    subtitle2: _darkScreenHeadingTextStyle,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    caption: _lightScreenHeadingTextStyle,
    button: _lightScreenHeadingTextStyle,
    overline: _lightScreenHeadingTextStyle,
    bodyText1: _lightScreenTextStyle1,
    bodyText2: _lightScreenTextStyle2,
    headline2: _lightScreenHeadingTextStyle,
    headline1: _lightScreenHeadingTextStyle,
    headline3: _lightScreenHeadingTextStyle,
    headline4: _lightScreenHeadingTextStyle,
    headline5: _lightScreenHeadingTextStyle,
    headline6: _lightScreenHeadingTextStyle,
    subtitle1: _lightScreenHeadingTextStyle,
    subtitle2: _lightScreenHeadingTextStyle,
  );

  static const TextStyle _lightScreenHeadingTextStyle = TextStyle(color: _lightOnPrimaryColor, fontSize: 20);
  static const TextStyle _lightScreenTextStyle1 = TextStyle(color: _lightOnPrimaryColor, fontSize: 14);
  static const TextStyle _lightScreenTextStyle2 = TextStyle(color: _lightGreyText, fontSize: 16);

  static final TextStyle _darkScreenHeadingTextStyle = _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskNameTextStyle = _lightScreenTextStyle1.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskDurationTextStyle = _lightScreenTextStyle2.copyWith(color: _darkOnPrimaryColor);
}
