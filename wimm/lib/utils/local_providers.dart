import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSizeProvider with ChangeNotifier {
  double _height = 0.0;
  double _width = 0.0;
  double _fontSizeSmall = 0.0;
  double _fontSizeMedium = 0.0;
  double _fontSizeLarge = 0.0;
  final FontWeight _fontWeightLight = FontWeight.w300;
  final FontWeight _fontWeightRegular = FontWeight.w400;
  final FontWeight _fontWeightBold = FontWeight.w700;
   TextStyle _textStyleSmall = const TextStyle();
  TextStyle _textStyleMedium = const TextStyle();
  TextStyle _textStyleLarge = const TextStyle();

void init(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    // Define font sizes based on screen width
    _fontSizeSmall = _width * 0.04;
    _fontSizeMedium = _width * 0.05;
    _fontSizeLarge = _width * 0.06;

    // Define text styles using Google Fonts
    _textStyleSmall = GoogleFonts.oswald(
      fontSize: _fontSizeSmall,
      fontWeight: _fontWeightLight,
    );
    _textStyleMedium = GoogleFonts.oswald(
      fontSize: _fontSizeMedium,
      fontWeight: _fontWeightRegular,
    );
    _textStyleLarge = GoogleFonts.poppins(
      fontSize: _fontSizeLarge,
      fontWeight: _fontWeightBold,
    );

    notifyListeners();
  }

  double get height => _height;
  double get width => _width;
  double get fontSizeSmall => _fontSizeSmall;
  double get fontSizeMedium => _fontSizeMedium;
  double get fontSizeLarge => _fontSizeLarge;

  TextStyle get textStyleSmall => _textStyleSmall;
  TextStyle get textStyleMedium => _textStyleMedium;
  TextStyle get textStyleLarge => _textStyleLarge;
}