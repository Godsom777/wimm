import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wimm/main.dart';
import 'package:wimm/utils/chart.dart';
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


    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics', style: Provider.of<ScreenSizeProvider>(context).textStyleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                color: themeProvider.currentTheme!.hoverColor,
             
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().add(const Duration(days: -365)), focusDate: _selectedDate, onDateChange: _onDateSelected, lastDate: DateTime.now().add(const Duration(days: 365)),
                
              ),
                        ),
          
              BarChartSample2(),
              Container(
                color: themeProvider.currentTheme!.hoverColor,
                width: MediaQuery.of(context).size.width - 100,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: themeProvider.currentTheme!.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
              
              
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     
                        children: [
                          IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.solidFaceGrinWink), iconSize: 30, color: themeProvider.currentTheme!.hintColor),
                          Text('Income', style: Provider.of<ScreenSizeProvider>(context).textStyleSmall),
                          Row(
                            children: [
                              Icon( FontAwesomeIcons.nairaSign, size: 8),
                              Text('1000', style: Provider.of<ScreenSizeProvider>(context).textStyleLarge),
                            ],
                          ),
                        ],
                      )),
                      //////////////////////////
              
                      Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: themeProvider.currentTheme!.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.solidFaceFrown), iconSize: 30, color: themeProvider.currentTheme!.primaryColor),
                          Text('Expense', style: Provider.of<ScreenSizeProvider>(context).textStyleSmall),
                          Row(
                            children: [
                              Icon( FontAwesomeIcons.nairaSign, size: 8),
                              Text('500', style: Provider.of<ScreenSizeProvider>(context).textStyleLarge),
                            ],
                          ),
                        ],
                      )),
                     
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width - 100,
              )
             
            ],
          ),
        ),
      ),
    );
  }
}
