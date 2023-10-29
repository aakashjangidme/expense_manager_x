import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimatedTextSwitcherForCurrency extends StatelessWidget {
  const AnimatedTextSwitcherForCurrency(this.text,
      {super.key, required this.style});

  final double text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedNumberText(
      text, // int or double
      curve: Curves.easeIn,
      duration: const Duration(seconds: 1),
      style: style,
      formatter: (value) {
        final formatted = NumberFormat.currency(
          name: "INR",
          locale: 'en_IN',
          decimalDigits: 2,
          symbol: '₹ ',
        ).format(value);
        return formatted;
      },
    );
    /*

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
                  begin: const Offset(0.0, -0.5), end: const Offset(0.0, 0.0))
              .animate(animation),
          child: child,
        );
      },
      child: Text(
        text,
        key: ValueKey<String>(text),
        style: style,
      ),
    );
    */
  }
}
