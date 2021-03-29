import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/list_examinations.dart/test_result_bloc.dart';

import 'package:medapp/components/card_result.dart';
import 'package:medapp/components/custom_clipper.dart';
import 'package:medapp/utils/const.dart';

class TestResult extends StatefulWidget {
  final String argument;

  const TestResult({Key key, this.argument}) : super(key: key);

  @override
  _TestResultState createState() => _TestResultState();
}

class _TestResultState extends State<TestResult> {
  final TestResultBloc testResultBloc = TestResultBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testResultBloc.add(GetTestResultEvent(id: widget.argument));
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Timer _timer;

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
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => testResultBloc,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.bottom),
              child: Container(
                color: Theme.of(context).accentColor,
                height: Constants.headerHeight + statusBarHeight,
              ),
            ),
            Positioned(
              right: -45,
              top: -30,
              child: ClipOval(
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  height: ScreenUtil().setHeight(220),
                  width: ScreenUtil().setWidth(220),
                ),
              ),
            ),

            // BODY
            BlocBuilder<TestResultBloc, TestResultState>(
              builder: (context, state) {
                if (state is TestResultLoading) {
                  _timer?.cancel();
                  EasyLoading.show(
                    status: 'Đang tải...',
                  );
                }
                if (state is TestResultLoaded) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  return Padding(
                    padding: EdgeInsets.all(Constants.paddingSide),
                    child: ListView(
                      children: <Widget>[
                        // Header - Greetings and Avatar
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Danh Sách Kết Quả\nXét Nghiệm",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            CircleAvatar(radius: 26.0, backgroundImage: null)
                          ],
                        ),

                        SizedBox(height: 50),

                        // Main Cards - Heartbeat and Blood Pressure
                        Container(
                          child: Column(
                            children: <Widget>[
                              for (var i in state.testResultBody.data)
                                i.chiSoXetNghiem != null
                                    ? CardResult(
                                        title: i.chiSoXetNghiem.tenChiSo,
                                        value: i.ketQuaXetNghiem,
                                        unit: i.chiSoXetNghiem.chiTiet.donViDo != null ? i.chiSoXetNghiem.chiTiet.donViDo : "",
                                        color: i.danhGiaChiSo == '1' ? Constants.lightGreen : Constants.lightYellow,
                                        standard: i.chiSoXetNghiem.chiTiet.chiSoBinhThuongMin + '-' + i.chiSoXetNghiem.chiTiet.chiSoBinhThuongMax,
                                        judment: i.danhGiaChiSo == '1' ? 'BT' : "KBT",
                                      )
                                    : CardResult(
                                        title: "Không xác định",
                                        value: i.ketQuaXetNghiem,
                                        unit: "",
                                        color: i.danhGiaChiSo == '1' ? Constants.lightGreen : Constants.lightYellow,
                                        standard: "Không xác định",
                                        judment: i.danhGiaChiSo == '1' ? 'BT' : "KBT",
                                      ),
                            ],
                          ),
                        ),

                        SizedBox(height: ScreenUtil().setHeight(20)),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
