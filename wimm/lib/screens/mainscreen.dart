import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///external packages
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wimm/main.dart';
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
    SettingsScreen(),
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
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: screens,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: WaterDropNavBar(
          waterDropColor: Colors.indigo,
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: FontAwesomeIcons.houseUser,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
              filledIcon: CupertinoIcons.money_dollar_circle_fill,
              outlinedIcon: CupertinoIcons.money_dollar_circle,
            ),
            BarItem(
              filledIcon: FontAwesomeIcons.cogs,
              outlinedIcon: FontAwesomeIcons.cog,
            ),
          ],
          onItemSelected: onItemSelected,
        ),
      ),
    );
  }
}
