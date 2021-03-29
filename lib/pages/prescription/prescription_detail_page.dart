import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/bloc/prescription/prescription_bloc.dart';

import '../../components/custom_recipe_item.dart';

class PrescriptionDetailPage extends StatefulWidget {
  final String argument;

  PrescriptionDetailPage({this.argument});

  @override
  _PrescriptionDetailPageState createState() => _PrescriptionDetailPageState();
}

class _PrescriptionDetailPageState extends State<PrescriptionDetailPage> {
  final SinglePrescriptionBloc _singlePrescriptionBloc = SinglePrescriptionBloc();

  @override
  void initState() {
    // TODO: implement initState
    _singlePrescriptionBloc.add(GetPrescription(donThuocId: widget.argument.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
        title: Text(
          'Chi Tiết Đơn Thuốc',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocProvider(
          create: (context) => _singlePrescriptionBloc,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: BlocBuilder<SinglePrescriptionBloc, PrescriptionState>(
              builder: (context, state) {
                if (state is SinglePrescriptionLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SinglePrescriptionLoaded) {
                  if (state.prescriptionBody.data != null) {
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
