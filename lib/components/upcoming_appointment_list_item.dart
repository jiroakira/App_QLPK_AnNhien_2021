import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/routes/routes.dart';

import 'custom_button.dart';
import 'custom_outline_button.dart';
import 'package:medapp/model/appointment/all_visit.dart';

class UpcomingAppointmentListItem extends StatelessWidget {
  final Upcoming upcoming;

  const UpcomingAppointmentListItem({Key key, this.upcoming}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Ngày',
                          subtitle: DateFormat("dd-MM-yyyy").format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(upcoming.thoiGianBatDau)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Thời Gian',
                          subtitle: DateFormat("hh:mm:ss").format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(upcoming.thoiGianBatDau)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Người Phụ Trách',
                          subtitle: upcoming.nguoiPhuTrach != null ? upcoming.nguoiPhuTrach.hoTen : "",
                        ),
                      ),
                      Expanded(
                        child: _buildStatus1(
                          context: context,
                          title: 'Trạng Thái',
                          subtitle: upcoming.trangThai.tenTrangThai,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Chỉnh Sửa',
                      textSize: 14,
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.newUpdateBookingPage, arguments: upcoming);
                      },
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomOutlineButton(
                      text: 'Hủy',
                      textSize: 14,
                      onPressed: () {},
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildColumn({
    @required BuildContext context,
    @required String title,
    @required subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Column _buildStatus1({
    @required BuildContext context,
    @required String title,
    @required subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.amber.withOpacity(0.3),
          ),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: FontSize.fontSize15,
              fontWeight: FontSize.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildStatus2({
    @required BuildContext context,
    @required String title,
    @required subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue.withOpacity(0.3),
          ),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: FontSize.fontSize15,
              fontWeight: FontSize.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
