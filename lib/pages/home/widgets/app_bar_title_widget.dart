import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../utils/constants.dart';

class AppBarTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(
      context,
      designSize: Size(width, height),
      allowFontScaling: true,
    );

    return AutoSizeText(
      "ỨNG DỤNG QUẢN LÝ PHÒNG KHÁM MEDOTIS",
      style: TextStyle(
        fontSize: ScreenUtil().setSp(22),
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      maxLines: 1,
    );
  }
}
