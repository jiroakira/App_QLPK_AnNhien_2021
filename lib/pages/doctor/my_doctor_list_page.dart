import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../components/my_doctor_list_item.dart';
import '../../model/doctor.dart';
import 'package:medapp/bloc/list_doctor/list_doctor_bloc.dart';

class MyDoctorListPage extends StatefulWidget {
  @override
  _MyDoctorListPageState createState() => _MyDoctorListPageState();
}

class _MyDoctorListPageState extends State<MyDoctorListPage> {
  final ListDoctorBloc listDoctorBloc = ListDoctorBloc();

  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDoctorBloc.add(GetAllDoctor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh Sách Bác Sĩ',
        ),
      ),
      body: BlocProvider(
        create: (context) => listDoctorBloc,
        child: BlocBuilder<ListDoctorBloc, ListDoctorState>(
          builder: (context, state) {
            if (state is ListDoctorLoading) {
              _timer?.cancel();
              EasyLoading.show(
                status: 'Đang tải...',
              );
            }
            if (state is ListDoctorEmpty) {
              _timer?.cancel();
              EasyLoading.dismiss();
            }
            if (state is ListDoctorLoaded) {
              _timer?.cancel();
              EasyLoading.dismiss();
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                itemCount: state.doctorBody.data.length,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                itemBuilder: (context, index) {
                  return MyDoctorListItem(
                    listDoctorBody: state.doctorBody.data[index],
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
