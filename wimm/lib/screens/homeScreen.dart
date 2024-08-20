import 'dart:ffi';
import 'dart:ui';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wimm/main.dart';
import 'package:wimm/utils/chart.dart';
import '../utils/components/adviceBox.dart';
import '../utils/local_providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ScreenSizeProvider>(context, listen: false).init(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Statistics',
              style: Provider.of<ScreenSizeProvider>(context).textStyleLarge),
          actions: [
            IconButton(
              key: ValueKey<bool>(
                  themeProvider.currentTheme?.brightness == Brightness.light),
              icon: Icon(
                  themeProvider.currentTheme?.brightness == Brightness.light
                      ? CupertinoIcons.moon
                      : CupertinoIcons.sun_dust),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
            
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: themeProvider.currentTheme!.hintColor
                              .withOpacity(0.4),
                          width: 0.5),
                      color: themeProvider.currentTheme!.cardColor),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TotalBarChart(),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: themeProvider
                              .currentTheme!.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    FontAwesomeIcons.solidFaceGrinWink),
                                iconSize: 30,
                                color: themeProvider.currentTheme!.hintColor),
                            Text('Income',
                                style: Provider.of<ScreenSizeProvider>(context)
                                    .textStyleSmall),
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.nairaSign,
                                    size: 10),
                                Text('10,505,000',
                                    style:
                                        Provider.of<ScreenSizeProvider>(context)
                                            .textStyleMediumBold),
                              ],
                            ),
                          ],
                        )),
                    //////////////////////////

                    Container(
                        decoration: BoxDecoration(
                          color: themeProvider
                              .currentTheme!.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(FontAwesomeIcons.solidFaceFrown),
                                iconSize: 30,
                                color:
                                    themeProvider.currentTheme!.primaryColor),
                            Text('Expense',
                                style: Provider.of<ScreenSizeProvider>(context)
                                    .textStyleSmall),
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.nairaSign,
                                    size: 10),
                                Text('12,500,500',
                                    style:
                                        Provider.of<ScreenSizeProvider>(context)
                                            .textStyleMediumBold),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
                color: themeProvider.currentTheme!.dividerColor,
              ),
              ////////////////////////////////////
              ///MY GOALS//////////////

              Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My goals',
                            style: Provider.of<ScreenSizeProvider>(context)
                                .textStyleMedium,
                          ),
                          const Icon(IconlyLight.more_square, size: 20)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            MyGoalsCard(context, themeProvider),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
                color: themeProvider.currentTheme!.dividerColor,
              ),
              const SizedBox(
                height: 20,
              ),
              const AdviceBox(),
              const SizedBox(height:100,)
            ],
          ),
        ),
      ),
    );
  }

  Padding MyGoalsCard(BuildContext context, ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.currentTheme!.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: themeProvider.currentTheme!.disabledColor.withOpacity(0.4),
            width: 0.5,
          ),
        ),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Car',
                    style: Provider.of<ScreenSizeProvider>(context)
                        .textStyleSmallBold,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: themeProvider.currentTheme!.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'N500,000',
                        style: Provider.of<ScreenSizeProvider>(context)
                            .textStyleSmallBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'N120,000',
                      style: Provider.of<ScreenSizeProvider>(context)
                          .textStyleSmallBold.copyWith(color: themeProvider.currentTheme!.primaryColor),
                    ),
                    const TextSpan(text: '/'),
                    TextSpan(
                      text: 'N3,200,350',
                      style: Provider.of<ScreenSizeProvider>(context)
                          .textStyleSmallBold.copyWith(color:themeProvider.currentTheme!.hintColor),
                    )
                  ])),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: LinearProgressIndicator(
                value: 0.5,
                semanticsLabel: 'Linear progress indicator',
                semanticsValue: '50%',
                borderRadius: BorderRadius.circular(30),
                backgroundColor: themeProvider.currentTheme!.disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                    themeProvider.currentTheme!.hintColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
