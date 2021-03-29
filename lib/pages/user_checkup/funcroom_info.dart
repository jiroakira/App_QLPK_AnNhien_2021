import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/utils/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FuncroomInfoPage extends StatefulWidget {
  final String argument;
  FuncroomInfoPage({Key key, this.argument}) : super(key: key);

  @override
  _FuncroomInfoPageState createState() => _FuncroomInfoPageState();
}

class _FuncroomInfoPageState extends State<FuncroomInfoPage> {
  WebSocketChannel channel;
  final controller = ScrollController();
  double offset = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    channel = IOWebSocketChannel.connect(WS_URL + "ws/funcroom_info/service/${widget.argument}/");
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Thông Tin Phòng Chức Năng"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: StreamBuilder(
          stream: channel.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> _data = json.decode(snapshot.data);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      height: ScreenUtil().setHeight(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          _data['phong_chuc_nang'],
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Container(
                      height: ScreenUtil().setHeight(150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: Colors.blue[400],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              width: ScreenUtil().setWidth(250),
                              child: Container(
                                height: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue[400],
                                ),
                                child: Center(
                                  child: Text(
                                    "Đang Chờ",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(25),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              width: ScreenUtil().setWidth(250),
                              child: Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(15),
                                //   color: Colors.blue[400],
                                // ),
                                child: Center(
                                  child: Text(
                                    _data['dang_cho'].toString(),
                                    style: TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: ScreenUtil().setHeight(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: Colors.yellow[400],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              width: ScreenUtil().setWidth(250),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                height: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.yellow[400],
                                ),
                                child: Center(
                                  child: Text(
                                    "Thực Hiện",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(25),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              width: ScreenUtil().setWidth(250),
                              child: Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(15),
                                //   color: Colors.blue[400],
                                // ),
                                child: Center(
                                  child: Text(
                                    _data['dang_thuc_hien'].toString(),
                                    style: TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Container(
                      height: ScreenUtil().setHeight(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: Colors.green[400],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              width: ScreenUtil().setWidth(250),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                height: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green[400],
                                ),
                                child: Center(
                                  child: Text(
                                    "Hoàn Thành",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(25),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              width: ScreenUtil().setWidth(250),
                              child: Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(15),
                                //   color: Colors.blue[400],
                                // ),
                                child: Center(
                                  child: Text(
                                    _data['hoan_thanh'].toString(),
                                    style: TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text("Không Có Thông Tin Phòng Chức Năng"),
              );
            }
          },
        ),
      ),
    );
  }
}
