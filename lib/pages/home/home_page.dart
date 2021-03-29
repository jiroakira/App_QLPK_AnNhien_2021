import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/bloc/appointment/appointment_bloc.dart';
import 'package:medapp/components/utils/screen_size.dart';
import '../../routes/routes.dart';
import 'widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/bloc/appointment/appointment.dart';
import 'package:medapp/bloc/prescription/prescription_bloc.dart';
import 'package:medapp/model/token/token.dart';

class HomePage extends StatefulWidget {
  final ResponseTokenBody responseTokenBody;

  HomePage({Key key, this.responseTokenBody}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  final bool _noAppoints = false;
  final AppointmentBloc appointmentBloc = AppointmentBloc();
  // final VisitedDoctorBloc visitedDoctorBloc = VisitedDoctorBloc();
  final LatestPrescriptionBloc latestPrescriptionBloc = LatestPrescriptionBloc();

  // final ListPrescriptionBloc _listPrescriptionBloc = ListPrescriptionBloc();

  @override
  void initState() {
    appointmentBloc.add(GetUpcomingAppointment());
    latestPrescriptionBloc.add(GetLatestPrescription());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (ScreenUtil() == null) {
      ScreenUtil.init(
        context,
        designSize: Size(
          ScreenSize.width,
          ScreenSize.height,
        ),
        allowFontScaling: true,
      );
    }

    return SingleChildScrollView(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => appointmentBloc,
          ),
          BlocProvider(
            create: (context) => latestPrescriptionBloc,
          )
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/images/hand.png'),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${'Xin Chào'} ${widget.responseTokenBody.userData.hoTen},',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Text(
                          'Hôm nay bạn như thế nào?'.tr(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _noAppoints
                  ? NoAppointmentsWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              SectionHeaderWidget(
                                title: 'Lịch Hẹn Sắp Tới'.tr(),
                              ),
                              BlocBuilder<AppointmentBloc, AppointmentState>(
                                builder: (context, state) {
                                  if (state is AppointmentLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is AppointmentEmpty) {
                                    return NoAppointmentsWidget();
                                  }
                                  if (state is AppointmentLoaded) {
                                    return NextAppointmentWidget(
                                      time: DateFormat("dd-MM-yyyy hh:mm:ss")
                                          .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(state.upcomingVisit.data.thoiGianBatDau)),
                                      patient: state.upcomingVisit.data.benhNhan.hoTen,
                                      doctor: "Người Phụ Trách: " + state.upcomingVisit.data.nguoiPhuTrach.hoTen,
                                    );
                                  } else {
                                    return NoAppointmentsWidget();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SectionHeaderWidget(
                                title: "Đơn Thuốc Của Bạn".tr(),
                                onPressed: () => Navigator.of(context).pushNamed(Routes.prescriptionPage),
                              ),
                              BlocBuilder<LatestPrescriptionBloc, PrescriptionState>(
                                builder: (context, state) {
                                  if (state is LatestPrescriptionLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is LatestPrescriptionEmpty) {
                                    return Center(
                                      child: Text("Bạn Chưa Có Đơn Thuốc Gần Đây"),
                                    );
                                  }

                                  if (state is LatestPrescriptionLoaded) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.prescriptionDetail, arguments: state.latestPrescription.data.id.toString());
                                      },
                                      child: TestAndPrescriptionCardWidget(
                                        title: "Mã Đơn Thuốc: " + state.latestPrescription.data.maDonThuoc,
                                        subTitle: '${'Kê Đơn Bởi'.tr()} Bác Sĩ: ${state.latestPrescription.data.bacSiKeDon}',
                                        image: 'icon_medical_recipe.png',
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text('Khong Co Don Thuoc Moi'),
                                    );
                                  }
                                },
                              ),
                              //test results
                              SectionHeaderWidget(
                                title: 'Kết Quả Kiểm Tra'.tr(),
                                onPressed: () {},
                              ),
                              TestAndPrescriptionCardWidget(
                                title: 'Mã Kết Quả: MN-152',
                                subTitle: '12-12-2020',
                                image: 'icon_medical_check_up.png',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
