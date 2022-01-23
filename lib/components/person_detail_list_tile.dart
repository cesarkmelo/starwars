import 'package:flutter/material.dart';
import 'package:starwars/constants.dart';

class DetailPersonListTile extends StatelessWidget {
  final String label;
  final String value;

  const DetailPersonListTile({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: ListTile(
        leading: Text(
          label,
          style: kStyleLightGray,
        ),
        trailing: Text(
          value,
          style: kStyleDarkGray,
        ),
      ),
    );
  }
}
