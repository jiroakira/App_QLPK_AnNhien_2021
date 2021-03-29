import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/prescription/prescription_bloc.dart';
import 'package:medapp/components/custom_profile_item.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/pages/user_checkup/my_checkup.dart';
import 'package:medapp/routes/routes.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CheckupPrescriptionPage extends StatefulWidget {
  CheckupPrescriptionPage({Key key}) : super(key: key);

  @override
  _CheckupPrescriptionPageState createState() => _CheckupPrescriptionPageState();
}

class _CheckupPrescriptionPageState extends State<CheckupPrescriptionPage> {
  final LatestPrescriptionBloc latestPrescriptionBloc = LatestPrescriptionBloc();
  WebSocketChannel channel3;
  var sub3;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  Timer _timer;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    latestPrescriptionBloc.add(GetLatestPrescription());
    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
    channel3 = IOWebSocketChannel.connect(WS_URL + "ws/prescription_noti/$userId/");

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings).then(
      (done) {
        sub3 = channel3.stream.listen(
          (data) {
            print(data);
            _showNotification3(data);
          },
        );
      },
    );
  }

  Future<void> _onSelectNotification(String json) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCheckupProcess(),
      ),
    );
  }

  Future<void> _showNotification3(String data) async {
    final android = AndroidNotificationDetails(
      'channel id 4',
      'channel name 4',
      'channel description 4',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: BigTextStyleInformation(''),
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonDecode(data);

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      json['title'],
      json['body'],
      platform,
      // payload: json,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => latestPrescriptionBloc,
        child: BlocBuilder<LatestPrescriptionBloc, PrescriptionState>(
          builder: (context, state) {
            if (state is LatestPrescriptionLoading) {
              _timer?.cancel();
              EasyLoading.show(
                status: 'Đang tải...',
              );
            }
            if (state is LatestPrescriptionEmpty) {
              _timer?.cancel();
              EasyLoading.dismiss();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Center(
                  child: Text("Bạn Không Có Danh Sách Thuốc"),
                ),
              );
            }
            if (state is LatestPrescriptionLoaded) {
              if (state.latestPrescription.data != '') {
                _timer?.cancel();
                EasyLoading.dismiss();
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomProfileItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.prescriptionDetail, arguments: state.latestPrescription.data.id.toString());
                        },
                        title: state.latestPrescription.data.maDonThuoc,
                        subTitle: "Mã Bệnh Nhân: ${state.latestPrescription.data.benhNhan}",
                        // subTitle2: i.id.toString(),
                        buttonTitle: 'Xem Thêm',
                        imagePath: 'assets/images/icon_medical_recipe.png',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // CustomProfileItem(
                      //   onTap: () {},
                      //   title: 'Tuberculosis Recipe',
                      //   subTitle: 'Jiro Akira',
                      //   subTitle2: 'Given at 14/02/2019',
                      //   buttonTitle: 'See Prescription',
                      //   imagePath: 'assets/images/icon_medical_recipe.png',
                      // ),
                    ],
                  ),
                );
              } else {
                _timer?.cancel();
                EasyLoading.dismiss();
                return Center(
                  child: Text('Bạn Không Có Danh Sách Thuốc'),
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
