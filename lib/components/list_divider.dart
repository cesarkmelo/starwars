import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Divider(color: Colors.grey),
    );
  }
}
