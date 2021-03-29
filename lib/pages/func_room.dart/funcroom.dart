import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/bloc/func_room/func_room_bloc.dart';
import 'package:medapp/pages/func_room.dart/list_services.dart';

class FuncRoomPage extends StatefulWidget {
  FuncRoomPage({Key key}) : super(key: key);

  @override
  _FuncRoomPageState createState() => _FuncRoomPageState();
}

class _FuncRoomPageState extends State<FuncRoomPage> {
  final FuncRoomBloc funcRoomBloc = FuncRoomBloc();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    funcRoomBloc.add(GetAllFuncRoom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().setHeight(60.0)),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Danh Sách Phòng Chức Năng",
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
        child: Container(
          child: BlocProvider(
            create: (context) => funcRoomBloc,
            child: BlocBuilder<FuncRoomBloc, FuncRoomState>(
              builder: (context, state) {
                if (state is FuncRoomLoading) {
                  _timer?.cancel();
                  EasyLoading.show(
                    status: 'Đang tải...',
                  );
                }
                if (state is FuncRoomEmpty) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                }
                if (state is FuncRoomLoaded) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: ListView.separated(
                      itemCount: state.functionalRoom.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          // height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.functionalRoom.data[index].tenPhongChucNang,
                                  style: TextStyle(
                                    fontSize: FontSize.fontSize22,
                                    fontWeight: FontSize.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(10),
                              ),
                              FlatButton(
                                height: ScreenUtil().setHeight(50),
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ListServicesPage(
                                              funcRoomId: state.functionalRoom.data[index].id.toString(),
                                            )),
                                  );
                                },
                                child: Text(
                                  'Chi Tiết',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(10.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
