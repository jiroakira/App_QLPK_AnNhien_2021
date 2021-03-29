import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/prescription/prescription_bloc.dart';
import 'package:medapp/components/custom_recipe_item.dart';

class ExaminationPrescriptionPage extends StatefulWidget {
  final String argument;

  ExaminationPrescriptionPage({this.argument});

  @override
  _ExaminationPrescriptionPageState createState() => _ExaminationPrescriptionPageState();
}

class _ExaminationPrescriptionPageState extends State<ExaminationPrescriptionPage> {
  final ExaminationPrescriptionBloc examinationPrescriptionBloc = ExaminationPrescriptionBloc();

  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    examinationPrescriptionBloc.add(GetExaminationPrescription(chuoiKhamId: widget.argument));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi Tiết Đơn Thuốc',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocProvider(
          create: (context) => examinationPrescriptionBloc,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: BlocBuilder<ExaminationPrescriptionBloc, PrescriptionState>(
              builder: (context, state) {
                if (state is ExaminationPrescriptionLoading) {
                  _timer?.cancel();
                  EasyLoading.show(
                    status: 'Đang tải...',
                  );
                }
                if (state is ExaminationPrescriptionEmpty) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  return Container(
                    child: Center(
                      child: Text(
                        "Bạn Không Có Đơn Thuốc Nào",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                if (state is ExaminationPrescriptionLoaded) {
                  _timer?.cancel();
                  EasyLoading.dismiss();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var i in state.prescriptionBody.data)
                        CustomRecipeItem(
                          title: i.thuoc.tenThuoc,
                          subTitle: i.thuoc.duongDung,
                          days: i.ghiChu,
                          pills: i.soLuong.toString(),
                          unit: i.thuoc.donViTinh,
                        ),
                      SizedBox(
                        height: 20,
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
    );
  }
}
