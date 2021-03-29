import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medapp/components/custom_time_picker.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as date_picker;
import 'package:medapp/bloc/appointment/update_appt_bloc.dart';
import 'package:medapp/model/appointment/all_visit.dart';
import 'package:medapp/components/loaders/color_loader_5.dart';
import 'package:medapp/components/loaders/dot_type.dart';

class UpdateBookingPage extends StatefulWidget {
  final Upcoming upcoming;
  final String argument;
  UpdateBookingPage({
    Key key,
    this.argument,
    this.upcoming,
  }) : super(key: key);

  @override
  _UpdateBookingPageState createState() => _UpdateBookingPageState();
}

class _UpdateBookingPageState extends State<UpdateBookingPage> {
  DateTime selectedDate;
  DateTime _dateTime;
  DateTime firstDate;
  DateTime lastDate;
  String dateString;
  String timeString;
  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;
  String requestDateTime;
  DateTime tempDate;
  String loai_dich_vu;
  String dia_diem;
  String ly_do;

  Timer _timer;

  final String kham_chua_benh = "kham_chua_benh";
  final String kham_suc_khoe = "kham_suc_khoe";

  int _currentIndex = 0;

  static const _locations = [
    'Phòng Khám MEDOTIS 01',
    'Phòng Khám MEDOTIS 02',
    'Phòng Khám MEDOTIS 03',
    'Phòng Khám MEDOTIS 04',
    'Phòng Khám MEDOTIS 05',
  ];

  String _selectedLocation;

  final controller = ScrollController();
  double offset = 0;

  final _textController = TextEditingController();

