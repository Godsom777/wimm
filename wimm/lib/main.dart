import 'package:flutter/material.dart';
import 'package:wimm/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'utils/local_providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ScreenSizeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'where is my money',
      theme: themeProvider.currentTheme,
      home: const MainScreen(),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  // Theme properties
  bool? isDarkMode = false;

  ThemeData? get lightTheme => ThemeData(
        hoverColor: Color.fromARGB(255, 246, 246, 246),
        disabledColor: Color.fromARGB(162, 0, 0, 0),
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        indicatorColor: const Color(0xFFff3378),
        unselectedWidgetColor: Colors.blueGrey,
        cardColor: Color(0xFFF5F5F5),
        primaryColor: const Color(0xFFFF3378),
        hintColor: const Color(0xFF33C9FF),
        highlightColor: const Color(0xFF41E94B),
        dividerColor: Colors.grey,
        splashColor: const Color(0xFFFFD5E4),
        secondaryHeaderColor: const Color(0xFF9EF8A4),
        textTheme: const TextTheme(
          titleSmall: TextStyle(fontSize: 8, color: Colors.black45),
          labelSmall: TextStyle(fontSize: 10, color: Colors.black45),
          displaySmall: TextStyle(fontSize: 12, color: Colors.black45),
          bodySmall: TextStyle(fontSize: 14, color: Colors.black45),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black45),
          labelLarge: TextStyle(fontSize: 18, color: Colors.black45),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  ThemeData? get darkTheme => ThemeData(
        disabledColor: Color(0x90E6E6E6),
        scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 15),
        brightness: Brightness.dark,
        hintColor: const Color(0xFF33C9FF),
        hoverColor: Color.fromARGB(45, 135, 124, 124),
        shadowColor: Colors.grey,
        dividerColor: Color.fromARGB(111, 158, 158, 158),
        indicatorColor: const Color(0xFFff3378),
        unselectedWidgetColor: Color(0xFFD6D6D6),
        cardColor: Color.fromARGB(255, 32, 32, 32),
        primaryColor: const Color(0xFFFF3378),
        highlightColor: const Color(0xFF41E94B),
        splashColor: Color.fromARGB(255, 33, 33, 33),
        secondaryHeaderColor: const Color(0xFF9EF8A4),

        //////
        textTheme: const TextTheme(
          titleSmall: TextStyle(fontSize: 8, color: Colors.white),
          labelSmall: TextStyle(fontSize: 10, color: Colors.white),
          displaySmall: TextStyle(fontSize: 12, color: Colors.white),
          bodySmall: TextStyle(fontSize: 14, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
          labelLarge: TextStyle(fontSize: 18, color: Colors.white),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  ThemeData? get currentTheme => isDarkMode ?? false ? darkTheme : lightTheme;

  void toggleTheme() {
    isDarkMode = !(isDarkMode ?? false);
    notifyListeners();
  }
}
