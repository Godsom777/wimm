import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wimm/main.dart';
import 'package:wimm/screens/ExpenseScreen.dart';

import 'local_providers.dart';

class TotalBarChart extends StatefulWidget {
  TotalBarChart({Key? key}) : super(key: key);
  final Color leftBarColor = ThemeProvider().currentTheme!.indicatorColor;
  final Color rightBarColor = ThemeProvider().currentTheme!.hintColor;
  final Color avgColor = ThemeProvider().currentTheme!.cardColor;

  @override
  State<StatefulWidget> createState() => TotalBarChartStateState();
}

class TotalBarChartStateState extends State<TotalBarChart>
    with SingleTickerProviderStateMixin {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  bool _toggle = true;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);
    _startAnimation();

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  void _startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _toggle = !_toggle;
      });
      _startAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                makeTransactionsIcon(),
                const SizedBox(
                  width: 38,
                ),
                Text(
                  'Transactions',
                  style:
                      Provider.of<ScreenSizeProvider>(context).textStyleMedium,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'state',
                  style:
                      Provider.of<ScreenSizeProvider>(context).textStyleSmall,
                ),
              ],
            ),
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: ((group) {
                        return Colors.grey;
                      }),
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    final themeProvider = Provider.of<ThemeProvider>(context);

    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: themeProvider.currentTheme!.hoverColor.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: themeProvider.currentTheme!.hoverColor.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: themeProvider.currentTheme!.hoverColor.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: themeProvider.currentTheme!.shadowColor.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: themeProvider.currentTheme!.hoverColor.withOpacity(0.4),
        ),
      ],
    );
  }
}
/////////////////////////////////////////////////////////INCOME & EXPENSE SCREEN ///////////////////////////

class IncomeWidget extends StatefulWidget {

  
  IncomeWidget({Key? key}) : super(key: key);
  final Color rightBarColor = ThemeProvider().currentTheme!.hintColor;
  final Color avgColor = ThemeProvider().currentTheme!.cardColor;

  @override
  State<StatefulWidget> createState() => IncomeWidgetState();
}

class IncomeWidgetState extends State<IncomeWidget>
    with SingleTickerProviderStateMixin {
      
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  bool _toggle = true;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin:Color(0xFFff3378),
      end: const Color(0xFF33C9FF),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _colorAnimation2 = ColorTween(
      begin: const Color(0xFF33C9FF),
      end:Color(0xFFff3378),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));
        _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        _toggle = !_toggle;
      });
      _startAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 38,
                ),
                Text(
                  'Weeks Income Chart',
                  style: Provider.of<ScreenSizeProvider>(context)
                      .textStyleSmallBold,
                ),
                const SizedBox(
                  width: 4,
                ),
                Row(
                  children: [
                    Icon(IconlyBroken.time_circle),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  onEnd: () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  },
               
                  child: LineChart(
                    LineChartData(
                      baselineY: 00,
                      baselineX: 00,
                      maxX: 7,
                      lineBarsData: [
                        LineChartBarData(
                          curveSmoothness: 0.3,
                          isStepLineChart: false,
                          isStrokeCapRound: true,
                          showingIndicators: [],
                          preventCurveOverShooting: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: themeProvider.currentTheme!.hintColor
                                .withOpacity(0.2),
                          ),
                           gradient: LinearGradient(
                      colors: [
                        _colorAnimation1.value!,
                        _colorAnimation2.value!,
                            ],
                    ),
                          spots: [
                            FlSpot(1, 20000),
                            FlSpot(2, 25000),
                            FlSpot(3, 140000),
                            FlSpot(4, 90000),
                            FlSpot(5, 10000),
                            FlSpot(6, 90000),
                            FlSpot(7, 10000),
                          ],
                          isCurved: true,
                          color: themeProvider.currentTheme!.indicatorColor,
                          barWidth: 2,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 1:
                                  return Text('Mon');
                                case 2:
                                  return Text('Tue');
                                case 3:
                                  return Text('Wed');
                                case 4:
                                  return Text('Thu');
                                case 5:
                                  return Text('Fri');
                                case 6:
                                  return Text('Sat');
                                case 7:
                                  return Text('Sun');
                              }
                              return Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          drawBelowEverything: false,
                          axisNameSize: 18,
                          axisNameWidget: Text('Amount'),
                          sideTitles: SideTitles(
                            reservedSize: 1,
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toString(),
                                style: Provider.of<ScreenSizeProvider>(context)
                                    .textStyleXSmall,
                                softWrap: false,
                                overflow: TextOverflow.visible,
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: const Color(0xff37434d)),
                      ),
                      gridData: FlGridData(show: true),
                    ),
                  ),
                )),

            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 0);
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      fitInside: const SideTitleFitInsideData(
          enabled: false,
          axisPosition: 10,
          parentAxisSize: 8,
          distanceFromEdge: 0),
      axisSide: meta.axisSide,
      space: 0,
      child: Text(
        text,
        style: style,
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }
}


