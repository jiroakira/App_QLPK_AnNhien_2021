import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/labeled_text_form_field.dart';
import '../../components/custom_button.dart';
import '../../components/wave_header.dart';
import '../../routes/routes.dart';
import 'package:medapp/bloc/auth/signup/signup_bloc.dart';
import 'package:medapp/model/token/register.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupBloc _signupBloc = SignupBloc();

  final _fullnameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _cmndCCCD = TextEditingController();

  final _diaChi = TextEditingController();

  Timer _timer;

  @override
  Widget build(BuildContext context) {
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
                      child: Text("${connected ? 'Trực Tuyến' : 'Ngoại Tuyến'}"),
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
          create: (context) => _signupBloc,
          child: BlocListener<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is SignupLoading) {
                _timer?.cancel();
                EasyLoading.show(
                  status: 'Đang tải...',
                );
              }
              if (state is SignupError) {
                _timer?.cancel();
                EasyLoading.dismiss();
                showDialog(
                  context: context,
                  builder: (context) {
                    String title = 'Xảy Ra Lỗi...';
                    String content = state.error;
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Thử Lại'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    } else {
                      return AlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Thử Lại'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      );
                    }
                  },
                );
              } else if (state is SignupSuccess) {
                _timer?.cancel();
                EasyLoading.dismiss();
                showDialog(
                  context: context,
                  builder: (context) {
                    String title = 'Thông Báo';
                    String content = 'Đăng Kí Tài Khoản Thành Công';
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
                            },
                          ),
                        ],
                      );
                    } else {
                      return AlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
                            },
                          )
                        ],
                      );
                    }
                  },
                );
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
                          Stack(
                            children: <Widget>[
                              WaveHeader(
                                title: 'Chào Mừng Bạn Tới Medotis',
                                subtitle: "",
                              ),
                              Theme(
                                data: ThemeData(
                                  appBarTheme: AppBarTheme(
                                    iconTheme: IconThemeData(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    height: 20,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 38),
                                  child: Center(
                                    child: Text(
                                      'Tạo Mới Tài Khoản',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 38),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          LabeledTextFormField(
                                            title: 'Họ & tên'.tr(),
                                            controller: _fullnameController,
                                            hintText: 'Nhập họ tên của bạn',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 38),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          LabeledTextFormField(
                                            title: 'Số Điện Thoại',
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            hintText: 'Nhập số điện thoại của bạn',
                                          ),
                                          LabeledTextFormField(
                                            title: 'CMND/CCCD',
                                            controller: _cmndCCCD,
                                            keyboardType: TextInputType.phone,
                                            hintText: 'Nhập số CMND/CCCD',
                                          ),
                                          LabeledTextFormField(
                                            title: 'Địa Chỉ',
                                            controller: _diaChi,
                                            hintText: 'Địa Chỉ Của Bạn',
                                          ),
                                          LabeledTextFormField(
                                            title: "Mật Khẩu",
                                            controller: _passwordController,
                                            obscureText: true,
                                            hintText: '* * * * * *',
                                          ),
                                          LabeledTextFormField(
                                            title: 'Xác Nhận Mật Khẩu',
                                            controller: _confirmPasswordController,
                                            obscureText: true,
                                            hintText: '* * * * * *',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 38),
                                  child: CustomButton(
                                    onPressed: () {
                                      String hoTen = _fullnameController.text.trim();
                                      String password = _passwordController.text.trim();
                                      String soDienThoai = _phoneController.text.trim();
                                      String cmndCccd = _cmndCCCD.text.trim();
                                      String diaChi = _diaChi.text.trim();

                                      if (password == _confirmPasswordController.text.trim()) {
                                        _signupBloc.add(
                                          ButtonSignupPressed(
                                            registerBody: RegisterBody(
                                              hoTen: hoTen,
                                              soDienThoai: soDienThoai,
                                              password: password,
                                              cmndCccd: cmndCccd,
                                              diaChi: diaChi,
                                            ),
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String title = 'Xảy Ra Lỗi...';
                                            String content = "Mật Khẩu Phải Trùng Với Xác Nhận Mật Khẩu";
                                            if (Platform.isIOS) {
                                              return CupertinoAlertDialog(
                                                title: Text(title),
                                                content: Text(content),
                                                actions: <Widget>[
                                                  CupertinoDialogAction(
                                                    child: Text('Thử Lại'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return AlertDialog(
                                                title: Text(title),
                                                content: Text(content),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Thử Lại'),
                                                    onPressed: () => Navigator.pop(context),
                                                  )
                                                ],
                                              );
                                            }
                                          },
                                        );
                                      }
                                    },
                                    text: 'Đăng Kí',
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 20,
                                  ),
                                ),
                                SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 38),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${'Bạn đã có tài khoản'} ?',
                                          style: TextStyle(
                                            color: Color(0xffbcbcbc),
                                            fontSize: 15,
                                            fontFamily: 'NunitoSans',
                                          ),
                                        ),
                                        Text('   '),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(2),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              'Đăng Nhập',
                                              style: Theme.of(context).textTheme.button.copyWith(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                          BlocBuilder<SignupBloc, SignupState>(
                            builder: (context, state) {
                              if (state is SignupLoading) {
                                return Container();
                              } else {
                                return Container();
                              }
                            },
                          )
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
}
