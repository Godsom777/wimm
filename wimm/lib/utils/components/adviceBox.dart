import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wimm/main.dart';
import 'package:wimm/utils/local_providers.dart';

class AdviceBox extends StatefulWidget {
  const AdviceBox({super.key});

  @override
  _AdviceBoxState createState() => _AdviceBoxState();
}

class _AdviceBoxState extends State<AdviceBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  final List<String> adviceList = [
      'Save money for a rainy day because unexpected expenses can arise at any time, and having a financial cushion can provide peace of mind.',
      'Invest in your future by setting aside a portion of your income for long-term goals such as education, home ownership, or starting a business.',
      'Don\'t spend more than you earn to avoid falling into debt and to ensure that you can live within your means comfortably.',
      'Budget your expenses carefully to track your spending habits and identify areas where you can cut costs and save more money.',
      'Save for retirement early to take advantage of compound interest and ensure that you have enough funds to live comfortably in your later years.',
       'Don\'t buy things you don\'t need, as impulse purchases can quickly add up and derail your financial goals.',
    'Create an emergency fund to cover unexpected expenses such as medical bills, car repairs, or job loss, so you don’t have to rely on credit.',
    'Pay off your high-interest debts first to reduce the amount of interest you pay over time and to free up more money for savings and investments.',
    'Review your financial goals regularly to ensure that you are on track and make adjustments as needed to stay aligned with your objectives.',
    'Consider consulting with a financial advisor to get personalized advice and strategies for managing your money and achieving your financial goals.',
  ];



  @override
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: themeProvider.currentTheme!.primaryColor,
      end: themeProvider.currentTheme!.hintColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: _animation.value!,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.lightbulb_fill, color: _animation.value),
                      Text(
                    'Advice of the day',
                    style:  Provider.of<ScreenSizeProvider>(context)
                        .textStyleSmallBold,
                  ),
                  ],
                ),
                
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    adviceList[DateTime.now().day % adviceList.length],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 10),
              
                        
              ],
            ),
          ),
        );
      },
    );
  }
}