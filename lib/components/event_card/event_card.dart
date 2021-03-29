import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/components/school_toolkit_card/school_toolkit_card.dart';
import 'package:medapp/model/checkup_process/process.dart';
// import 'package:medapp/components/utils/screen_size.dart';

class EventCard extends StatelessWidget {
  final double width;
  final double height;
  final String time;
  final String event;
  final Color primaryColor;
  final Color secondaryColor;
  final Color thirdColor;
  final Color statusColor;
  final Color textColor;
  final Color statusColor2;
  final Function onPressed;

  final dynamic checkupProcessBody;

  const EventCard({
    Key key,
    this.width,
    this.height,
    this.time,
    this.event,
    this.primaryColor = SchoolToolkitColors.brown,
    this.secondaryColor = SchoolToolkitColors.lightBrown,
    this.thirdColor = SchoolToolkitColors.tealGreen,
    this.checkupProcessBody,
    this.statusColor,
    this.textColor,
    this.statusColor2,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (ScreenUtil() == null) {
    //   ScreenUtil.init(
    //     context,
    //     designSize: Size(
    //       ScreenSize.width,
    //       ScreenSize.height,
    //     ),
    //     allowFontScaling: true,
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          // height: 100,
          width: 450,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: statusColor,
          ),
          child: Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(50),
                height: ScreenUtil().setHeight(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    checkupProcessBody['priority'].toString(),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checkupProcessBody['dich_vu_kham']['phong_chuc_nang']['ten_phong_chuc_nang'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Text(
                      checkupProcessBody['dich_vu_kham']['ten_dvkt'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(150),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: ScreenUtil().setHeight(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: statusColor2,
                      ),
                      child: Center(
                        child: Text(
                          checkupProcessBody['trang_thai'] != null ? checkupProcessBody['trang_thai']['trang_thai_khoa_kham'] : 'Đang Chờ',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
