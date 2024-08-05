import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen', style: Provider.of<ScreenSizeProvider>(context).textStyleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:  Container(
            height: 100,
            child: EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().add(const Duration(days: -365)), focusDate: _selectedDate, onDateChange: _onDateSelected, lastDate: DateTime.now().add(const Duration(days: 365)),
              
            ),
          ),
          ),

          Expanded(
            flex: 2,
            child: BarChartSample2(),
          ),
         
        ],
      ),
    );
  }
}
