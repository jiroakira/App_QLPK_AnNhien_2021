import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Center(
            child: SpinKitThreeBounce(
              color: Colors.blue,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
