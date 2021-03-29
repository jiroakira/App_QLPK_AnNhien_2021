import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/custom_clipper.dart';
import 'package:medapp/utils/const.dart';

class CardMain extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String standard;
  final Color color;
  final Function onTap;

  CardMain({Key key, @required this.title, @required this.value, @required this.unit, @required this.color, this.onTap, this.standard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        // width: ((MediaQuery.of(context).size.width - (Constants.paddingSide * 2 + Constants.paddingSide / 2)) / 2),
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: color,
        ),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black.withOpacity(0.03),
                      ),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Icon and Hearbeat
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Constants.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
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
                            Text(
                              unit,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w900,
                                color: Constants.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        standard,
                        style: TextStyle(
                          fontSize: 17,
                          color: Constants.textDark,
                        ),
                      ),
                      Text(
                        "danh gia",
                        style: TextStyle(
                          fontSize: 15,
                          color: Constants.textDark,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            onTap: onTap,
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
