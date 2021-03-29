import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/update_user/update_user_bloc.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/components/text_form_field.dart';
import 'package:medapp/model/user/user_info.dart';
import 'package:intl/intl.dart';
import 'package:medapp/routes/routes.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserInforBody userInforBody;
  UpdateProfilePage({
    Key key,
    this.userInforBody,
  }) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final UpdateUserBloc updateUserBloc = UpdateUserBloc();

  DateTime birthDate;
  String requestBirthDate;
  String male = '1';
  String female = "2";
  String maleDisplay = "Nam";
  String femaleDisplay = "Nữ";
  String gender;

  final _hoTenController = TextEditingController();
  final _emailController = TextEditingController();
  final _soDienThoaiController = TextEditingController();
  final _cmndCccdController = TextEditingController();
  final _diaChiController = TextEditingController();
  final _danTocController = TextEditingController();
  final _maSoBaoHiemController = TextEditingController();
  final _ngaySinhController = TextEditingController();
  final _gioiTinhController = TextEditingController();

  @override
  void initState() {
    // _focusNode.addListener(_focusListener);
    super.initState();
    _hoTenController.text = widget.userInforBody.user.hoTen;
    _soDienThoaiController.text = widget.userInforBody.user.soDienThoai;
    _emailController.text = widget.userInforBody.user.email;
    _cmndCccdController.text = widget.userInforBody.user.cmndCccd;
    _diaChiController.text = widget.userInforBody.user.diaChi;
    _danTocController.text = widget.userInforBody.user.danToc;
    _ngaySinhController.text = widget.userInforBody.user.ngaySinh;
    requestBirthDate = widget.userInforBody.user.ngaySinh;
    _maSoBaoHiemController.text = widget.userInforBody.user.maSoBaoHiem;
    _gioiTinhController.text = widget.userInforBody.user.gioiTinh;
    gender = male;
  }

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person,
                size: 20,
              ),
              title: Text(
                'Nam',
                style: TextStyle(
                  color: Color(0xff4a4a4a),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onTap: () {
                setState(() {
                  gender = maleDisplay;
                  _gioiTinhController.text = gender;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 20,
              ),
              title: Text(
                'Nữ',
                style: TextStyle(
                  color: Color(0xff4a4a4a),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onTap: () {
                gender = femaleDisplay;
                _gioiTinhController.text = gender;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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
          title: AutoSizeText(
            "Chỉnh Sửa Thông Tin Cá Nhân",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontSize.bold,
              color: Colors.white,
            ),
            maxLines: 1,
          ),
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            FlatButton(
              onPressed: () {
                print(_hoTenController.text);
                print(_soDienThoaiController.text);
                print(_emailController.text);
                print(_cmndCccdController.text);
                print(_diaChiController.text);
                print(_ngaySinhController.text);
                print(_maSoBaoHiemController.text);
                print(_gioiTinhController.text);
                updateUserBloc.add(
                  ButtonUpdatePressed(
                    hoTen: _hoTenController.text,
                    soDienThoai: _soDienThoaiController.text,
                    email: _emailController.text,
                    cmndCccd: _cmndCccdController.text,
                    diaChi: _diaChiController.text,
                    ngaySinh: _ngaySinhController.text,
                    maSoBaoHiem: _maSoBaoHiemController.text,
                    danToc: _danTocController.text,
                    gioiTinh: _gioiTinhController.text == 'Nam' ? "1" : "2",
                  ),
                );
              },
              child: Text(
                "Lưu",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => updateUserBloc,
            child: BlocConsumer<UpdateUserBloc, UpdateUserState>(
              listener: (context, state) {
                if (state is UpdateUserSuccess) {
                  if (state.responseUserUpdateInfoBody.status == 500) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.responseUserUpdateInfoBody.message),
                        backgroundColor: Colors.pinkAccent,
                      ),
                    );
                  } else if (state.responseUserUpdateInfoBody.status == 200) {
                    Navigator.pop(context, state.responseUserUpdateInfoBody.message);
                    // Navigator.popAndPushNamed(context, Routes.userProfile, state.responseUserUpdateInfoBody.message);
                  }
                }
              },
              builder: (context, state) {
                return Container(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: <Widget>[
                        CustomTextFormField(
                          controller: _hoTenController,
                          hintText: 'Họ tên đầy đủ của bạn',
                          enabled: true,
                          keyboardType: TextInputType.text,
                          labelText: "Họ & tên",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          controller: _soDienThoaiController,
                          hintText: 'Số điện thoại của bạn',
                          enabled: false,
                          keyboardType: TextInputType.phone,
                          labelText: "Số Điện Thoại",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          readOnly: true,
                          suffixIcon: Icon(Icons.person),
                          onTap: () {
                            _openBottomSheet(context);
                          },
                          controller: _gioiTinhController,
                          hintText: '',
                          enabled: true,
                          keyboardType: TextInputType.text,
                          labelText: "Giới Tính",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          readOnly: true,
                          suffixIcon: Icon(Icons.calendar_today),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            ).then(
                              (DateTime value) {
                                if (value != null) {
                                  setState(
                                    () {
                                      birthDate = value;
                                      // requestBirthDate = value.toString();

                                      requestBirthDate = DateFormat("yyyy-MM-dd").format(birthDate).toString();
                                      _ngaySinhController.text = requestBirthDate;
                                    },
                                  );
                                }
                              },
                            );
                          },
                          controller: _ngaySinhController,
                          hintText: '',
                          enabled: true,
                          keyboardType: TextInputType.text,
                          labelText: "Ngày Sinh",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: 'Email của bạn',
                          enabled: true,
                          keyboardType: TextInputType.emailAddress,
                          labelText: "Email",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          controller: _cmndCccdController,
                          hintText: 'CMT/CCCD của bạn',
                          enabled: true,
                          keyboardType: TextInputType.text,
                          labelText: "CMND/CCCD",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          controller: _diaChiController,
                          hintText: 'Địa chỉ của bạn',
                          enabled: true,
                          keyboardType: TextInputType.streetAddress,
                          labelText: "Địa Chỉ",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          controller: _danTocController,
                          hintText: '',
                          enabled: true,
                          keyboardType: TextInputType.text,
                          labelText: "Dân Tộc",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextFormField(
                          controller: _maSoBaoHiemController,
                          hintText: 'Nhập mã số bảo hiểm của bạn',
                          enabled: true,
                          labelText: "Mã Số Bảo Hiểm",
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                      ],
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
