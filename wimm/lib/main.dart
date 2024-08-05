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
    hoverColor: Colors.white70,
    disabledColor: Colors.black54,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        indicatorColor: const Color(0xFFff3378),
        unselectedWidgetColor: const Color(0xFF33C9FF),
        cardColor: const Color(0xFF41E94B),
        primaryColor: const Color(0xFFFF3378),
        hintColor: const Color(0xFF33C9FF),
        highlightColor: const Color(0xFF41E94B),
        splashColor: const Color(0xFFFFD5E4),
        secondaryHeaderColor: const Color(0xFF9EF8A4),
        textTheme: const TextTheme(
          titleSmall: TextStyle(fontSize: 8),
          labelSmall: TextStyle(fontSize: 10),
          displaySmall: TextStyle(fontSize: 12),
          bodySmall: TextStyle(fontSize: 14),
          bodyLarge: TextStyle(fontSize: 16),
          labelLarge: TextStyle(fontSize: 18),
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
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        hintColor: Colors.purple,
        shadowColor: Colors.grey,
        textTheme: const TextTheme(
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
