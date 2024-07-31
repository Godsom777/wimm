
import 'package:flutter/material.dart';
import 'package:wimm/screens/mainscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
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
      title: 'Wimm',
      theme: themeProvider.currentTheme,
      home: const MainScreen(),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  // Theme properties
  bool isDarkMode = false;

  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.indigo,
        hintColor: Colors.purple,
        shadowColor: Colors.grey,
        textTheme: const TextTheme(
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

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        hintColor: Colors.purple,
        shadowColor: Colors.grey,
        textTheme: const TextTheme(
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

  ThemeData get currentTheme => isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

