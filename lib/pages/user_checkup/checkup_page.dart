import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medapp/bloc/checkup_process.dart/checkup_process_bloc.dart';
import 'package:medapp/components/event_card/event_card.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/checkup_process/process.dart';
import 'package:medapp/pages/user_checkup/my_checkup.dart';
import 'package:medapp/routes/routes.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// class CheckupProgressPage extends StatefulWidget {
//   CheckupProgressPage({Key key}) : super(key: key);

//   @override
//   _CheckupProgressPageState createState() => _CheckupProgressPageState();
// }

// class _CheckupProgressPageState extends State<CheckupProgressPage> {
//   final CheckupProcessBloc _checkupProcessBloc = CheckupProcessBloc();
//   WebSocketChannel channel;
//   final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

//   final controller = ScrollController();
//   double offset = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _checkupProcessBloc.add(GetCheckupProcesses());
//     final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
//     channel = IOWebSocketChannel.connect(WS_URL + "ws/checkup_process/$userId/");
//     controller.addListener(onScroll);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.dispose();
//     super.dispose();
//   }

//   void onScroll() {
//     setState(() {
//       offset = (controller.hasClients) ? controller.offset : 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       controller: controller,
//       child: BlocProvider(
//         create: (context) => _checkupProcessBloc,
//         child: BlocBuilder<CheckupProcessBloc, CheckupProcessState>(
//           builder: (context, state) {
//             if (state is CheckupProcessLoading) {
//               return Container(
//                 height: MediaQuery.of(context).size.height * .7,
//                 alignment: Alignment.center,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//             if (state is CheckupProcessLoaded) {
//               if (state.checkupProcessModel.data.isNotEmpty) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Column(
//                     children: <Widget>[
//                       for (var i in state.checkupProcessModel.data)
//                         i.trangThai == null
//                             ? EventCard(
//                                 checkupProcessBody: i,
//                                 statusColor: Colors.grey[200],
//                                 textColor: Colors.black,
//                                 statusColor2: Colors.grey[500],
//                               )
//                             : i.trangThai.trangThaiKhoaKham == 'Đang Thực Hiện'
//                                 ? EventCard(
//                                     checkupProcessBody: i,
//                                     statusColor: Color(0xFFffefa0),
//                                     textColor: Colors.black,
//                                     statusColor2: Colors.orangeAccent,
//                                   )
//                                 : i.trangThai.trangThaiKhoaKham == 'Hoàn Thành'
//                                     ? EventCard(
//                                         checkupProcessBody: i,
//                                         statusColor: Color(0xFFc2f0fc),
//                                         textColor: Colors.black,
//                                         statusColor2: Colors.greenAccent,
//                                       )
//                                     : i.trangThai.trangThaiKhoaKham == null
//                                         ? EventCard(
//                                             checkupProcessBody: i,
//                                             statusColor: Colors.grey[200],
//                                             statusColor2: Colors.grey[500],
//                                           )
//                                         : EventCard(
//                                             checkupProcessBody: i,
//                                             statusColor: Colors.grey[200],
//                                             statusColor2: Colors.grey[500],
//                                           )
//                     ],
//                   ),
//                 );
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Center(
//                     child: Text("Bạn Không Có Tiến Trình Khám Nào"),
//                   ),
//                 );
//               }
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

class CheckupProgressPage extends StatefulWidget {
  CheckupProgressPage({Key key}) : super(key: key);

  @override
  _CheckupProgressPageState createState() => _CheckupProgressPageState();
}

class _CheckupProgressPageState extends State<CheckupProgressPage> {
  WebSocketChannel channel;
  WebSocketChannel channel2;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();
  var sub2;
  Timer _timer;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);

    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
    channel = IOWebSocketChannel.connect(WS_URL + "ws/checkup_process/$userId/");

    channel2 = IOWebSocketChannel.connect(WS_URL + "ws/checkup_process_notification/$userId/");
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings).then(
      (done) {
        sub2 = channel2.stream.listen(
          (data) {
            print(data);
            _showNotification2(data);
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

  Future<void> _showNotification2(String data) async {
    final android = AndroidNotificationDetails(
      'channel id 3',
      'channel name 3',
      'channel description 3',
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
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: StreamBuilder(
        stream: channel.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            _timer?.cancel();
            EasyLoading.show(
              status: 'Đang tải...',
            );
          }
          if (snapshot.hasData) {
            _timer?.cancel();
            EasyLoading.dismiss();
            // print(snapshot.data);
            // print(snapshot.data.runtimeType);
            Map<String, dynamic> map = json.decode(snapshot.data);
            List<dynamic> _data = map['data'];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _data.length != 0
                  ? Column(
                      children: <Widget>[
                        for (var i in _data)
                          i['trang_thai'] == null
                              ? EventCard(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(Routes.funcroomInfo, arguments: i['dich_vu_kham']['id'].toString());
                                  },
                                  checkupProcessBody: i,
                                  statusColor: Colors.grey[200],
                                  textColor: Colors.black,
                                  statusColor2: Colors.grey[500],
                                )
                              : i['trang_thai']['trang_thai_khoa_kham'] == 'Đang Thực Hiện'
                                  ? EventCard(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(Routes.funcroomInfo, arguments: i['dich_vu_kham']['id'].toString());
                                      },
                                      checkupProcessBody: i,
                                      statusColor: Color(0xFFffefa0),
                                      textColor: Colors.black,
                                      statusColor2: Colors.orangeAccent,
                                    )
                                  : i['trang_thai']['trang_thai_khoa_kham'] == 'Hoàn Thành'
                                      ? EventCard(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(Routes.funcroomInfo, arguments: i['dich_vu_kham']['id'].toString());
                                          },
                                          checkupProcessBody: i,
                                          statusColor: Color(0xFFc2f0fc),
                                          textColor: Colors.black,
                                          statusColor2: Colors.greenAccent,
                                        )
                                      : i['trang_thai']['trang_thai_khoa_kham'] == null
                                          ? EventCard(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(Routes.funcroomInfo, arguments: i['dich_vu_kham']['id'].toString());
                                              },
                                              checkupProcessBody: i,
                                              statusColor: Colors.grey[200],
                                              statusColor2: Colors.grey[500],
                                            )
                                          : EventCard(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(Routes.funcroomInfo, arguments: i['dich_vu_kham']['id'].toString());
                                              },
                                              checkupProcessBody: i,
                                              statusColor: Colors.grey[200],
                                              statusColor2: Colors.grey[500],
                                            )
                      ],
                    )
                  : Center(
                      child: Text("Bạn Không Có Tiến Trình Khám Nào"),
                    ),
            );
          } else {
            return Center(
                // child: Text("Bạn Không Có Tiến Trình Khám Nào"),
                );
          }
        },
      ),
    );
  }
}
