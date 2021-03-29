import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/model/user/user_info.dart';
import 'package:medapp/pages/profile/update_profile.dart';
import 'package:medapp/routes/routes.dart';
import 'package:medapp/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:medapp/bloc/user_info/user_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/injector/injector.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final controller = ScrollController();
  Timer _timer;
  double offset = 0;

  FToast fToast;

  final UserInfoBloc userInfoBloc = UserInfoBloc();
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Hủy"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Tiếp Tục"),
      onPressed: () {
        sharedPreferencesManager.clearAll();
        Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cảnh Báo"),
      content: Text("Bạn muốn đăng xuất?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showToast(String text) {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text(text),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  _navigateAndDisplaySelection(BuildContext context, UserInforBody userInforBody) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfilePage(
          userInforBody: userInforBody,
        ),
      ),
    );
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("$result"),
            backgroundColor: Colors.blueAccent,
          ),
        );
      // _showToast(result);
    } else {}
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
                Icons.camera,
                size: 20,
              ),
              title: Text(
                'Chụp ảnh',
                style: TextStyle(
                  color: Color(0xff4a4a4a),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                size: 20,
              ),
              title: Text(
                'Chọn hình ảnh từ thư viện',
                style: TextStyle(
                  color: Color(0xff4a4a4a),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  File _image;

  Future<Response> sendForm(String url, Map<String, dynamic> data, Map<String, File> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(file.openRead(), await file.length(), filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    return await dio.put(url, data: formData, options: Options(contentType: 'multipart/form-data'));
  }

  Future _getImage(ImageSource imageSource) async {
    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
    var image = await ImagePicker.pickImage(source: imageSource);
    var res1 = await sendForm(HOST_URL + 'api/chinh_sua_avatar/?id=$userId', {'name': 'iciruit', 'des': 'description'}, {'file': image});
    print("res-1 $res1");
    setState(() {
      _image = image;
    });

    //uploadPic();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    userInfoBloc.add(GetUserInfo());
    // fToast = FToast();
    // fToast.init(globalKey.currentState.context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(width, height),
        allowFontScaling: true,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().setHeight(60.0)),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Thông Tin Cá Nhân",
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
          actions: [
            InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Image.asset(
                  "assets/images/exit.png",
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setWidth(25),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
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
        child: SafeArea(
          child: SingleChildScrollView(
            controller: controller,
            child: BlocProvider(
              create: (context) => userInfoBloc,
              child: BlocBuilder<UserInfoBloc, UserInfoState>(
                builder: (context, state) {
                  if (state is UserInfoLoading) {
                    _timer?.cancel();
                    EasyLoading.show(
                      status: 'Đang tải...',
                    );
                    // return Container(
                    //   height: MediaQuery.of(context).size.height,
                    //   child: Center(
                    //     child: Container(
                    //       child: CircularProgressIndicator(
                    //         strokeWidth: 2,
                    //       ),
                    //     ),
                    //   ),
                    // );
                  }
                  if (state is UserInfoLoaded) {
                    _timer?.cancel();
                    EasyLoading.dismiss();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().setHeight(140),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background-banner.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: ScreenUtil().setHeight(140),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          _openBottomSheet(context);
                                        },
                                        child: _image == null
                                            ? CircleAvatar(
                                                radius: 45,
                                                backgroundColor: Colors.grey,
                                                backgroundImage: state.userInforBody.user.anhDaiDien != null
                                                    ? CachedNetworkImageProvider(state.userInforBody.user.anhDaiDien)
                                                    : null,
                                              )
                                            : CircleAvatar(
                                                radius: 45,
                                                backgroundImage: FileImage(_image),
                                              ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(20),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                              ),
                                              AutoSizeText(
                                                state.userInforBody.user.hoTen != null ? state.userInforBody.user.hoTen : '',
                                                style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(22),
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                              ),
                                              // SizedBox(
                                              //   height: ScreenUtil().setHeight(10),
                                              // ),
                                              AutoSizeText(
                                                state.userInforBody.user.maBenhNhan != null ? state.userInforBody.user.maBenhNhan : '',
                                                style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(22),
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                              ),
                                              AutoSizeText(
                                                state.userInforBody.user.maBenhNhan != null ? "(Đây là mã bệnh nhân của bạn, hãy chú ý)" : '',
                                                style: TextStyle(
                                                  fontSize: FontSize.fontSize16,
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Thông Tin Cơ Bản",
                                    style: TextStyle(
                                      fontSize: FontSize.fontSize24,
                                      fontWeight: FontSize.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  // padding: EdgeInsets.symmetric(horizontal: 5),
                                  onPressed: () {
                                    // Navigator.of(context).pushNamed(Routes.updateProfile, arguments: state.userInforBody);
                                    _navigateAndDisplaySelection(context, state.userInforBody);
                                  },
                                  child: Text(
                                    "Sửa",
                                    style: TextStyle(
                                      fontSize: FontSize.fontSize18,
                                      fontWeight: FontSize.medium,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: ScreenUtil().setHeight(300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: ScreenUtil().setHeight(300),
                                    padding: EdgeInsets.only(top: 10, left: 15, right: 5, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Họ Và Tên",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.hoTen,
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize18,
                                            fontWeight: FontSize.bold,
                                            // color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Ngày Sinh",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.ngaySinh != null ? state.userInforBody.user.ngaySinh : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.ngaySinh != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16,
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.red,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Dân Tộc",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.danToc != null ? state.userInforBody.user.danToc : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.danToc != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16, fontWeight: FontSize.bold, color: Colors.red,
                                                  // color: Colors.black,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.email != null ? state.userInforBody.user.email : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.email != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16, fontWeight: FontSize.bold, color: Colors.red,
                                                  // color: Colors.black,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                Expanded(
                                  child: Container(
                                    height: ScreenUtil().setHeight(300),
                                    padding: EdgeInsets.only(top: 10, left: 5, right: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Giới Tính",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.gioiTinh != null ? state.userInforBody.user.gioiTinh : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.gioiTinh != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16,
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.red,
                                                  // color: Colors.black,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Số Điện Thoại",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.soDienThoai != null ? state.userInforBody.user.soDienThoai : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.soDienThoai != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16,
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.red,
                                                  // color: Colors.black,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "CMND/CCCD",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.cmndCccd != null ? state.userInforBody.user.cmndCccd : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.cmndCccd != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16,
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.red,
                                                  // color: Colors.black,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Địa Chỉ",
                                          style: TextStyle(
                                            fontSize: FontSize.fontSize16,
                                            fontWeight: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.userInforBody.user.diaChi != null ? state.userInforBody.user.diaChi : "Thiếu Thông Tin",
                                          style: state.userInforBody.user.diaChi != null
                                              ? TextStyle(
                                                  fontSize: FontSize.fontSize18,
                                                  fontWeight: FontSize.bold,
                                                  // color: Colors.black,
                                                )
                                              : TextStyle(
                                                  fontSize: FontSize.fontSize16,
                                                  fontWeight: FontSize.bold,
                                                  color: Colors.red,
                                                  // color: Colors.black,
                                                ),
                                        ),
                                      ],
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

                        // QR code
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: QrImage(
                                    data: state.userInforBody.user.maBenhNhan,
                                    version: QrVersions.auto,
                                    size: 300,
                                    gapless: true,
                                    embeddedImage: AssetImage('assets/images/logo.png'),
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: Size(45, 45),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
