import 'package:flutter/material.dart';
import 'package:medapp/pages/user_checkup/checkup_page.dart';
import 'package:medapp/pages/user_checkup/checkup_prescription.dart';
import 'package:medapp/pages/user_checkup/checkup_result.dart';
import 'package:medapp/pages/user_checkup/checkup_invoice.dart';
import 'package:medapp/utils/constants.dart';

class MyCheckupProcess extends StatefulWidget {
  int selectedPage;
  MyCheckupProcess({Key key}) : super(key: key);

  @override
  _MyCheckupProcessState createState() => _MyCheckupProcessState();
}

class _MyCheckupProcessState extends State<MyCheckupProcess> {
  static const _tabTextStyle = TextStyle(
    color: kColorPrimaryDark,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  static const _unselectedTabTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  final _tabPage = [
    CheckupProgressPage(),
    CheckupResultPage(),
    CheckupPrescriptionPage(),
    CheckupInvoicePage(),
  ];

  final _kTabs = [
    Tab(
      text: 'Tiến Trình',
    ),
    Tab(
      text: 'Kết Quả',
    ),
    Tab(
      text: 'Đơn Thuốc',
    ),
    Tab(
      text: 'Hóa Đơn',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tổng Quan Kiểm Tra"),
        elevation: 0,
      ),
      body: DefaultTabController(
        length: _kTabs.length,
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: kColorPrimary,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              labelStyle: _tabTextStyle,
              unselectedLabelStyle: _unselectedTabTextStyle,
              labelColor: kColorPrimary,
              unselectedLabelColor: Colors.grey,
              tabs: _kTabs,
              indicator: MD2Indicator(
                indicatorHeight: 3,
                indicatorColor: Color(0xff1a73e8),
                indicatorSize: MD2IndicatorSize.normal,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _tabPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MD2IndicatorSize {
  tiny,
  normal,
  full,
}

class MD2Indicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final MD2IndicatorSize indicatorSize;

  const MD2Indicator({@required this.indicatorHeight, @required this.indicatorColor, @required this.indicatorSize});

  @override
  _MD2Painter createBoxPainter([VoidCallback onChanged]) {
    return new _MD2Painter(this, onChanged);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect rect;
    if (decoration.indicatorSize == MD2IndicatorSize.full) {
      rect = Offset(offset.dx, (configuration.size.height - decoration.indicatorHeight ?? 3)) &
          Size(configuration.size.width, decoration.indicatorHeight ?? 3);
    } else if (decoration.indicatorSize == MD2IndicatorSize.normal) {
      rect = Offset(offset.dx + 6, (configuration.size.height - decoration.indicatorHeight ?? 3)) &
          Size(configuration.size.width - 12, decoration.indicatorHeight ?? 3);
    } else if (decoration.indicatorSize == MD2IndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size.width / 2 - 8, (configuration.size.height - decoration.indicatorHeight ?? 3)) &
          Size(16, decoration.indicatorHeight ?? 3);
    }

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor ?? Color(0xff1967d2);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: Radius.circular(8), topLeft: Radius.circular(8)), paint);
  }
}
