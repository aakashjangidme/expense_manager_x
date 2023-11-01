import 'dart:developer';

import 'package:flutter/material.dart';

class DisplayErrorMessage extends StatelessWidget {
  final String? errorMessage;
  final StackTrace? st;

  const DisplayErrorMessage({super.key, this.errorMessage, this.st});

  @override
  Widget build(BuildContext context) {
    log("DisplayErrorMessage::\n${st.toString()}");
    return Center(
      child: Text(errorMessage ?? "Something went wrong."),
    );
  }
}
