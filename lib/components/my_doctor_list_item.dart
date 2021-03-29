import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/model/user/doctor.dart';
import 'package:medapp/routes/routes.dart';

import '../model/doctor.dart';
import 'custom_button.dart';

class MyDoctorListItem extends StatelessWidget {
  // final Doctor doctor;
  final Data listDoctorBody;

  const MyDoctorListItem({Key key, @required this.listDoctorBody}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: <Widget>[
            // Image.asset(
            //   listDoctorBody.,
            //   width: 60,
            //   height: 60,
            // ),
            SizedBox(
              width: ScreenUtil().setWidth(20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    listDoctorBody.user.hoTen,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    listDoctorBody.user.soDienThoai + '\n',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            CustomButton(
              text: 'Chi Tiết',
              textSize: 14,
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.doctorProfileDetail, arguments: listDoctorBody);
              },
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
