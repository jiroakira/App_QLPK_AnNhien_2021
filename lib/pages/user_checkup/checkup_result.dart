import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/checkup_process.dart/latest_checkup.dart';
import 'package:medapp/pages/home/widgets/next_appointment_widget.dart';
import 'package:medapp/routes/routes.dart';
import 'package:intl/intl.dart';

class CheckupResultPage extends StatefulWidget {
  CheckupResultPage({Key key}) : super(key: key);

  @override
  _CheckupResultPageState createState() => _CheckupResultPageState();
}

class _CheckupResultPageState extends State<CheckupResultPage> {
  final LatestCheckupBloc _latestCheckupBloc = LatestCheckupBloc();
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _latestCheckupBloc.add(GetLatestCheckupProcess());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => _latestCheckupBloc,
        child: BlocBuilder<LatestCheckupBloc, LatestCheckupState>(
          builder: (context, state) {
            if (state is LatestCheckupLoading) {
              _timer?.cancel();
              EasyLoading.show(
                status: 'Đang tải...',
              );
            }
            if (state is LatestCheckupEmpty) {
              _timer?.cancel();
              EasyLoading.dismiss();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text("Bạn Chưa Có Kết Quả Khám"),
                ),
              );
            }
            if (state is LatestCheckupLoaded) {
              _timer?.cancel();
              EasyLoading.dismiss();
              if (state.latestCheckupProcessBody.data != '') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          // print(i.id);

                          Navigator.of(context).pushNamed(Routes.latestVisitDetail, arguments: state.latestCheckupProcessBody.data.id.toString());
                        },
                        child: NextAppointmentWidget(
                          time: state.latestCheckupProcessBody.data.thoiGianBatDau != null
                              ? '${DateFormat("dd-MM-yyyy | hh:mm").format(DateFormat("yyyy-MM-ddThh:mm:ss").parse(state.latestCheckupProcessBody.data.thoiGianBatDau))}'
                              : "Chưa Có Thời Gian Bắt Đầu",
                          doctor: "Bác Sĩ: " + state.latestCheckupProcessBody.data.bacSiDamNhan.hoTen,
                          patient: "Mã Chuỗi Khám: ${state.latestCheckupProcessBody.data.id}",
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Bạn Chưa Có Kết Quả Khám'),
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

// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         child: Text(
//           "Kết Quả Khám Tổng Quát",
//           style: TextStyle(
//             fontSize: FontSize.fontSize22,
//             fontWeight: FontSize.bold,
//           ),
//         ),
//       ),
//       SizedBox(
//         height: ScreenUtil().setHeight(10),
//       ),
//       Container(
//         child: Text(
//           "Mã Kết Quả",
//           style: TextStyle(
//             fontSize: FontSize.fontSize15,
//             fontWeight: FontSize.bold,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 20),
//   child: Container(
//     padding: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: Colors.grey[100],
//     ),
//     child: Text(
//       "Mã Kết Quả Khám Của Bệnh Nhân",
//       style: TextStyle(
//         fontSize: FontSize.fontSize18,
//         fontWeight: FontSize.semiBold,
//       ),
//     ),
//   ),
// ),
// SizedBox(
//   height: ScreenUtil().setHeight(10),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 20),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Container(
//         child: Text(
//           "Mô Tả",
//           style: TextStyle(
//             fontSize: FontSize.fontSize15,
//             fontWeight: FontSize.bold,
//           ),
//         ),
//       ),
//       SizedBox(
//         height: ScreenUtil().setHeight(10),
//       ),
//       Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.grey[100],
//         ),
//         child: Text(
//           "Mô Tả Kết Quả Khám Tổng Quát Của Bệnh Nhân",
//           style: TextStyle(
//             fontSize: FontSize.fontSize18,
//             fontWeight: FontSize.semiBold,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: ScreenUtil().setHeight(10),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 20),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Container(
//         child: Text(
//           "Kết Luận",
//           style: TextStyle(
//             fontSize: FontSize.fontSize15,
//             fontWeight: FontSize.bold,
//           ),
//         ),
//       ),
//       SizedBox(
//         height: ScreenUtil().setHeight(10),
//       ),
//       Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.grey[100],
//         ),
//         child: Text(
//           "Kết Luận Kết Quả Khám Tổng Quát Của Bệnh Nhân \nKết Luận Kết Quả Khám Tổng Quát Của Bệnh Nhân \nKết Luận Kết Quả Khám Tổng Quát Của Bệnh Nhân",
//           style: TextStyle(
//             fontSize: FontSize.fontSize18,
//             fontWeight: FontSize.semiBold,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: ScreenUtil().setHeight(10),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 20),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Container(
//         child: Text(
//           "File Kết Quả Tổng Quát",
//           style: TextStyle(
//             fontSize: FontSize.fontSize15,
//             fontWeight: FontSize.bold,
//           ),
//         ),
//       ),
//       SizedBox(
//         height: ScreenUtil().setHeight(10),
//       ),
//       Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.grey[100],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 "File Kết Quả Khám Tổng Quát",
//                 style: TextStyle(
//                   fontSize: FontSize.fontSize18,
//                   fontWeight: FontSize.semiBold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//             FlatButton(
//               onPressed: () {},
//               child: Icon(
//                 Icons.download_sharp,
//                 color: Colors.blue,
//               ),
//             )
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         child: Text(
//           "Danh Sách Kết Quả Khám Chuyên Khoa",
//           style: TextStyle(
//             fontSize: FontSize.fontSize22,
//             fontWeight: FontSize.bold,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: ScreenUtil().setHeight(10),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(
//     horizontal: 20,
//   ),
//   child: AssignmentCard(
//     question: "Mã Kết Quả",
//     subject: "Mô Tả",
//     teacher: "Kết Luận",
//     fileList: [
//       FileWrapper(
//         fileName: "Kết Quả Chuyên Khoa",
//         fileSize: 'ketquachuyenkhoa.pdf',
//         onTap: () {},
//       ),
//     ],
//   ),
// ),
