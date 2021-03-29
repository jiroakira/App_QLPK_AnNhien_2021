import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../components/custom_button.dart';
import '../../utils/constants.dart';
import '../../data/pref_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/appointment/response_appointment.dart';
import 'package:medapp/bloc/appointment/request_appointment_bloc.dart';

class AppointmentDetailPage extends StatefulWidget {
  final ResponseAppointment responseAppointment;
  final String requestDateTime;

  const AppointmentDetailPage({Key key, this.requestDateTime, this.responseAppointment}) : super(key: key);

  @override
  _AppointmentDetailPageState createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  final bool _isdark = Prefs.isDark();

  @override
  void initState() {
    super.initState();
  }

  Color get _color => _isdark ? kColorDark : Colors.white;

  Widget dateAndTime() {
    return Container(
      width: double.infinity,
      color: _color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              'Thời Gian',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${DateFormat("dd-MM-yyyy hh:mm").format(DateFormat("yyyy-MM-ddThh:mm:ss").parse(widget.responseAppointment.lichHen.thoiGianBatDau)).toString()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   '${'in'.tr()} 13 ${'hours'.tr()}',
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget practiceDetail() {
    return Container(
      width: double.infinity,
      color: _color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Địa Điểm",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.responseAppointment.lichHen.diaDiem,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   'Tổ 12 Yên Nghĩa Hà Đông Hà Nội',
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "Chỉ Dẫn".toUpperCase(),
                style: TextStyle(
                  color: kColorBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget procedure() {
    return Container(
      width: double.infinity,
      color: _color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              'Lý Do',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.responseAppointment.lichHen.lyDo,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget type() {
    return Container(
      width: double.infinity,
      color: _color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              'Loại Dịch Vụ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.responseAppointment.lichHen.loaiDichVu == "kham_suc_khoe" ? "Khám Sức Khỏe" : "Khám Chữa Bệnh",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingDetails() {
    return Container(
      width: double.infinity,
      color: _color,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Đặt Lịch Cho",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.responseAppointment.benhNhan.hoTen,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                child: VerticalDivider(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mã Lịch Hẹn',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.responseAppointment.lichHen.id.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chi Tiết Lịch Hẹn',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: _isdark ? Colors.transparent : Colors.grey[300],
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocListener<RequestAppointmentBloc, RequestAppointmentState>(
                    listener: (context, state) {},
                    child: BlocBuilder<RequestAppointmentBloc, RequestAppointmentState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Container(
                            //   color: _isdark ? Colors.transparent : Colors.white,
                            //   child: DoctorItem1(
                            //     doctor: doctors[0],
                            //   ),
                            // ),
                            Divider(
                              color: _isdark ? Colors.black : Colors.grey[300],
                            ),
                            dateAndTime(),
                            Divider(),
                            practiceDetail(),
                            Divider(),
                            type(),
                            Divider(),
                            procedure(),
                            Divider(),
                            bookingDetails(),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Quản Lí Lịch Hẹn Của Bạn Tốt Hơn Bằng Việc Truy Cập ',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Lịch Hẹn',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CustomButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                text: 'Hoàn Thành',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
