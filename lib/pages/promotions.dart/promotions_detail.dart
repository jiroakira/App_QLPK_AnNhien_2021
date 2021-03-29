import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
// import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/font_size/font_size.dart' as fontsize;
import 'package:medapp/model/list_promotions.dart';
import 'package:intl/intl.dart';

class PromotionDetail extends StatefulWidget {
  final Data argument;
  const PromotionDetail({Key key, this.argument}) : super(key: key);

  @override
  _PromotionDetailState createState() => _PromotionDetailState();
}

class _PromotionDetailState extends State<PromotionDetail> {
  final controller = ScrollController();

  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
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
    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(width, height),
        allowFontScaling: true,
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(500),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.argument.hinhAnh),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: ScreenUtil().setHeight(500),
                color: Colors.grey.withOpacity(0.5),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            top: 30,
                            left: 20,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                              height: ScreenUtil().setHeight(500),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      widget.argument.tieuDe,
                                      style: TextStyle(
                                        fontSize: fontsize.FontSize.fontSize22,
                                        fontWeight: fontsize.FontSize.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-ddThh:mm:ss").parse(widget.argument.thoiGianBatDau))}",
                                              style: TextStyle(
                                                fontSize: fontsize.FontSize.fontSize16,
                                                fontWeight: fontsize.FontSize.semiBold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-ddThh:mm:ss").parse(widget.argument.thoiGianKetThuc))}",
                                              style: TextStyle(
                                                fontSize: fontsize.FontSize.fontSize16,
                                                fontWeight: fontsize.FontSize.semiBold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Html(data: widget.argument.noiDung, style: {
                "body": Style(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.bold,
                ),
              }),
            )
          ],
        ),
      ),
    );
  }
}
