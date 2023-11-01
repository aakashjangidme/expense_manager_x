import 'package:flutter/material.dart';

class FullWidthElevatedTextButton extends StatelessWidget {
  const FullWidthElevatedTextButton(
    this.text, {
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: theme.textTheme.titleMedium,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        minimumSize: const Size(double.infinity, double.minPositive),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class FullWidthTextButton extends StatelessWidget {
  const FullWidthTextButton(
    this.text, {
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      style: TextButton.styleFrom(
        textStyle: theme.textTheme.titleMedium,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        minimumSize: const Size(double.infinity, double.minPositive),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