  final UpdateAppointmentInfoBloc updateAppointmentInfoBloc = UpdateAppointmentInfoBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);

    _textController.text = widget.upcoming.lyDo;
    _selectedLocation = widget.upcoming.diaDiem;
    dia_diem = widget.upcoming.diaDiem;

    loai_dich_vu = widget.upcoming.loaiDichVu;
    loai_dich_vu == "kham_suc_khoe" ? _currentIndex = 1 : _currentIndex = 0;

    selectedDate = DateTime.now();
    // dateString =
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    String formattedTime = DateFormat('hh:mm aaa').format(selectedDate);
    dateString = formattedDate.toString();
    timeString = formattedTime.toString();
    firstDate = DateTime.now().subtract(Duration(days: 30));
    lastDate = DateTime.now().add(Duration(days: 90));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    updateAppointmentInfoBloc.close();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedDateStyleColor = Theme.of(context).accentTextTheme.bodyText1.color;
    selectedSingleDateDecorationColor = Theme.of(context).accentColor;
    date_picker.DatePickerStyles styles = date_picker.DatePickerRangeStyles(
      selectedDateStyle: Theme.of(context).accentTextTheme.bodyText1.copyWith(color: selectedDateStyleColor),
      selectedSingleDateDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: selectedSingleDateDecorationColor,
        shape: BoxShape.rectangle,
      ),
    );

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(
      context,
      designSize: Size(width, height),
      allowFontScaling: true,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().setHeight(60.0)),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Đặt Lịch Hẹn Khám",
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: BlocProvider(
            create: (context) => updateAppointmentInfoBloc,
            child: BlocConsumer<UpdateAppointmentInfoBloc, UpdateAppointmentInfoState>(
              listener: (context, state) {
                if (state is UpdateRequestAppointmentLoading) {
                  _timer?.cancel();
                  EasyLoading.show(
                    status: 'Đang tải...',
                  );
                }
                if (state is UpdateRequestAppointmentSuccess) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  return CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: "Thành Công",
                    text: "Cập Nhật Lịch Hẹn Thành Công",
                    onConfirmBtnTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  "Chọn Dịch Vụ Khám",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Text(
                              "Vui Lòng Chọn Dịch Vụ Khám Dưới Đây",
                              style: TextStyle(
                                fontSize: FontSize.fontSize15,
                                fontWeight: FontSize.medium,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),

                    // Chọn Dịch Vụ Khám
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        height: ScreenUtil().setHeight(90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                color: _currentIndex == 0 ? Colors.blue : Colors.grey[200],
                                // height: 100,
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 0;
                                    loai_dich_vu = kham_chua_benh;
                                    print(loai_dich_vu);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Khám Bệnh",
                                        style: TextStyle(
                                          fontSize: FontSize.fontSize18,
                                          fontWeight: FontSize.semiBold,
                                          color: _currentIndex == 0 ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Khám Chữa Bệnh",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: _currentIndex == 0 ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: FlatButton(
                                color: _currentIndex == 1 ? Colors.blue : Colors.grey[200],
                                // height: 100,
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 1;
                                    loai_dich_vu = kham_suc_khoe;
                                    print(loai_dich_vu);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      AutoSizeText(
                                        "Khám Sức Khỏe",
                                        style: TextStyle(
                                          fontSize: FontSize.fontSize18,
                                          fontWeight: FontSize.semiBold,
                                          color: _currentIndex == 1 ? Colors.white : Colors.black,
                                        ),
                                        maxLines: 1,
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Expanded(
                                        child: Text(
                                          "Khám Sức Khỏe Định Kì",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: _currentIndex == 1 ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),

                    // Chọn Địa Điểm Phòng Khám
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  "Chọn Địa Điểm",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(5),
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  value: _selectedLocation,
                                  items: _locations
                                      .map(
                                        (item) => DropdownMenuItem(
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: FontSize.fontSize18,
                                              fontWeight: FontSize.semiBold,
                                            ),
                                          ),
                                          value: item,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLocation = value;
                                      dia_diem = value;
                                      print(dia_diem);
                                    });
                                  },
                                  hint: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Vui Lòng Chọn Địa Điểm",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),

                    // Nêu lí do khám
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  "Lý Do Khám, Triệu Chứng...",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(5),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            Container(
                              height: ScreenUtil().setHeight(150),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: TextField(
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                controller: _textController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    top: 20,
                                    left: 20,
                                    right: 20,
                                  ),
                                  hintText: 'Nhập Lí Do, Triệu Chứng Của Bạn',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),

                    // Chọn Thời Gian
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  "Chọn Thời Gian",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(5),
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize24,
                                    fontWeight: FontSize.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(15),
                            ),

                            // timepicker
                            Container(
                              height: ScreenUtil().setHeight(200),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                              child: TimePickerSpinner(
                                is24HourMode: false,
                                normalTextStyle: TextStyle(
                                  fontSize: FontSize.fontSize26,
                                  color: Colors.grey[600],
                                  fontWeight: FontSize.semiBold,
                                ),
                                highlightedTextStyle: TextStyle(
                                  fontSize: FontSize.fontSize36,
                                  color: Colors.blue,
                                  fontWeight: FontSize.semiBold,
                                ),
                                spacing: 70,
                                itemHeight: 60,
                                itemWidth: 60,
                                isForce2Digits: true,
                                onTimeChange: (time) {
                                  setState(() {
                                    _dateTime = time;
                                    print(_dateTime);
                                    print(DateFormat("hh:mm:ss").format(_dateTime));
                                    timeString = DateFormat("HH:mm:ss").format(_dateTime).toString();
                                    // timeString = "${time.hour}:${time.minute}:00";
                                    requestDateTime = dateString + " " + timeString;
                                  });
                                },
                              ),
                            ),

                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            // date picker
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                              child: date_picker.DayPicker.single(
                                selectedDate: selectedDate,
                                onChanged: _onSelectedDateChanged,
                                firstDate: firstDate,
                                lastDate: lastDate,
                                datePickerStyles: styles,
                                datePickerLayoutSettings: date_picker.DatePickerLayoutSettings(
                                  maxDayPickerRowCount: 6,
                                  showPrevMonthEnd: true,
                                  showNextMonthStart: true,
                                  monthPickerPortraitWidth: ScreenUtil().setWidth(700),
                                ),
                                selectableDayPredicate: _isSelectableCustom,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),

                            // preview datetime
                            DisplayDateTime(
                              type: "Ngày",
                              datetime: dateString,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            DisplayDateTime(
                              type: "Giờ",
                              datetime: timeString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: FlatButton(
                        onPressed: () {
                          print(loai_dich_vu);
                          print(dia_diem);
                          ly_do = _textController.text;
                          print(ly_do);
                          print(requestDateTime);
                          updateAppointmentInfoBloc.add(
                            PostAppointmentRequestUpdate(
                              appointmentId: widget.upcoming.id.toString(),
                              thoiGianBatDau: requestDateTime,
                              lyDo: ly_do,
                              diaDiem: dia_diem,
                              loaiDichVu: loai_dich_vu,
                            ),
                          );
                        },
                        color: Colors.blue,
                        height: ScreenUtil().setHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(15.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Cập Nhật",
                            style: TextStyle(
                              fontSize: FontSize.fontSize22,
                              fontWeight: FontSize.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _isSelectableCustom(DateTime day) {
    return day.weekday < 8;
  }

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      print(selectedDate);
      print(DateFormat("yyyy-MM-dd").format(selectedDate));
      dateString = DateFormat("yyyy-MM-dd").format(selectedDate).toString();
      requestDateTime = dateString + " " + timeString;
      // DateTime tempDate =
      //     new DateFormat("yyyy-MM-dd hh:mm:ss").parse();
      // print(tempDate);
    });
  }
}

class DisplayDateTime extends StatelessWidget {
  final String type;
  final String datetime;

  const DisplayDateTime({Key key, this.type, this.datetime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.only(
              right: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  datetime,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
