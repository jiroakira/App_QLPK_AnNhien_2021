import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/model/screen_args.dart';

import '../../routes/routes.dart';
import 'package:medapp/bloc/list_examinations.dart/examination_bloc.dart';
import 'package:medapp/pages/home/widgets/widgets.dart';

class VisitPage extends StatefulWidget {
  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> with AutomaticKeepAliveClientMixin<VisitPage> {
  final ListExaminationBloc _listExaminationBloc = ListExaminationBloc();
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listExaminationBloc.add(GetListExaminations());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(
          width,
          height,
        ),
        allowFontScaling: true,
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Danh Sách Các Kết Quả Khám",
          style: TextStyle(
            fontSize: FontSize.fontSize18,
            fontWeight: FontSize.semiBold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => _listExaminationBloc,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: BlocBuilder<ListExaminationBloc, ExaminationsState>(builder: (context, state) {
              if (state is ListExaminationLoading) {
                _timer?.cancel();
                EasyLoading.show(
                  status: 'Đang tải...',
                );
              }

              if (state is ListExaminationLoaded) {
                _timer?.cancel();
                EasyLoading.dismiss();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var i in state.listExaminationsBody.data)
                      if (i.chuoiKham.length != 0)
                        InkWell(
                          onTap: () {
                            print(i.id);

                            Navigator.of(context).pushNamed(
                              Routes.visitDetail,
                              arguments: ScreenArguments(
                                i.chuoiKham[0].id,
                                i.id,
                              ),
                            );
                          },
                          child: NextAppointmentWidget(
                            time: i.thoiGianBatDau,
                            doctor: i.chuoiKham[0].bacSiDamNhan != null ? "Bác Sĩ: " + i.chuoiKham[0].bacSiDamNhan.hoTen : "Bác sĩ: Không có",
                            patient: "Thứ Tự Chuỗi Khám: ${i.chuoiKham[0].id}",
                          ),
                        ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                  ],
                );
              } else if (state is ListExaminationEmpty) {
                return Center(
                  child: Text("Bạn Chưa Có Lịch Hẹn Nào"),
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class VisitItem extends StatelessWidget {
  final String date;
  final String time;
  final Widget child;

  const VisitItem({Key key, @required this.date, @required this.time, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              date,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
