import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/components/school_toolkit_card/school_toolkit_card.dart';
import 'package:medapp/components/utils/screen_size.dart';

class SchoolToolkitRoleButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool selected;

  const SchoolToolkitRoleButton({
    Key key,
    this.label,
    @required this.iconData,
    this.selected = false,
  })  : assert(iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(
          ScreenSize.width,
          ScreenSize.height,
        ),
        allowFontScaling: true,
      );
    }

    return SchoolToolkitCard(
      width: ScreenUtil().setWidth(177),
      height: ScreenUtil().setHeight(120),
      active: selected,
      alignment: Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: Duration(
          milliseconds: 300,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: selected ? 0.3 : 1.0,
              child: Container(
                width: ScreenUtil().setWidth(48),
                height: ScreenUtil().setWidth(48),
                decoration: BoxDecoration(
                  color: selected ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(10),
                  ),
                ),
                child: Icon(
                  iconData,
                  color: selected ? Colors.white : SchoolToolkitColors.blue,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(6),
            ),
            Text(
              '$label',
              style: TextStyle(
                color: selected ? Colors.white : SchoolToolkitColors.blue,
                fontSize: FontSize.fontSize16,
                fontWeight: FontSize.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
