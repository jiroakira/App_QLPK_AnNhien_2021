import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/func_room/list_services.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:intl/intl.dart';

class ListServicesPage extends StatefulWidget {
  final String funcRoomId;
  ListServicesPage({Key key, this.funcRoomId}) : super(key: key);

  @override
  _ListServicesPageState createState() => _ListServicesPageState();
}

class _ListServicesPageState extends State<ListServicesPage> {
  final ListServicesBloc listServicesBloc = ListServicesBloc();

  Timer _timer;

  final moneyFormat = new NumberFormat("#.######", "vi_VI");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listServicesBloc.add(GetListServices(funcRoomId: widget.funcRoomId));
  }

  @override
  Widget build(BuildContext context) {
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
            "Danh Sách Dịch Vụ",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
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
            create: (context) => listServicesBloc,
            child: BlocBuilder<ListServicesBloc, ListServicesState>(
              builder: (context, state) {
                if (state is ListServicesLoading) {
                  _timer?.cancel();
                  EasyLoading.show(
                    status: 'Đang tải...',
                  );
                }
                if (state is ListServicesEmpty) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                }
                if (state is ListServicesLoaded) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: ListView.separated(
                      itemCount: state.listServices.data.length,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.listServices.data[index].tenDvkt,
                                      style: TextStyle(
                                        fontSize: FontSize.fontSize22,
                                        fontWeight: FontSize.bold,
                                      ),
                                    ),
                                    Text(
                                      "Giá: " +
                                          "${NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(state.listServices.data[index].donGia))}",
                                      style: TextStyle(
                                        fontSize: FontSize.fontSize22,
                                        fontWeight: FontSize.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
