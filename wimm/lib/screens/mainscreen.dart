import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///external packages
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
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
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: screens,
        ),
        bottomNavigationBar: FloatingNavbar(
          

          ///////////////////////////
          backgroundColor:     Color.fromARGB(82, 177, 177, 177),
        selectedItemColor: themeProvider.currentTheme?.splashColor,
        unselectedItemColor: themeProvider.currentTheme?. disabledColor,
        selectedBackgroundColor: themeProvider.currentTheme?.indicatorColor,
          
          ///////////////
          
          currentIndex: selectedIndex,
          onTap: onItemSelected,
          items: [
            FloatingNavbarItem(
              icon: FontAwesomeIcons.houseUser,
              title: 'Home',
            ),
            FloatingNavbarItem(
              icon: CupertinoIcons.money_dollar_circle,
              title: 'Tracker',
            ),
               FloatingNavbarItem(
              icon: CupertinoIcons.money_dollar_circle,
              title: 'Tracker',
            ),
            
            FloatingNavbarItem(
              icon: FontAwesomeIcons.circleDot,
              title: 'Budgets',
            ),
          ],
        ).frosted(
          blur: 10,
          borderRadius: BorderRadius.circular(20),
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
