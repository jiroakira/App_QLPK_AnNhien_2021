import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomProfileItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final Function onTap;
  final String buttonTitle;
  final String subTitle2;

  const CustomProfileItem({
    Key key,
    this.imagePath,
    @required this.title,
    @required this.subTitle,
    @required this.onTap,
    @required this.buttonTitle,
    this.subTitle2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: InkWell(
                      onTap: onTap,
                      child: Text(
                        buttonTitle,
                        style: Theme.of(context).textTheme.button.copyWith(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
