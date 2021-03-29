import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/model/user/doctor.dart';

class DoctorProfile extends StatefulWidget {
  final Data doctorBody;
  DoctorProfile({Key key, this.doctorBody}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final controller = ScrollController();
  double offset = 0;

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
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
            "Thông Tin Bác Sĩ",
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
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
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
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.grey,
                              backgroundImage: widget.doctorBody.user.anhDaiDien != null ? NetworkImage(widget.doctorBody.user.anhDaiDien) : null,
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
                                      widget.doctorBody.user.hoTen,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        fontWeight: FontSize.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      widget.doctorBody.chucDanh,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        fontWeight: FontSize.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      widget.doctorBody.noiCongTac,
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
                                widget.doctorBody.user.hoTen,
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
                                widget.doctorBody.user.ngaySinh != null ? widget.doctorBody.user.ngaySinh : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.ngaySinh != null
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
                                widget.doctorBody.user.danToc != null ? widget.doctorBody.user.danToc : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.danToc != null
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
                                widget.doctorBody.user.email != null ? widget.doctorBody.user.email : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.email != null
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
                                widget.doctorBody.user.gioiTinh != null ? widget.doctorBody.user.gioiTinh : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.gioiTinh != null
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
                                widget.doctorBody.user.soDienThoai != null ? widget.doctorBody.user.soDienThoai : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.soDienThoai != null
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
                                widget.doctorBody.user.cmndCccd != null ? widget.doctorBody.user.cmndCccd : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.cmndCccd != null
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
                                widget.doctorBody.user.diaChi != null ? widget.doctorBody.user.diaChi : "Thiếu Thông Tin",
                                style: widget.doctorBody.user.diaChi != null
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
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Giới Thiệu",
                          style: TextStyle(
                            fontSize: FontSize.fontSize24,
                            fontWeight: FontSize.bold,
                            color: Colors.blue,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  // width: 500,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // height: ScreenUtil().setHeight(300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildIntroduction("Giới Thiệu", widget.doctorBody.gioiThieu),
                      buildIntroduction("Chuyên Khoa", widget.doctorBody.chuyenKhoa),
                      buildIntroduction("Nơi Công Tác", widget.doctorBody.noiCongTac),
                      buildIntroduction("Kinh Nghiệm", widget.doctorBody.kinhNghiem),
                    ],
                  ),
                ),
              ),
              // QR code
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Container(
              //     child: Center(
              //       child: Container(
              //         // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              //         height: 300,
              //         width: 300,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           color: Colors.white,
              //         ),
              //         child: Center(
              //           child: QrImage(
              //             data: widget.doctorBody.user.maBenhNhan,
              //             version: QrVersions.auto,
              //             size: 300,
              //             gapless: true,
              //             embeddedImage: AssetImage('assets/images/logo.png'),
              //             embeddedImageStyle: QrEmbeddedImageStyle(
              //               size: Size(45, 45),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildIntroduction(String title, String body) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            width: ScreenUtil().setWidth(150),
            child: Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Text(
                body,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
