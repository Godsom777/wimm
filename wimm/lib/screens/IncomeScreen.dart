import 'package:blur/blur.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wimm/main.dart';
import 'package:wimm/utils/local_providers.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _incomes = [
    {
      'title': 'Income 1',
      'amount': '\$100',
      'date': '2023-01-01',
      'category': 'Salary'
    },
    {
      'title': 'Income 2',
      'amount': '\$200',
      'date': '2023-02-01',
      'category': 'Freelance'
    },
    // Add more incomes here
  ];
  List<Map<String, String>> _filteredIncomes = [];
  String _sortCriteria = 'date'; // Default sorting criteria

  @override
  void initState() {
    super.initState();
    _filteredIncomes = _incomes;
    _searchController.addListener(_filterIncomes);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );
  }

  void _showAddIncomeForm(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(0),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title',),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Date'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(color: Theme.of(context).disabledColor),
                    ),
                    onPressed: () {
                      // Handle form submission
                      Navigator.pop(context);
                    },
                    child: Text('Add Income', ),
                  ),
                ],
              )
          ).blurry(
            blur: 5,
            shadowColor: Colors.black.withOpacity(0),
            borderRadius: BorderRadius.circular(20),       
        ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _filterIncomes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredIncomes = _incomes.where((income) {
        final title = income['title']!.toLowerCase();
        final category = income['category']!.toLowerCase();
        return title.contains(query) || category.contains(query);
      }).toList();
      _sortIncomes();
    });
  }

  void _sortIncomes() {
    setState(() {
      _filteredIncomes.sort((a, b) {
        if (_sortCriteria == 'amount') {
          return int.parse(a['amount']!.substring(1))
              .compareTo(int.parse(b['amount']!.substring(1)));
        } else if (_sortCriteria == 'date') {
          return DateTime.parse(a['date']!)
              .compareTo(DateTime.parse(b['date']!));
        } else {
          return a['title']!.compareTo(b['title']!);
        }
      });
    });
  }

  void _updateSortCriteria(String criteria) {
    setState(() {
      _sortCriteria = criteria;
      _sortIncomes();
    });
  }

  void _onFabPressed() {
    _controller.forward().then((_) => _controller.reverse());
    // Add your onPressed logic here
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Incomes',
            style: Provider.of<ScreenSizeProvider>(context).textStyleLarge),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: themeProvider.currentTheme!.primaryColor,
                focusColor: themeProvider.currentTheme!.primaryColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: themeProvider.currentTheme!.primaryColor),
                ),
                prefixIconColor: themeProvider.currentTheme!.primaryColor,
                prefixIcon: Icon(IconlyLight.search),
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          // Calendar that shows a full month with selectable dates
          // TableCalendar(
          //   firstDay: DateTime.utc(2024, 1, 1),
          //   lastDay: DateTime.utc(2024, 12, 31),
          //   focusedDay: _focusedDay,
          //   calendarFormat: _calendarFormat,
          //   selectedDayPredicate: (day) {
          //     return isSameDay(_selectedDay, day);
          //   },
          //   onDaySelected: (selectedDay, focusedDay) {
          //     setState(() {
          //       _selectedDay = selectedDay;
          //       _focusedDay = focusedDay; // update `_focusedDay` here as well
          //     });
          //   },
          //   onFormatChanged: (format) {
          //     if (_calendarFormat != format) {
          //       setState(() {
          //         _calendarFormat = format;
          //       });
          //     }
          //   },
          //   onPageChanged: (focusedDay) {
          //     _focusedDay = focusedDay;
          //   },
          // ),
          // List of incomes
          Expanded(
            child: Container(
              child: Column(
                children: [
                  // Filter and Sort options
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Filter by date and category
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Filter'),
                        ),
                        // Sort by amount, date, and title
                        DropdownButton<String>(
                          value: _sortCriteria,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _updateSortCriteria(newValue);
                            }
                          },
                          items: <String>['amount', 'date', 'title']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text('Sort by $value'),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  // List of incomes
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredIncomes.length,
                      itemBuilder: (context, index) {
                        final income = _filteredIncomes[index];
                        return ListTile(
                          title: Text(income['title']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Amount: ${income['amount']}'),
                              Text('Date: ${income['date']}'),
                              Text('Category: ${income['category']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredIncomes.length,
                      itemBuilder: (context, index) {
                        final income = _filteredIncomes[index];
                        return ListTile(
                          title: Text(income['title']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Amount: ${income['amount']}'),
                              Text('Date: ${income['date']}'),
                              Text('Category: ${income['category']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Button to add a new income

                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return _showAddIncomeForm(context);
        },
        backgroundColor: themeProvider.currentTheme!.primaryColor,
        child: Icon(
          IconlyBold.plus,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Move the FAB up by 20 pixels
    double fabX = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        16.0;
    double fabY = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        80.0;
    return Offset(fabX, fabY);
  }
}
