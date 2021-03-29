import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/bloc/user_info/user_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({Key key}) : super(key: key);

  @override
  _CustomHeaderState createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  final UserInfoBloc userInfoBloc = UserInfoBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfoBloc.add(GetUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => userInfoBloc,
      child: Container(
        height: ScreenUtil().setHeight(150),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-banner.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            return Container(
              height: ScreenUtil().setHeight(150),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            // color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: ScreenUtil().setHeight(150),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/logo.png",
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "PHÒNG KHAM ĐK MEDOTIS",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontSize.bold,
                                              ),
                                              maxLines: 1,
                                            ),
                                            AutoSizeText(
                                              "LK55, Số 01, Khu A, Yên Nghĩa, Hà Đông, Hà Nội",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontSize.bold,
                                              ),
                                              maxLines: 1,
                                            ),
                                            AutoSizeText(
                                              "Hotline: 0963316107",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontSize.bold,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(30),
                                ),
                              ],
                            ),
                          ),
                        ),
                        state is UserInfoLoading
                            ? Center(child: CircularProgressIndicator())
                            : state is UserInfoLoaded
                                ? Positioned(
                                    top: ScreenUtil().setHeight(115),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      height: ScreenUtil().setHeight(70),
                                      width: ScreenUtil().setWidth(width - 40),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        // border: Border.all(color: Colors.grey[500], width: 1.5),
                                        color: Color(0xFF0779e4),
                                      ),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.account_circle,
                                            size: 35,
                                            color: Colors.white,
                                          ),
                                          // Image.asset('assets/images/account-1.png'),
                                          SizedBox(width: ScreenUtil().setWidth(10)),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  state.userInforBody.user.hoTen,
                                                  style: TextStyle(
                                                    fontSize: FontSize.fontSize20,
                                                    color: Colors.blue,
                                                    fontWeight: FontSize.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : state is UserInfoEmpty
                                    ? Container()
                                    : state is UserInfoError
                                        ? Container()
                                        : Container(),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
