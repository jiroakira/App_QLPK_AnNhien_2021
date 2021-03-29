import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_wave_clipper_header.dart';

class WaveHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const WaveHeader({Key key, @required this.title, this.subtitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = new Size(MediaQuery.of(context).size.width, 350);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(
      context,
      designSize: Size(width, height),
      allowFontScaling: true,
    );
    return Container(
      height: ScreenUtil().setHeight(350),
      child: Stack(
        children: <Widget>[
          CustomWaveClipperHeader(
            size: size,
            xOffset: 0,
            yOffset: 0,
          ),
          CustomWaveClipperHeader(
            size: size,
            xOffset: 50,
            yOffset: 10,
            duration: 1500,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Image(
                //   image: AssetImage(
                //     'assets/images/logo03.png',

                //   ),
                // ),
                Image.asset(
                  'assets/images/logo03.png',
                  height: ScreenUtil().setHeight(100),
                  width: ScreenUtil().setWidth(100),
                  // color: Colors.black,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
