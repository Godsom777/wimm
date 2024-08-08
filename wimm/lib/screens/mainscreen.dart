import 'package:blur/blur.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

///external packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wimm/main.dart';
import 'package:wimm/screens/ExpenseScreen.dart';
//local packages
import 'IncomeScreen.dart';
import 'SettingsScreen.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = const [
    HomeScreen(),
    IncomeScreen(),
    ExpenseScreen(),
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
  
  void onItemSelected(int index) {
    pageController.jumpToPage(index);
    setState(() {
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
  
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        bottomNavigationBar: CrystalNavigationBar(
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.wallet,
              unselectedIcon: IconlyLight.wallet,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.chart,
              unselectedIcon: IconlyLight.chart,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: Colors.white,
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemSelected,
        ),
        body: _getSelectedScreen(), // Add this method to return the selected screen
      ),
    );
  }
  
  Widget _getSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return IncomeScreen();
      case 2:
        return ExpenseScreen();
      case 3:
        return BudgetScreen();
      default:
        return HomeScreen();
    }
  }}