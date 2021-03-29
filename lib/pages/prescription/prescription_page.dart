import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/custom_profile_item.dart';
import '../../routes/routes.dart';
import 'package:medapp/bloc/prescription/prescription_bloc.dart';

class PrescriptionPage extends StatefulWidget {
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> with AutomaticKeepAliveClientMixin<PrescriptionPage> {
  final ListPrescriptionBloc _listPrescriptionBloc = ListPrescriptionBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listPrescriptionBloc.add(GetListPrescription());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlocProvider(
        create: (context) => _listPrescriptionBloc,
        child: BlocBuilder<ListPrescriptionBloc, PrescriptionState>(
          builder: (context, state) {
            if (state is PrescriptionEmpty) {
              return Center(
                child: Text('Bạn Chưa Có Danh Sách Đơn Thuốc'),
              );
            }
            if (state is PrescriptionLoaded) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var i in state.listPrescriptionBody.data)
                      CustomProfileItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.prescriptionDetail, arguments: i.id.toString());
                        },
                        title: i.maDonThuoc,
                        subTitle: "Mã Bệnh Nhân: ${state.listPrescriptionBody.benhNhan}",
                        // subTitle2: i.id.toString(),
                        buttonTitle: 'Xem Thêm',
                        imagePath: 'assets/images/icon_medical_recipe.png',
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    // CustomProfileItem(
                    //   onTap: () {},
                    //   title: 'Tuberculosis Recipe',
                    //   subTitle: 'Jiro Akira',
                    //   subTitle2: 'Given at 14/02/2019',
                    //   buttonTitle: 'See Prescription',
                    //   imagePath: 'assets/images/icon_medical_recipe.png',
                    // ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Loix"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
