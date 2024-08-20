import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:provider/provider.dart';
import 'package:wimm/main.dart';

import '../utils/chart.dart';
import '../utils/local_providers.dart';

class IncomeAndExpenseScreen extends StatefulWidget {
  @override
  _IncomeAndExpenseScreenState createState() => _IncomeAndExpenseScreenState();
}

class _IncomeAndExpenseScreenState extends State<IncomeAndExpenseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_handleTabSelection);

    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {}); // Rebuild the widget when the tab index changes
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final primaColor = themeProvider.currentTheme!.indicatorColor;
    final secondColor = themeProvider.currentTheme!.hintColor;
    final bgColors = themeProvider.currentTheme!.hoverColor;
    final grey = themeProvider.currentTheme!.dividerColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Income and Expense',
            style:
                Provider.of<ScreenSizeProvider>(context).textStyleMediumBold),
        bottom: TabBar(
          dividerColor: themeProvider.currentTheme!.disabledColor,
          automaticIndicatorColorAdjustment: true,
          indicatorColor: themeProvider.currentTheme!.indicatorColor,
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: AnimatedDefaultTextStyle(
                curve: Curves.elasticInOut,
                style: TextStyle(
                  color: _tabController.index == 0 ? primaColor : grey,
                ),
                duration: Duration(milliseconds: 800),
                child: Text('Income',
                    style: _tabController.index == 0
                        ? Provider.of<ScreenSizeProvider>(context)
                            .textStyleSmallBold
                        : Provider.of<ScreenSizeProvider>(context)
                            .textStyleSmall),
              ),
            ),
            Tab(
                child: AnimatedDefaultTextStyle(
              curve: Curves.elasticInOut,
              style: TextStyle(
                color: _tabController.index == 0 ? grey : primaColor,
              ),
              duration: Duration(milliseconds: 800),
              child: Text('Expense',
                  style: _tabController.index == 1
                      ? Provider.of<ScreenSizeProvider>(context)
                          .textStyleSmallBold
                      : Provider.of<ScreenSizeProvider>(context)
                          .textStyleSmall),
            )),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          //////////  Income  ///////////
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: themeProvider.currentTheme!.hintColor
                                .withOpacity(0.4),
                            width: 0.5),
                        color: themeProvider.currentTheme!.cardColor),
                    child: IncomeWidget()),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Your InBounds',
                          style: Provider.of<ScreenSizeProvider>(context)
                              .textStyleMediumBold),
                    ],
                  ),
                ),
                Dismissible(
                  background: Container(
                    color: secondColor,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      IconlyBold.tick_square,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      IconlyBold.delete,
                      color: Colors.white,
                    ),
                  ),
                  key: UniqueKey(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Perform selection action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item selected')),
                      );
                      return false; // Prevent dismissal
                    } else if (direction == DismissDirection.endToStart) {
                      // Allow dismissal when swiped left
                      return true;
                    }
                    return false;
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      // Action for swiping left
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Swiped left')),
                      );
                    }
                  },
                  child:
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                     decoration: BoxDecoration(
                        color: bgColors,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    child: ExpansionTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 12),
                        child: Icon(IconlyBold.discount, color: secondColor),
                      ),
                      // backgroundColor: bgColors,
                      // collapsedBackgroundColor: bgColors,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$300',
                              style: Provider.of<ScreenSizeProvider>(context)
                                  .textStyleLargeBold),
                          Text(' 12/06/2021',
                              style: Provider.of<ScreenSizeProvider>(context)
                                  .textStyleXSmall),
                        ],
                      ),
                      subtitle: Text('Money from freelancer gig payment for June'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Money from freelancer gig payment for June oiewnfowe weijf iwjen  wenbc weic iwbec we cihwbeui we ciuwec ewcuiew cih e9bie cuw ic  weuc hw eciu wjecklj ahc ajjasd cjkq en dsnv d av dj',
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              ///////////////////Expense //////////////////
              child: Column(children: [
                ExpenseWidget(),
                Dismissible(
                  background: Container(
                    color: secondColor,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      IconlyBold.tick_square,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      IconlyBold.delete,
                      color: Colors.white,
                    ),
                  ),
                  key: UniqueKey(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Perform selection action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item selected')),
                      );
                      return false; // Prevent dismissal
                    } else if (direction == DismissDirection.endToStart) {
                      // Allow dismissal when swiped left
                      return true;
                    }
                    return false;
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      // Action for swiping left
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Swiped left')),
                      );
                    }
                  },
                  child: MUIPrimaryListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 12),
                      child: Icon(IconlyBold.discount, color: primaColor),
                    ),
                    bgColor: bgColors,
                    title: Text('title'),
                    description: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('data'), Text('data')],
                    ),
                  ),
                ),
              ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define your action here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Floating Action Button Pressed')),
          );
        },
        backgroundColor: primaColor, // Change the background color
        foregroundColor: Colors.white, // Change the icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change the shape
        ),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


/////////////////////////////////////////////////////////////

