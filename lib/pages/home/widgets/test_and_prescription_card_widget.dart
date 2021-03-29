import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/components/utils/screen_size.dart';

class TestAndPrescriptionCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  const TestAndPrescriptionCardWidget({Key key, this.image, @required this.title, @required this.subTitle}) : super(key: key);
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/$image',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontSize.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
