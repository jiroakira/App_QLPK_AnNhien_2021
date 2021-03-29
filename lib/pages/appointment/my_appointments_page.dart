import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants.dart';
import 'history_appointments_page.dart';
import 'upcoming_appointments_page.dart';

class MyAppointmentsPage extends StatefulWidget {
  @override
  _MyAppointmentsPageState createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  static const _kTabTextStyle = TextStyle(
    color: kColorPrimaryDark,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  static const _kUnselectedTabTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  final _kTabPages = [
    UpcomingAppointmentsPage(),
    HistoryAppointmentsPage(),
  ];

  final _kTabs = [
    Tab(
      text: 'Sắp Tới',
    ),
    Tab(
      text: 'Lịch Sử',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(
      context,
      designSize: Size(
        width,
        height,
      ),
      allowFontScaling: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Tất Cả Lịch Hẹn'.tr()),
        elevation: 0,
      ),
      body: DefaultTabController(
        length: _kTabs.length,
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: kColorPrimary,
              labelStyle: _kTabTextStyle,
              unselectedLabelStyle: _kUnselectedTabTextStyle,
              labelColor: kColorPrimary,
              unselectedLabelColor: Colors.grey,
              tabs: _kTabs,
            ),
            Expanded(
              child: TabBarView(
                children: _kTabPages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
