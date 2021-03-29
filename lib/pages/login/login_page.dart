import 'dart:async';
import 'dart:io';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/wave_header.dart';
import 'widgets/input_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/bloc/auth/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _loginBloc = LoginBloc();
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
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
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connectivity == ConnectivityResult.none) {
            return new Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 24.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                    child: Center(
                      child: Text(
                        "${connected ? 'Trực Tuyến' : 'Ngoại Tuyến'}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: ScreenUtil().setHeight(600),
                    width: ScreenUtil().setWidth(400),
                    child: EmptyListWidget(
                      image: null,
                      packageImage: PackageImage.Image_1,
                      title: "Xin lỗi, bạn đang ngoại tuyến!",
                      subTitle: "Vui lòng bật kết nối mạng để sử dụng dịch vụ!",
                      titleTextStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold,
                      ),
                      subtitleTextStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return child;
          }
        },
        child: BlocProvider(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                String title = 'Info';
                showDialog(
                  context: context,
                  builder: (context) {
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        title: Text(title),
                        content: Text(state.error),
                      );
                    } else {
                      return AlertDialog(
                        title: Text(title),
                        content: Text(state.error),
                      );
                    }
                  },
                );
              } else if (state is LoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false, arguments: state.responseTokenBody);
              }
            },
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          WaveHeader(
                            title: 'Hệ Thống Phòng Khám MEDOTIS',
                            subtitle: "Xin Chào",
                          ),
                          // CustomHeaderLogin(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 38),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Đăng Nhập Để Tiếp Tục',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  InputWidget(
                                    loginBloc: _loginBloc,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                  // SocialLoginWidget(),
                                  Expanded(
                                    child: SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                  ),
                                  SafeArea(
                                    child: Center(
                                      child: Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Medotis Pharmaceutical Technology JSC',
                                              style: TextStyle(
                                                color: Color(0xffbcbcbc),
                                                fontSize: 15,
                                                fontFamily: 'NunitoSans',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
