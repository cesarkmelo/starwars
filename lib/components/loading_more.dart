import 'package:flutter/cupertino.dart';
import 'package:starwars/constants.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CupertinoActivityIndicator(),
        SizedBox(
          height: 40,
          width: 10,
        ),
        Text(
          'Loading',
          style: kStyleLightGray,
        ),
      ],
    );
  }
}
