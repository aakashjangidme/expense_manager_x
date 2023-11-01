import 'package:flutter/material.dart';

class MarginX extends StatelessWidget {
  const MarginX(this.width, {super.key});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width ?? 16.0);
  }
}

class MarginY extends StatelessWidget {
  const MarginY(this.height, {super.key});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? 16.0);
  }
}
