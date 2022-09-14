import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final AppStyles styles = AppStyles();
  static final AppColors colors = AppColors();
  static const TextStyle primaryTitle = TextStyle(
      color: Color.fromRGBO(32, 211, 164, 1),
      fontSize: 18,
      fontFamily: "UenoLogical-Medium",
      fontWeight: FontWeight.w600);

  static const Color primary = Color(0xff532E53);
  static const Color verdeProfundo = Color.fromRGBO(32, 94, 94, 1);
  static const Color verdeSencillo = Color.fromRGBO(95, 249, 189, 1);
  static const Color gris1 = Color.fromRGBO(226, 226, 226, 1);
  static const Color gris2 = Color.fromRGBO(216, 216, 216, 1);
  static const Color gris3 = Color.fromRGBO(142, 142, 142, 1);
  static const Color grisTextos = Color.fromRGBO(151, 151, 151, 1);
  static const Color secondaryColor = Color(0xffF37364);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: colors.primaryColor,
      scaffoldBackgroundColor: colors.primaryColor,
      backgroundColor: Colors.white,
      cardColor: colors.whisperColor,
      dividerColor: colors.grisTextos,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        color: colors.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: styles.titleBold20.copyWith(color: Colors.white),
        toolbarHeight: 100,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        //primarios
        primary: colors.primaryColor,
        onPrimary: colors.primaryColor,
        //secundarios
        secondary: colors.secondaryColor,
        onSecondary: colors.secondaryColor,
        //terciarios
        tertiary: colors.palePinkColor,
        onTertiary: colors.palePinkColor,
        onTertiaryContainer: colors.palePinkColor,
        //errores
        error: colors.redColor,
        onError: colors.redColor,
        //Colores de Fondo
        //Fondo de un Widget que se puede realizar un Scroll.
        background: Colors.white,
        //Fondo de un Widget que se redibuja
        onBackground: colors.whisperColor,
        //color de fondo de uidgets
        surface: colors.whisperColor,
        onSurface: colors.whisperColor,
      ),

      //textos
      primaryTextTheme: ThemeData.light().textTheme.apply(
            fontFamily: "UenoLogical",
            displayColor: colors.grisTextos,
            bodyColor: colors.grisTextos,
          ),
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: "UenoLogical",
            displayColor: colors.grisTextos,
            bodyColor: colors.grisTextos,
          ),
      listTileTheme: ListTileThemeData(textColor: colors.grisTextos),

      //inputs

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: colors.primaryColor,
        errorStyle: TextStyle(color: colors.redColor),
        labelStyle: TextStyle(color: colors.primaryColor),
        hintStyle: TextStyle(color: colors.gris4Color),
        isDense: true,
        contentPadding: const EdgeInsets.all(16.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                styles.infoTextRegular14.copyWith(color: Colors.white)),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(colors.primaryColor)),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: colors.primaryColor,
          disabledColor: colors.gris2Color,
          splashColor: colors.palePinkColor),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  styles.infoTextRegular14.copyWith(color: colors.grisTextos)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent))),
      dialogTheme: DialogTheme(
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentTextStyle:
              AppTheme.styles.infoTextMedium14.copyWith(color: Colors.black54),
          titleTextStyle: AppTheme.styles.titleBold20
              .copyWith(color: AppTheme.colors.primaryColor)));

  static final ThemeData darkTheme = lightTheme.copyWith(
    backgroundColor: Colors.black,
    cardColor: colors.surfaceColor,
    dividerColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      //primarios
      primary: colors.primaryColor,
      onPrimary: colors.primaryColor,
      //secundarios
      secondary: colors.secondaryColor,
      onSecondary: colors.secondaryColor,
      //terciarios
      tertiary: colors.palePinkColor,
      onTertiary: colors.palePinkColor,
      onTertiaryContainer: colors.palePinkColor,
      //errores
      error: colors.redColor,
      onError: colors.redColor,
      //Colores de Fondo
      //Fondo de un Widget que se puede realizar un Scroll.
      background: Colors.black,
      //Fondo de un Widget que se redibuja
      onBackground: colors.surfaceColor,
      //color de fondo de uidgets
      surface: colors.surfaceColor,
      onSurface: colors.surfaceColor,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              styles.infoTextRegular14.copyWith(color: Colors.white)),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(colors.primaryColor)),
    ),

    //textos
    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: "UenoLogical",
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: "UenoLogical",
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
    listTileTheme: const ListTileThemeData(textColor: Colors.white),
    //inputs
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      fillColor: colors.primaryColor,
      labelStyle: const TextStyle(color: Colors.white),
    ),
  );
}
