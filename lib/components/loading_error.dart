import 'package:flutter/material.dart';
import 'package:starwars/constants.dart';

class LoadingError extends StatelessWidget {
  const LoadingError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Failed to Load Data',
          style: kStyleError,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
