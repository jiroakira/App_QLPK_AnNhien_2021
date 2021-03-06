import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/invoice/exam_invoice.dart';
import 'package:medapp/bloc/invoice/first_invoice.dart';
import 'package:medapp/bloc/invoice/pres_invoice.dart';
import 'package:medapp/model/appointment/first_invoice.dart';
import 'package:medapp/model/examination/examination_invoice.dart';
import 'package:medapp/model/examination/prescription_invoice.dart';
import 'package:medapp/model/screen_args.dart';

class ExamInvoicePage extends StatefulWidget {
  final String argument;
  final String lichHenId;

  final ScreenArguments screenArguments;

  ExamInvoicePage({Key key, this.argument, this.lichHenId, this.screenArguments}) : super(key: key);

  @override
  _ExamInvoicePageState createState() => _ExamInvoicePageState();
}

class _ExamInvoicePageState extends State<ExamInvoicePage> {
  final controller = ScrollController();
  double offset = 0;
  Timer _timer;

  final ExamInvoiceBloc examInvoiceBloc = ExamInvoiceBloc();
  final PresInvoiceBloc presInvoiceBloc = PresInvoiceBloc();
  final FirstInvoiceBloc firstInvoiceBloc = FirstInvoiceBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(onScroll);
    examInvoiceBloc.add(GetExamInvoice(chuoiKhamId: widget.screenArguments.argument1.toString()));
    presInvoiceBloc.add(GetPresInvoice(chuoiKhamId: widget.screenArguments.argument1.toString()));
    firstInvoiceBloc.add(GetFirstInvoice(lichHenId: widget.screenArguments.argument2.toString()));
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
      appBar: AppBar(
        title: Text('H??a ????n Chu???i Kh??m'),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => examInvoiceBloc,
            ),
            BlocProvider(
              create: (context) => presInvoiceBloc,
            ),
            BlocProvider(
              create: (context) => firstInvoiceBloc,
            ),
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "H??a ????n L??m S??ng",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(23),
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                BlocBuilder<FirstInvoiceBloc, FirstInvoiceState>(
                  builder: (context, state) {
                    if (state is FirstInvoiceLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is FirstInvoiceEmpty) {
                      return Container();
                    }
                    if (state is FirstInvoiceLoaded) {
                      return FirstInvoiceWidget(
                        width: width,
                        firstInvoice: state.firstInvoice,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "H??a ????n D???ch V???",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(23),
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                BlocBuilder<ExamInvoiceBloc, ExamInvoiceState>(
                  builder: (context, state) {
                    if (state is ExamInvoiceLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ExamInvoiceEmpty) {
                      return Container(
                        child: Center(
                          child: Text(
                            "B???n Kh??ng C?? H??a ????n N??o C???n Thanh To??n.",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is ExamInvoiceLoaded) {
                      if (state.examinationsInvoice.data.length != 0) {
                        return ExaminationsInvoiceWidget(
                          examinationsInvoice: state.examinationsInvoice,
                          width: width,
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text(
                              "B???n Kh??ng C?? H??a ????n N??o C???n Thanh To??n.",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "H??a ????n Thu???c",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(23),
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                BlocBuilder<PresInvoiceBloc, PresInvoiceState>(
                  builder: (context, state) {
                    if (state is PresInvoiceLoading) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is PresInvoiceEmpty) {
                      return Container(
                        child: Center(
                          child: Text(
                            "B???n Kh??ng C?? H??a ????n N??o C???n Thanh To??n.",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is PresInvoiceLoaded) {
                      if (state.prescriptionInvoice.data.isNotEmpty) {
                        return PrescriptionInvoiceWidget(
                          width: width,
                          prescriptionInvoice: state.prescriptionInvoice,
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text(
                              "B???n Kh??ng C?? H??a ????n Thu???c N??o C???n Thanh To??n.",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(15),
                // ),
                // Text(
                //   "H??a ????n V???t T??",
                //   style: TextStyle(
                //     fontSize: ScreenUtil().setSp(23),
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "OpenSans",
                //     color: Colors.grey[700],
                //   ),
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(15),
                // ),
                // ExaminationsInvoiceWidget(
                //   width: width,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrescriptionInvoiceWidget extends StatelessWidget {
  final PrescriptionInvoice prescriptionInvoice;

  const PrescriptionInvoiceWidget({
    Key key,
    @required this.width,
    this.prescriptionInvoice,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // height: 500,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent.withOpacity(0.2),
      ),
      child: Column(
        children: <Widget>[
          PrescriptionRow(
            width: width,
            title: "N???i Dung Kh??m",
            insurance: "BH",
            quantity: "SL",
            cost: "Gi??",
            cost2: "T???ng",
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          for (var i in prescriptionInvoice.data)
            PrescriptionRow(
              width: width,
              title: i.thuoc.tenThuoc,
              quantity: i.soLuong.toString(),
              insurance: i.baoHiem == true ? "C??" : "Ko",
              // cost: i.thuoc.donGiaTt,
              cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(i.thuoc.donGiaTt)).toString(),
              // cost2: (int.parse(i.thuoc.donGiaTt) * i.soLuong).toString(),
              cost2: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse((int.parse(i.thuoc.donGiaTt) * i.soLuong).toString())).toString(),
            ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          PrescriptionRow(
            width: width,
            title: "T???ng Ti???n",
            quantity: "",
            insurance: "",
            // cost2: prescriptionInvoice.tongTien.toString(),
            cost2: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(prescriptionInvoice.tongTien.toString())).toString(),
            cost: '',
          ),
          PrescriptionRow(
            width: width,
            title: "??p D???ng B???o Hi???m",
            quantity: "",
            insurance: "",
            // cost2: prescriptionInvoice.apDungBaoHiem.toString(),
            cost2: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(prescriptionInvoice.apDungBaoHiem.toString())).toString(),
            cost: '',
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          PrescriptionRow(
            width: width,
            title: "Th??nh Ti???n",
            quantity: "",
            insurance: "",
            // cost2: prescriptionInvoice.thanhTien.toString(),
            cost2: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(prescriptionInvoice.thanhTien.toString())).toString(),
            cost: '',
          ),
        ],
      ),
    );
  }
}

class ExaminationsInvoiceWidget extends StatelessWidget {
  final ExaminationsInvoice examinationsInvoice;
  const ExaminationsInvoiceWidget({
    Key key,
    @required this.width,
    this.examinationsInvoice,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // height: 500,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent.withOpacity(0.2),
      ),
      child: Column(
        children: <Widget>[
          InvoiceRow(
            width: width,
            title: "N???i Dung Kh??m",
            insurance: "B???o Hi???m",
            cost: "Gi?? Ti???n",
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          for (var i in examinationsInvoice.data)
            InvoiceRow(
              width: width,
              title: i.dichVuKham.tenDvkt,
              // cost: i.dichVuKham.donGia,
              cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(i.dichVuKham.donGia)).toString(),
              insurance: i.baoHiem == true ? "C??" : "Ko",
            ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          InvoiceRow(
            width: width,
            title: "T???ng Ti???n",
            insurance: "",
            // cost: examinationsInvoice.tongTien.toInt().toString(),
            cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(examinationsInvoice.tongTien.toInt().toString())).toString(),
          ),
          InvoiceRow(
            width: width,
            title: "??p D???ng B???o Hi???m",
            insurance: "",
            // cost: examinationsInvoice.apDungBaoHiem.toInt().toString(),
            cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(examinationsInvoice.apDungBaoHiem.toInt().toString())).toString(),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          InvoiceRow(
            width: width,
            title: "Th??nh Ti???n",
            insurance: "",
            // cost: examinationsInvoice.thanhTien.toInt().toString(),
            cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(examinationsInvoice.thanhTien.toInt().toString())).toString(),
          ),
        ],
      ),
    );
  }
}

class InvoiceRow extends StatelessWidget {
  final String title;
  final String insurance;
  final String cost;
  const InvoiceRow({
    Key key,
    @required this.width,
    this.title,
    this.cost,
    this.insurance,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: width * 0.4,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(5),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
            child: AutoSizeText(
              insurance,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
                color: Color(0xFFDD2C00),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(5),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
            child: AutoSizeText(
              cost,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
                color: Color(0xFFDD2C00),
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class PrescriptionRow extends StatelessWidget {
  final String title;
  final String insurance;
  final String cost;
  final String cost2;
  final String quantity;
  const PrescriptionRow({
    Key key,
    @required this.width,
    this.title,
    this.cost,
    this.insurance,
    this.quantity,
    this.cost2,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: width * 0.4,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(5),
          ),
          Container(
            width: ScreenUtil().setWidth(40),
            child: AutoSizeText(
              insurance,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
                color: Color(0xFFDD2C00),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(5),
          ),
          Container(
            width: ScreenUtil().setWidth(40),
            child: AutoSizeText(
              quantity,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
                color: Color(0xFFDD2C00),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(5),
          ),
          Container(
            width: ScreenUtil().setWidth(60),
            child: AutoSizeText(
              cost,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
                color: Color(0xFFDD2C00),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(5),
          ),
          Container(
            width: ScreenUtil().setWidth(60),
            child: AutoSizeText(
              cost2,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.bold,
                color: Color(0xFFDD2C00),
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class FirstInvoiceWidget extends StatelessWidget {
  final FirstInvoice firstInvoice;
  const FirstInvoiceWidget({
    Key key,
    @required this.width,
    this.firstInvoice,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // height: 500,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent.withOpacity(0.2),
      ),
      child: Column(
        children: <Widget>[
          InvoiceRow(
            width: width,
            title: "N???i Dung Kh??m",
            insurance: "",
            cost: "T???ng Ti???n",
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          InvoiceRow(
            width: width,
            title: 'Kh??m L??m S??ng',
            // cost: firstInvoice.data.tongTien.split('.').first,
            cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(firstInvoice.data.tongTien.split('.').first)).toString(),
            insurance: '',
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          InvoiceRow(
            width: width,
            title: "Th??nh Ti???n",
            insurance: "",
            // cost: firstInvoice.data.tongTien.split('.').first,
            cost: NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(firstInvoice.data.tongTien.split('.').first)).toString(),
          ),
        ],
      ),
    );
  }
}
