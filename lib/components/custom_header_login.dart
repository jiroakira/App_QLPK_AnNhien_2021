import 'package:flutter/material.dart';

class CustomHeaderLogin extends StatefulWidget {
  CustomHeaderLogin({Key key}) : super(key: key);

  @override
  _CustomHeaderLoginState createState() => _CustomHeaderLoginState();
}

class _CustomHeaderLoginState extends State<CustomHeaderLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: MyClipper(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