///////////////////////////////// Expenses Tab //////////////////////////////
///


class ExpenseWidget extends StatefulWidget {

  
  ExpenseWidget({super.key});
  final Color rightBarColor = ThemeProvider().currentTheme!.hintColor;
  final Color avgColor = ThemeProvider().currentTheme!.cardColor;

  @override
  State<StatefulWidget> createState() => ExpenseWidgetState();
}

class ExpenseWidgetState extends State<ExpenseWidget>
    with SingleTickerProviderStateMixin {
      
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  bool _toggle = true;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin:Color(0xFFff3378),
      end: const Color(0xFF33C9FF),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _colorAnimation2 = ColorTween(
      begin: const Color(0xFF33C9FF),
      end:Color(0xFFff3378),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));
        _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        _toggle = !_toggle;
      });
      _startAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 38,
                ),
                Text(
                  'Weeks Income Chart',
                  style: Provider.of<ScreenSizeProvider>(context)
                      .textStyleSmallBold,
                ),
                const SizedBox(
                  width: 4,
                ),
                Row(
                  children: [
                    Icon(IconlyBroken.time_circle),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  onEnd: () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  },
               
                  child: LineChart(
                    LineChartData(
                      baselineY: 00,
                      baselineX: 00,
                      maxX: 7,
                      lineBarsData: [
                        LineChartBarData(
                          curveSmoothness: 0.3,
                          isStepLineChart: false,
                          isStrokeCapRound: true,
                          showingIndicators: [],
                          preventCurveOverShooting: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: themeProvider.currentTheme!.hintColor
                                .withOpacity(0.2),
                          ),
                           gradient: LinearGradient(
                      colors: [
                        _colorAnimation1.value!,
                        _colorAnimation2.value!,
                            ],
                    ),
                          spots: [
                            FlSpot(1, 20000),
                            FlSpot(2, 25000),
                            FlSpot(3, 140000),
                            FlSpot(4, 90000),
                            FlSpot(5, 10000),
                            FlSpot(6, 90000),
                            FlSpot(7, 10000),
                          ],
                          isCurved: true,
                          color: themeProvider.currentTheme!.indicatorColor,
                          barWidth: 2,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 1:
                                  return Text('Mon');
                                case 2:
                                  return Text('Tue');
                                case 3:
                                  return Text('Wed');
                                case 4:
                                  return Text('Thu');
                                case 5:
                                  return Text('Fri');
                                case 6:
                                  return Text('Sat');
                                case 7:
                                  return Text('Sun');
                              }
                              return Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          drawBelowEverything: false,
                          axisNameSize: 18,
                          axisNameWidget: Text('Amount'),
                          sideTitles: SideTitles(
                            reservedSize: 1,
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toString(),
                                style: Provider.of<ScreenSizeProvider>(context)
                                    .textStyleXSmall,
                                softWrap: false,
                                overflow: TextOverflow.visible,
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: const Color(0xff37434d)),
                      ),
                      gridData: FlGridData(show: true),
                    ),
                  ),
                )),

            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 0);
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      fitInside: const SideTitleFitInsideData(
          enabled: false,
          axisPosition: 10,
          parentAxisSize: 8,
          distanceFromEdge: 0),
      axisSide: meta.axisSide,
      space: 0,
      child: Text(
        text,
        style: style,
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }
}