import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPage extends StatefulWidget {
  EmptyPage({Key key}) : super(key: key);

  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: ScreenUtil().setHeight(600),
          width: ScreenUtil().setWidth(400),
          child: EmptyListWidget(
            image: null,
            packageImage: PackageImage.Image_1,
            title: "Tính năng này đang được phát triển",
            subTitle: "Các chương trình ưu đãi hiện tại MEDOTIS đang tham khảo ý kiến các phòng khám để tiện cho việc cập nhật và nâng cấp tính năng",
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
    );
  }
}
