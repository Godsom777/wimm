import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSizeProvider with ChangeNotifier {
  double _height = 0.0;
  double _width = 0.0;
  double _fontXSmall = 0.0;
  double _fontSizeSmall = 0.0;
  double _fontSizeMedium = 0.0;
  double _fontSizeLarge = 0.0;
  final FontWeight _fontWeightXLight = FontWeight.w100;
  final FontWeight _fontWeightLight = FontWeight.w300;
  final FontWeight _fontWeightRegular = FontWeight.w500;
  final FontWeight _fontWeightBold = FontWeight.w700;

  TextStyle _textStyleXSmall = const TextStyle();
  TextStyle _textStyleSmall = const TextStyle();
  TextStyle _textStyleMedium = const TextStyle();
  TextStyle _textStyleLarge = const TextStyle();

  // Additional font variants
  TextStyle _textStyleSmallItalic = const TextStyle();
  TextStyle _textStyleMediumItalic = const TextStyle();
  TextStyle _textStyleLargeItalic = const TextStyle();
  TextStyle _textStyleSmallBold = const TextStyle();
  TextStyle _textStyleMediumBold = const TextStyle();
  TextStyle _textStyleLargeBold = const TextStyle();

  void init(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    // Define font sizes based on screen width
    _fontXSmall = _width * 0.03;
    _fontSizeSmall = _width * 0.04;
    _fontSizeMedium = _width * 0.05;
    _fontSizeLarge = _width * 0.06;

    // Define text styles using Google Fonts
        _textStyleXSmall = GoogleFonts.roboto(
      fontSize: _fontXSmall,
      fontWeight: _fontWeightLight,
    );
    
    _textStyleSmall = GoogleFonts.roboto(
      fontSize: _fontSizeSmall,
      fontWeight: _fontWeightLight,
    );

    _textStyleMedium = GoogleFonts.raleway(
      fontSize: _fontSizeMedium,
      fontWeight: _fontWeightRegular,
    );
    _textStyleLarge = GoogleFonts.raleway(
      fontSize: _fontSizeLarge,
      fontWeight: _fontWeightRegular,
    );

    // Additional font variants
    _textStyleSmallItalic = GoogleFonts.roboto(
      fontSize: _fontSizeSmall,
      fontWeight: _fontWeightLight,
      fontStyle: FontStyle.italic,
    );
    _textStyleMediumItalic = GoogleFonts.roboto(
      fontSize: _fontSizeMedium,
      fontWeight: _fontWeightRegular,
      fontStyle: FontStyle.italic,
    );
    _textStyleLargeItalic = GoogleFonts.poppins(
      fontSize: _fontSizeLarge,
      fontWeight: _fontWeightBold,
      fontStyle: FontStyle.italic,
    );
    _textStyleSmallBold = GoogleFonts.raleway(
      fontSize: _fontSizeSmall,
      fontWeight: FontWeight.bold,
    );
    _textStyleMediumBold = GoogleFonts.raleway(
      fontSize: _fontSizeMedium,
      fontWeight: FontWeight.bold,
    );
    _textStyleLargeBold = GoogleFonts.raleway(
      fontSize: _fontSizeLarge,
      fontWeight: FontWeight.bold,
    );

    notifyListeners();
  }

  double get height => _height;
  double get width => _width;
  double get fontSizeSmall => _fontSizeSmall;
  double get fontSizeMedium => _fontSizeMedium;
  double get fontSizeLarge => _fontSizeLarge;
  
  TextStyle get textStyleXSmall => _textStyleXSmall;
  TextStyle get textStyleSmall => _textStyleSmall;
  TextStyle get textStyleMedium => _textStyleMedium;
  TextStyle get textStyleLarge => _textStyleLarge;

  // Getters for additional font variants
  TextStyle get textStyleSmallItalic => _textStyleSmallItalic;
  TextStyle get textStyleMediumItalic => _textStyleMediumItalic;
  TextStyle get textStyleLargeItalic => _textStyleLargeItalic;
  TextStyle get textStyleSmallBold => _textStyleSmallBold;
  TextStyle get textStyleMediumBold => _textStyleMediumBold;
  TextStyle get textStyleLargeBold => _textStyleLargeBold;
}