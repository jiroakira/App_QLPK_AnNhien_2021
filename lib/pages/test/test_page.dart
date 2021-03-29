// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/bloc/checkup_process.dart/checkup_process_bloc.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';
import 'package:medapp/components/event_card/event_card.dart';

// import '../../components/custom_profile_item.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with AutomaticKeepAliveClientMixin<TestPage> {
  final CheckupProcessBloc _checkupProcessBloc = CheckupProcessBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkupProcessBloc.add(GetCheckupProcesses());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlocProvider(
        create: (context) => _checkupProcessBloc,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: BlocBuilder<CheckupProcessBloc, CheckupProcessState>(
            builder: (context, state) {
              if (state is CheckupProcessEmpty) {
                return Center(
                  child: Text('Bạn Không Có Chuỗi Khám Nào Hiện Tại'),
                );
              }
              if (state is CheckupProcessLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var i in state.checkupProcessModel.data)
                      EventCard(
                        event: i.dichVuKham.tenDvkt,
                        time: i.dichVuKham.maDvkt,
                        secondaryColor: SchoolToolkitColors.lighterGrey,
                        primaryColor: SchoolToolkitColors.grey,
                      ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Loi'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
