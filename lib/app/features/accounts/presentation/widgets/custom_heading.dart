
import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  const CustomHeading(
      this.text, {
        super.key,
      });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
