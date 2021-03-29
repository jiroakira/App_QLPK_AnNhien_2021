import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../components/round_icon_button.dart';
import '../../data/pref_manager.dart';
import '../../routes/routes.dart';
import '../../utils/constants.dart';
import '../examination/examination_page.dart';
import '../prescription/prescription_page.dart';
import '../test/test_page.dart';
import '../visit/visit_page.dart';
import 'package:medapp/model/token/token.dart';

class ProfilePage extends StatefulWidget {
  final ResponseTokenBody responseTokenBody;

  const ProfilePage({Key key, this.responseTokenBody}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  final _kTabTextStyle = TextStyle(
    color: kColorBlue,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  final _kTabPages = [
    TestPage(),
    VisitPage(),
    PrescriptionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool _isdark = Prefs.isDark();

    var _kTabs = [
      Tab(
        text: 'Lịch Trình Khám'.tr(),
        // NOTE: Lịch trình khám mới nhất tại thời điểm bác sĩ phân khoa
      ),
      // Tab(
      //   text: 'Kiểm Tra'.tr(),
      // ),
      Tab(
        text: 'Kết Quả Khám'.tr(),
        // NOTE: Kết quả khám mới nhất tại thời điểm bệnh nhân ở tại phòng khám
      ),
      Tab(
        text: 'Đơn Thuốc Mới'.tr(),
        // NOTE: Đơn thuốc mới tại thời điểm bác sĩ kê đơn
      ),

      // NOTE: Phần đơn thuốc mới sẽ hiển thị ra đơn thuốc mà bác sĩ vừa kê đơn, để họ check với đơn thuốc ở quầy thuốc
      // NOte: hiển thị ra danh sách các thuốc, kết hợp với tổng tiền

      // NOTE: phần tab view trong profile_page sẽ theo trình tự: Lịch Hẹn - Lịch Trình Khám - Kết Quả Khám - Đơn Thuóco
    ];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          //color: Colors.white,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.transparent,
                // backgroundImage: AssetImage(),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.responseTokenBody.userData.hoTen,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    // Text(
                    //   widget.responseTokenBody.userData.soDienThoai,
                    //   style: TextStyle(
                    //     color: Colors.grey[350],
                    //     fontSize: 12,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      widget.responseTokenBody.userData.soDienThoai,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              RoundIconButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.editProfile),
                icon: Icons.edit,
                size: 40,
                color: kColorBlue,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: DefaultTabController(
            length: _kTabs.length,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _isdark ? kColorDark : Color(0xfffbfcff),
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: _isdark ? Colors.black87 : Colors.grey[200],
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: _isdark ? Colors.black87 : Colors.grey[200],
                      ),
                    ),
                  ),
                  child: TabBar(
                    indicatorColor: kColorBlue,
                    labelStyle: _kTabTextStyle,
                    unselectedLabelStyle: _kTabTextStyle.copyWith(color: Colors.grey),
                    labelColor: kColorBlue,
                    unselectedLabelColor: Colors.grey,
                    tabs: _kTabs,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: _kTabPages,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
