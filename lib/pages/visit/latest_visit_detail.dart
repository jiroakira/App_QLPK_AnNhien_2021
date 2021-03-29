import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/model/screen_args.dart';
import 'package:medapp/routes/routes.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medapp/components/assignment_card/assignment_card.dart';
import 'package:medapp/components/assignment_card/file_wrapper.dart';
import 'package:open_file/open_file.dart';
import '../../components/custom_profile_item.dart';
import 'package:medapp/bloc/list_examinations.dart/examination_bloc.dart';

class LatestVisitDetail extends StatefulWidget {
  final String argument;

  const LatestVisitDetail({Key key, this.argument}) : super(key: key);

  @override
  _LatestVisitDetailState createState() => _LatestVisitDetailState();
}

class _LatestVisitDetailState extends State<LatestVisitDetail> {
  final SingleExaminationBloc _singleExaminationBloc = SingleExaminationBloc();
  final Dio _dio = Dio();

  String _progress = "-";

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _singleExaminationBloc.add(GetExamination(idChuoiKham: widget.argument));

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _onSelectNotification);
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android =
        AndroidNotificationDetails('channel id', 'channel name', 'channel description', priority: Priority.high, importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      isSuccess ? 'Thành Công' : 'Lỗi',
      isSuccess ? 'Tài Liệu Của Bạn Đã Được Tải Xuống Thành Công!' : 'Xảy Ra Lỗi Trong Quá Trình Tải.',
      platform,
      payload: json,
    );
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> _startDownload(String _fileUrl, String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(_fileUrl, savePath, onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result);
    }
  }

  Future<void> _download(String _fileUrl, String _fileName) async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      await _startDownload(_fileUrl, savePath);
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi Tiết Lịch Hẹn'.tr(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocProvider(
          create: (context) => _singleExaminationBloc,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: BlocBuilder<SingleExaminationBloc, ExaminationsState>(
              builder: (context, state) {
                if (state is SingleExaminationLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SingleExaminationEmpty) {
                  return Center(
                    child: Text("Bạn Chưa Có Kết Quả Kiểm Tra"),
                  );
                }
                if (state is SingleExaminationLoaded) {
                  if (state.examinationBody.data.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Mô Tả',
                                style: Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        state.examinationBody.data[0].moTa != null
                            ? Text(
                                state.examinationBody.data[0].moTa,
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            : Text("Bạn Không Có Dữ liệu Mô Tả"),
                        SizedBox(
                          height: 20,
                        ),
                        CustomProfileItem(
                          onTap: state.examinationBody.data[0].fileTongQuat != null
                              ? () {
                                  _download(
                                    state.examinationBody.data[0].fileTongQuat[0].fileKetQua.file.toString(),
                                    state.examinationBody.data[0].fileTongQuat[0].fileKetQua.file.split("/").last,
                                  );
                                }
                              : () {},
                          title: state.examinationBody.data[0].maKetQua != null ? state.examinationBody.data[0].maKetQua : "Không Có Mã Kết Quả",
                          subTitle: state.examinationBody.data[0].maKetQua != null ? state.examinationBody.data[0].maKetQua : "Không Có Mã Kết Quả",
                          buttonTitle: state.examinationBody.data[0].fileTongQuat.isNotEmpty
                              ? state.examinationBody.data[0].fileTongQuat[0].fileKetQua.file.split("/").last
                              : "Bạn Không Có File Dữ liệu Tổng Quát",
                          imagePath: 'assets/images/icon_examination.png',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Kết Luận'.tr(),
                                style: Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        state.examinationBody.data[0].ketLuan != null
                            ? Text(
                                state.examinationBody.data[0].ketLuan,
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            : Text("Bạn Không Có Dữ Liệu Kết Luận "),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Kết Quả Chuyên Khoa'.tr(),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        for (var j in state.examinationBody.data[0].kqChuyenKhoa)
                          j.chiSo == true
                              ? AssignmentCard(
                                  question: j.tenDichVu,
                                  subject: j.moTa,
                                  teacher: j.ketLuan,
                                  fileList: [
                                    FileWrapper(
                                      fileName: "Kết Quả Chỉ Số",
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          Routes.testResult,
                                          arguments: j.id.toString(),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : j.html == true
                                  ? AssignmentCard(
                                      question: j.tenDichVu,
                                      subject: j.moTa,
                                      teacher: j.ketLuan,
                                      fileList: [
                                        FileWrapper(
                                          fileName: "Phiếu Kết Quả",
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              Routes.testHtml,
                                              arguments: j.id.toString(),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : AssignmentCard(
                                      question: j.tenDichVu,
                                      subject: j.moTa,
                                      teacher: j.ketLuan,
                                      fileList: [
                                        for (var k in j.fileChuyenKhoa)
                                          FileWrapper(
                                            fileName: k.fileKetQua.file.split('/').last,
                                            fileSize: k.fileKetQua.thoiGianTao.split("T").first,
                                            onTap: () {
                                              _download(
                                                k.fileKetQua.file.toString(),
                                                k.fileKetQua.file.split('/').last,
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("Bạn Chưa Có Kết Quả Chuỗi Khám"),
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
