import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as date_picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/custom_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:medapp/components/utils/screen_size.dart';
import 'package:medapp/pages/appointment/appointment_detail_page.dart';
import 'package:medapp/bloc/appointment/request_appointment_bloc.dart';

class BookTimePage extends StatefulWidget {
  const BookTimePage({
    Key key,
  }) : super(key: key);

  @override
  _BookTimePageState createState() => _BookTimePageState();
}

class _BookTimePageState extends State<BookTimePage> {
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

  final RequestAppointmentBloc requestAppointmentBloc = RequestAppointmentBloc();

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    // dateString =
    String formattedDate = DateFormat('yyyy:MM:dd').format(selectedDate);
    String formattedTime = DateFormat('hh:mm aaa').format(selectedDate);
    dateString = formattedDate.toString();
    timeString = formattedTime.toString();
    firstDate = DateTime.now().subtract(Duration(days: 30));
    lastDate = DateTime.now().add(Duration(days: 90));
  }

  @override
  Widget build(BuildContext context) {
    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(
          ScreenSize.width,
          ScreenSize.height,
        ),
        allowFontScaling: true,
      );
    }

    selectedDateStyleColor = Theme.of(context).accentTextTheme.bodyText1.color;
    selectedSingleDateDecorationColor = Theme.of(context).accentColor;
    date_picker.DatePickerStyles styles = date_picker.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context).accentTextTheme.bodyText1.copyWith(color: selectedDateStyleColor),
        selectedSingleDateDecoration: BoxDecoration(color: selectedSingleDateDecorationColor, shape: BoxShape.rectangle));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đặt Lịch Hẹn Khám",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height * 1.2,
                // height: 500,
                width: ScreenUtil().setWidth(1080),
                // color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: buildDayPicker(context, styles),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDayPicker(BuildContext context, date_picker.DatePickerStyles styles) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 0),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100],
              ),
              child: Column(
                children: [
                  TimePickerSpinner(
                    is24HourMode: false,
                    normalTextStyle: TextStyle(fontSize: 25, color: Colors.grey[300]),
                    highlightedTextStyle: TextStyle(fontSize: 35, color: Colors.blueAccent),
                    spacing: 90,
                    itemHeight: 70,
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
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
              color: Colors.grey[100],
            ),
            child: date_picker.DayPicker.single(
              selectedDate: selectedDate,
              onChanged: _onSelectedDateChanged,
              firstDate: firstDate,
              lastDate: lastDate,
              datePickerStyles: styles,
              datePickerLayoutSettings: date_picker.DatePickerLayoutSettings(
                // maxDayPickerRowCount: 6,
                showPrevMonthEnd: true,
                showNextMonthStart: true,
                monthPickerPortraitWidth: 600,
              ),
              selectableDayPredicate: _isSelectableCustom,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              // height: 200,
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.grey,
                // ),
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  displayDateTime("Ngày", dateString),
                  displayDateTime("Giờ", timeString),
                  // DisplayDateTime(dateTime: dateString),
                ],
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => requestAppointmentBloc,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: BlocConsumer<RequestAppointmentBloc, RequestAppointmentState>(
                listener: (context, state) {
                  if (state is RequestAppointmentSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: requestAppointmentBloc,
                          child: AppointmentDetailPage(
                            responseAppointment: state.responseAppointment,
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RequestAppointmentLoading) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is RequestAppointmentError) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          "Tiếp Tục",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      requestAppointmentBloc.add(
                        PostAppointmentRequest(thoiGianBatDau: requestDateTime),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container displayDateTime(String type, String dateTime) {
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
                  dateTime,
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

  bool _isSelectableCustom(DateTime day) {
    return day.weekday < 6;
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
