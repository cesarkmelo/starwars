import 'package:flutter/material.dart';
import 'package:starwars/constants.dart';

class LoadingError extends StatelessWidget {
  final String? message;

  const LoadingError({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message!,
          style: kStyleError,
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}
