import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/upcoming_appointment_list_item.dart';

import 'package:medapp/bloc/appointment/appointment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingAppointmentsPage extends StatefulWidget {
  @override
  _UpcomingAppointmentsPageState createState() => _UpcomingAppointmentsPageState();
}

class _UpcomingAppointmentsPageState extends State<UpcomingAppointmentsPage> {
  final AllVisitBloc allVisitBloc = AllVisitBloc();

  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allVisitBloc.add(GetAllVisit());
  }

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
    return BlocProvider(
      create: (context) => allVisitBloc,
      child: BlocBuilder<AllVisitBloc, AppointmentState>(
        builder: (context, state) {
          if (state is AllVisitLoading) {
            _timer?.cancel();
            EasyLoading.show(
              status: 'Đang tải...',
            );
          }
          if (state is AllVisitLoaded) {
            if (state.allVisitModel.upcoming.length != 0) {
              _timer?.cancel();
              EasyLoading.dismiss();
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                itemCount: state.allVisitModel.upcoming.length,
                padding: EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 15,
                ),
                itemBuilder: (context, index) {
                  final item = state.allVisitModel.upcoming[index];
                  return UpcomingAppointmentListItem(
                    upcoming: item,
                  );
                },
              );
            } else {
              _timer?.cancel();
              EasyLoading.dismiss();
              return Center(
                child: Text("Bạn Không Có Lịch Hẹn Sắp Tới"),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
