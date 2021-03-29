import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/utils/const.dart';

class CardResult extends StatelessWidget {
  final String title;
  final Color color;
  final String value;
  final String unit;
  final String standard;
  final String judment;
  const CardResult({
    Key key,
    this.color,
    this.title,
    this.value,
    this.unit,
    this.standard,
    this.judment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(
          width,
          height,
        ),
        allowFontScaling: true,
      );
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: color,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    color: Constants.textDark,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w900,
                        color: Constants.textDark,
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5),
                    ),
                    Expanded(
                      child: Text(
                        unit,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w900,
                          color: Constants.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(5)),
                Text(
                  standard,
                  style: TextStyle(
                    fontSize: 17,
                    color: Constants.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                judment,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                  fontWeight: FontWeight.w900,
                  color: Constants.lightAccent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
