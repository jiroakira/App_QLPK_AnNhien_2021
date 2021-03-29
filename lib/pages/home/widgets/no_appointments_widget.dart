import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../utils/constants.dart';

class NoAppointmentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/icon_no_appointments.png'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Bạn Không Có Lịch Hẹn Nào Mới'.tr(),
            style: TextStyle(
              color: kColorDarkBlue,
              fontSize: 20,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Thêm Lịch Hẹn Mới'.tr(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: Icon(
              Icons.arrow_downward,
              color: kColorBlue,
            ),
          ),
        ],
      ),
    );
  }
}
