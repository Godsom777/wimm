import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

///external packages
import 'package:wimm/main.dart';
import 'package:wimm/screens/ExpenseScreen.dart';
//local packages
import 'IncomeAndExpenseScreen.dart';
import 'SettingsScreen.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    IncomeAndExpenseScreen(),
  
    BudgetScreen(),
  ];
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  
  void selectedPage(int index) {
    pageController.jumpToPage(index);
    setState(() {
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
  
    return AnnotatedRegion(
      value:  SystemUiOverlayStyle(
        systemNavigationBarColor: themeProvider.currentTheme!.primaryColor,
        statusBarColor: themeProvider.currentTheme!.primaryColor,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CrystalNavigationBar(
          duration: Durations.extralong2,
          backgroundColor: Colors.transparent,
          borderRadius: 15,
          outlineBorderColor: Colors.white70,
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.chart,
              unselectedIcon: IconlyLight.chart,
              selectedColor: themeProvider.currentTheme!.primaryColor,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.download,
              unselectedIcon: IconlyLight.download,
              selectedColor: themeProvider.currentTheme!.primaryColor,
            ),
            // CrystalNavigationBarItem(
            //   icon: IconlyBold.upload,
            //   unselectedIcon: IconlyLight.upload,
            //   selectedColor: themeProvider.currentTheme!.primaryColor,
            // ),
            CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: themeProvider.currentTheme!.primaryColor,
            ),
          ],
          currentIndex: selectedIndex,
          onTap: selectedPage,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: screens,
        ),// Add this method to return the selected screen
      ),
    );
  }
}