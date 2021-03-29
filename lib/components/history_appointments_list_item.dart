import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'package:medapp/model/appointment/all_visit.dart';

class HistoryAppointmentListItem extends StatelessWidget {
  final Past past;

  const HistoryAppointmentListItem({Key key, this.past}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Ngày'.tr(),
                          subtitle: DateFormat("dd-MM-yyyy").format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(past.thoiGianBatDau)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Thời Gian',
                          subtitle: DateFormat("hh:mm:ss").format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(past.thoiGianBatDau)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CustomButton(
                  text: 'Đặt Lịch',
                  textSize: 14,
                  onPressed: () {},
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
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
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Người Phụ Trách',
                          subtitle: past.nguoiPhuTrach != null ? past.nguoiPhuTrach.hoTen : "",
                        ),
                      ),
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'Trạng Thái',
                          subtitle: past.trangThai.tenTrangThai,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: false,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child: CustomButton(
                    text: 'Hẹn Lại',
                    textSize: 14,
                    onPressed: () {},
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
