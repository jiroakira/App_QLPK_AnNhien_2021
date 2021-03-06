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
                      child: Text("${connected ? 'Tr???c Tuy???n' : 'Ngo???i Tuy???n'}"),
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
                      title: "Xin l???i, b???n ??ang ngo???i tuy???n!",
                      subTitle: "Vui l??ng b???t k???t n???i m???ng ????? s??? d???ng d???ch v???!",
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
                  status: '??ang t???i...',
                );
              }
              if (state is SignupError) {
                _timer?.cancel();
                EasyLoading.dismiss();
                showDialog(
                  context: context,
                  builder: (context) {
                    String title = 'X???y Ra L???i...';
                    String content = state.error;
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Th??? L???i'),
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
                            child: Text('Th??? L???i'),
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
                    String title = 'Th??ng B??o';
                    String content = '????ng K?? T??i Kho???n Th??nh C??ng';
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
                                title: 'Ch??o M???ng B???n T???i Medotis',
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
                                      'T???o M???i T??i Kho???n',
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
                                            title: 'H??? & t??n'.tr(),
                                            controller: _fullnameController,
                                            hintText: 'Nh???p h??? t??n c???a b???n',
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
                                            title: 'S??? ??i???n Tho???i',
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            hintText: 'Nh???p s??? ??i???n tho???i c???a b???n',
                                          ),
                                          LabeledTextFormField(
                                            title: 'CMND/CCCD',
                                            controller: _cmndCCCD,
                                            keyboardType: TextInputType.phone,
                                            hintText: 'Nh???p s??? CMND/CCCD',
                                          ),
                                          LabeledTextFormField(
                                            title: '?????a Ch???',
                                            controller: _diaChi,
                                            hintText: '?????a Ch??? C???a B???n',
                                          ),
                                          LabeledTextFormField(
                                            title: "M???t Kh???u",
                                            controller: _passwordController,
                                            obscureText: true,
                                            hintText: '* * * * * *',
                                          ),
                                          LabeledTextFormField(
                                            title: 'X??c Nh???n M???t Kh???u',
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
                                            String title = 'X???y Ra L???i...';
                                            String content = "M???t Kh???u Ph???i Tr??ng V???i X??c Nh???n M???t Kh???u";
                                            if (Platform.isIOS) {
                                              return CupertinoAlertDialog(
                                                title: Text(title),
                                                content: Text(content),
                                                actions: <Widget>[
                                                  CupertinoDialogAction(
                                                    child: Text('Th??? L???i'),
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
                                                    child: Text('Th??? L???i'),
                                                    onPressed: () => Navigator.pop(context),
                                                  )
                                                ],
                                              );
                                            }
                                          },
                                        );
                                      }
                                    },
                                    text: '????ng K??',
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
                                          '${'B???n ???? c?? t??i kho???n'} ?',
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
                                              '????ng Nh???p',
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
