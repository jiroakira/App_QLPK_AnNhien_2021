import 'package:flutter/material.dart';

import '../../../data/pref_manager.dart';
import '../../../utils/constants.dart';

class NavBarItemWidget extends StatelessWidget {
  final Function onTap;
  final String image;
  final bool isSelected;
  final String title;

  const NavBarItemWidget({
    Key key,
    @required this.onTap,
    @required this.image,
    @required this.isSelected,
    this.title,
  }) : super(key: key);

  Color get _color => isSelected
      ? kColorPrimary
      : Prefs.isDark()
          ? Colors.grey[800]
          : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Center(
              child: image.isEmpty
                  ? Container()
                  : Image.asset(
                      'assets/images/$image.png',
                      height: 25,
                      color: _color,
                    ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
