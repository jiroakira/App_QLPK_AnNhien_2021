import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/pages/user_checkup/my_checkup.dart';
import '../../components/custom_navigation_bar.dart';
import '../../data/pref_manager.dart';
import '../../routes/routes.dart';
import '../../utils/constants.dart';
import '../drawer/drawer_page.dart';
import '../settings/settings_page.dart';
import 'widgets/widgets.dart';
import 'package:medapp/bloc/appointment/appointment.dart';
import 'package:medapp/pages/appointment/my_appointments_page.dart';
import 'package:medapp/model/token/token.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homepage.dart';
import 'package:flutter_share/flutter_share.dart';

class Home extends StatefulWidget {
  final ResponseTokenBody responseTokenBody;
  const Home({
    Key key,
    this.responseTokenBody,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  int _selectedIndex = 0;

  SendAppointmentRequestBloc sendAppointmentRequestBloc;

  static PageController _pageController;

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Hệ Thống Phòng Khám Medotis',
      text: 'Chia Sẻ Ứng Dụng Này Tới Mọi Người',
      linkUrl: 'https://github.com/jiroakira/ClinicMSSystemAPK/raw/main/app-arm64-v8a-release.apk',
      chooserTitle: 'Chia Sẻ Qua Các Nền Tảng',
    );
  }

  @override
  void initState() {
    super.initState();
    sendAppointmentRequestBloc = SendAppointmentRequestBloc();
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _selectPage(int index) {
    if (_pageController.hasClients) _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(
      context,
      designSize: Size(
        width,
        height,
      ),
      allowFontScaling: true,
    );

    final size = MediaQuery.of(context).size;
    final _pages = [
      // HomePage(
      //   responseTokenBody: widget.responseTokenBody,
      // ),
      HomePage(),
      // ProfilePage(
      //   responseTokenBody: widget.responseTokenBody,
      // ),
      MyAppointmentsPage(),
      // UserProfile(),
      Container(),

      MyCheckupProcess(),
      SettingsPage(),
    ];
    return Stack(
      children: <Widget>[
        DrawerPage(
          onTap: () {
            setState(
              () {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              },
            );
          },
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
            child: Scaffold(
              appBar: AppBar(
                leading: isDrawerOpen
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(
                            () {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            },
                          );
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.userProfile);
                        },
                      ),
                title: AppBarTitleWidget(),
                // actions: <Widget>[
                //   _selectedIndex == 2
                //       ? IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.add,
                //           ),
                //         )
                //       : IconButton(
                //           onPressed: () => Navigator.pushNamed(context, Routes.notifications),
                //           icon: Icon(
                //             Icons.notifications_none,
                //           ),
                //         ),
                // ],
              ),
              body: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _pages,
              ),
              floatingActionButton: Container(
                width: ScreenUtil().setWidth(80),
                height: ScreenUtil().setHeight(80),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x202e83f8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () => launch("tel://0963316107"),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kColorBlue,
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: CustomNavigationBar(
                backgroundColor: Prefs.isDark() ? Color(0xff121212) : Colors.white,
                strokeColor: kColorPink,
                items: [
                  NavBarItemWidget(
                    onTap: () {
                      _selectPage(0);
                    },
                    image: 'icon_home',
                    isSelected: _selectedIndex == 0,
                    title: "Trang Chủ",
                  ),
                  NavBarItemWidget(
                    onTap: () {
                      _selectPage(1);
                    },
                    image: 'calendar',
                    isSelected: _selectedIndex == 1,
                    title: "Lịch Hẹn",
                  ),
                  NavBarItemWidget(
                    onTap: () {},
                    image: '',
                    isSelected: false,
                    title: "",
                  ),
                  NavBarItemWidget(
                    onTap: () {
                      _selectPage(3);
                    },
                    image: 'workflow',
                    isSelected: _selectedIndex == 3,
                    title: "Chuỗi Khám",
                  ),
                  NavBarItemWidget(
                    onTap: share,
                    image: 'share',
                    isSelected: _selectedIndex == 4,
                    title: "Chia Sẻ ",
                  ),
                ],
                currentIndex: _selectedIndex,
                elevation: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
