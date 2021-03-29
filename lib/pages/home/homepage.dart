import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medapp/components/custom_header.dart';
import 'package:medapp/components/custom_promotions.dart';
import 'package:medapp/components/font_size/font_size.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/pages/user_checkup/my_checkup.dart';
import 'package:medapp/routes/routes.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const APP_STORE_URL = 'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
const PLAY_STORE_URL = 'https://github.com/jiroakira/ClinicMSSystemAPK/raw/main/app-arm64-v8a-release.apk';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  double offset = 0;
  WebSocketChannel channel;
  WebSocketChannel channel2;
  WebSocketChannel channel3;
  WebSocketChannel channel4;
  WebSocketChannel channel5;
  WebSocketChannel channel6;
  WebSocketChannel channel7;

  var sub;
  var sub2;
  var sub3;
  var sub4;
  var sub5;
  var sub6;
  var sub7;

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  Completer<GoogleMapController> _mapController = Completer();
  static const LatLng _center = const LatLng(20.953707, 105.748024);
  CameraPosition initialLocation = CameraPosition(zoom: 16, bearing: 30, target: _center);

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    setState(() {
      _markers.add(Marker(icon: pinLocationIcon, position: _center, markerId: MarkerId('<MARKER_ID>')));
    });
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    versionCheck(context);
    controller.addListener(onScroll);
    setCustomMapPin();
    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);

    channel = IOWebSocketChannel.connect(WS_URL + "ws/first_process_notification/$userId/");
    channel2 = IOWebSocketChannel.connect(WS_URL + "ws/checkup_process_notification/$userId/");
    channel3 = IOWebSocketChannel.connect(WS_URL + "ws/prescription_noti/$userId/");
    channel4 = IOWebSocketChannel.connect(WS_URL + "ws/charge_bill/$userId/");
    channel5 = IOWebSocketChannel.connect(WS_URL + "ws/charge_prescription_bill/$userId/");
    channel6 = IOWebSocketChannel.connect(WS_URL + "ws/charge_process_bill/$userId/");
    channel7 = IOWebSocketChannel.connect(WS_URL + "ws/process_accomplished/$userId/");

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings).then(
      (done) {
        sub = channel.stream.listen((data) {
          print(data);
          _showNotification(data);
        });
        sub2 = channel2.stream.listen(
          (data) {
            print(data);
            _showNotification2(data);
          },
        );
        sub3 = channel3.stream.listen(
          (data) {
            print(data);
            _showNotification3(data);
          },
        );
        sub4 = channel4.stream.listen(
          (data) {
            print(data);
            _showNotification3(data);
          },
        );
        sub5 = channel5.stream.listen(
          (data) {
            print(data);
            _showNotification3(data);
          },
        );
        sub6 = channel6.stream.listen(
          (data) {
            print(data);
            _showNotification3(data);
          },
        );
        sub7 = channel7.stream.listen(
          (data) {
            print(data);
            _showNotification3(data);
          },
        );
      },
    );
  }

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig.getString('force_update_current_version').trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog(
          context,
          remoteConfig.getString('title'),
          remoteConfig.getString('content'),
        );
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  _showVersionDialog(context, String title, String content) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // String title = "New Update Available";
        // String message = "There is a newer version of app available please update it now.";
        String btnLabel = "Cập Nhật";
        String btnLabelCancel = "Để Sau";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(APP_STORE_URL),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(PLAY_STORE_URL),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 2.5,
        size: Size(32, 32),
      ),
      'assets/images/tracking.png',
    );
  }

  Future<void> _onSelectNotification(String json) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCheckupProcess(),
      ),
    );
  }

  Future<void> _showNotification(String data) async {
    final json = jsonDecode(data);
    final android = AndroidNotificationDetails(
      'channel id 2',
      'channel name 2',
      'channel description 2',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: BigTextStyleInformation(''),
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      json['title'],
      json['body'],
      platform,
      // payload: json,
    );
  }

  Future<void> _showNotification2(String data) async {
    final android = AndroidNotificationDetails(
      'channel id 3',
      'channel name 3',
      'channel description 3',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: BigTextStyleInformation(''),
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonDecode(data);

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      json['title'],
      json['body'],
      platform,
      // payload: json,
    );
  }

  Future<void> _showNotification3(String data) async {
    final android = AndroidNotificationDetails(
      'channel id 4',
      'channel name 4',
      'channel description 4',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: BigTextStyleInformation(''),
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonDecode(data);

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      json['title'],
      json['body'],
      platform,
      // payload: json,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
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
      backgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomHeader(),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),

              // các chương trình khuyến mãi của phòng khám
              Promotions(),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),

              // 2 nút lớn
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      CoreButton(
                        title: "Đặt Lịch Khám",
                        imageUrl: "assets/images/appointment.png",
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.newBookingPage);
                        },
                        color: Color(0xFF0779e4),
                        boxShadowColor: Color(0xFF0779e4),
                        firstDotColor: Color(0xFF40bad5),
                        secondDotColor: Color(0xFF40bad5),
                      ),
                      // FlatGradientButton(
                      //   height: 110,
                      //   title: "Đặt Lịch Khám",
                      //   imageUrl: "assets/images/appointment.png",
                      //   onPressed: () {
                      //     Navigator.of(context).pushNamed(Routes.newBookingPage);
                      //   },
                      //   boxShadowColor: Color(0xFF0779e4),
                      //   // boxShadowColor: Colors.white,
                      //   firstDotColor: Colors.blue,
                      //   secondDotColor: Colors.blue,
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       Color(0xFF738AE6),
                      //       Color(0xFF5C5EDD),
                      //     ],
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //   ),
                      // ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                      CoreButton(
                        title: "Kết Quả Khám",
                        imageUrl: "assets/images/medical-result.png",
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.visitPage);
                        },
                        color: Color(0xFF0ABD06),
                        boxShadowColor: Color(0xFF0ABD06),
                        firstDotColor: Color(0xFFa2de96),
                        secondDotColor: Color(0xFFa2de96),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              // 3 nut be
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  // height: 1000,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      SubButton(
                        imageUrl: 'assets/images/icon_doctor_3.png',
                        title: "Bác Sĩ",
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.myDoctors);
                        },
                        // textColor: Color(0xFF161DB1),
                        textColor: Color(0xFF1f3c88),
                        boxShadowColor: Color(0xFFbce6eb),
                        color: Color(0xFFbce6eb),
                        firstDotColor: Color(0xFFbce6eb),
                        secondDotColor: Color(0xFFbce6eb),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      SubButton(
                        imageUrl: 'assets/images/icon_medical_check_up.png',
                        title: "Dịch Vụ",
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.funcRoom);
                        },
                        textColor: Color(0xFF1f3c88),
                        boxShadowColor: Color(0xFFbce6eb),
                        color: Color(0xFFbce6eb),
                        firstDotColor: Color(0xFFbce6eb),
                        secondDotColor: Color(0xFFbce6eb),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      SubButton(
                        imageUrl: 'assets/images/gift.png',
                        title: "Ưu Đãi",
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.emptyPage);
                        },
                        textColor: Color(0xFF1f3c88),
                        boxShadowColor: Color(0xFFbce6eb),
                        color: Color(0xFFbce6eb),
                        firstDotColor: Color(0xFFbce6eb),
                        secondDotColor: Color(0xFFbce6eb),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              // map của phòng khám

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 350,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                      markers: _markers,
                      initialCameraPosition: initialLocation,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoreButton extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function onPressed;
  final Color color;
  final Color boxShadowColor;
  final Color firstDotColor;
  final Color secondDotColor;

  const CoreButton({
    Key key,
    this.title,
    this.imageUrl,
    this.onPressed,
    this.color,
    this.boxShadowColor,
    this.firstDotColor,
    this.secondDotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: boxShadowColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            FlatButton(
              height: ScreenUtil().setHeight(110),
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(15.0),
                ),
              ),

              color: color,
              // height: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        imageUrl,
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      AutoSizeText(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontSize.semiBold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -10,
              left: -20,
              child: Container(
                width: 85,
                height: 75,
                decoration: BoxDecoration(
                  color: firstDotColor.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -35,
              right: -10,
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: secondDotColor.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function onPressed;
  final Color textColor;
  final Color boxShadowColor;
  final Color color;
  final Color firstDotColor;
  final Color secondDotColor;

  const SubButton({
    Key key,
    this.title,
    this.imageUrl,
    this.onPressed,
    this.textColor,
    this.boxShadowColor,
    this.color,
    this.firstDotColor,
    this.secondDotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: boxShadowColor.withOpacity(0.6),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            FlatButton(
              height: ScreenUtil().setHeight(100),
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(15.0),
                ),
              ),
              color: color,
              // height: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        // 'assets/images/icon_doctor_3.png',
                        imageUrl,
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      AutoSizeText(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontSize.semiBold,
                          color: textColor,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: -20,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: firstDotColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: secondDotColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlatGradientButton extends StatelessWidget {
  // final Widget child;
  final Gradient gradient;

  final double height;
  final Function onPressed;
  final Color boxShadowColor;
  final String title;
  final String imageUrl;
  final Color firstDotColor;
  final Color secondDotColor;
  const FlatGradientButton({
    Key key,
    this.gradient,
    this.height,
    this.onPressed,
    this.boxShadowColor,
    this.title,
    this.imageUrl,
    this.firstDotColor,
    this.secondDotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: ScreenUtil().setHeight(110),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: boxShadowColor.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(15.0),
                ),
              ),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: onPressed,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          imageUrl,
                          height: ScreenUtil().setHeight(50),
                          width: ScreenUtil().setWidth(50),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        AutoSizeText(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontSize.semiBold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: -20,
            child: Container(
              width: 85,
              height: 75,
              decoration: BoxDecoration(
                color: firstDotColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -35,
            right: -10,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: secondDotColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
