import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medapp/pages/empty_page.dart';
import 'package:medapp/pages/func_room.dart/funcroom.dart';
import 'package:medapp/pages/newBooking/new_booking_page.dart';
import 'package:medapp/pages/newBooking/new_update_booking.dart';
import 'package:medapp/pages/prescription/examination_prescription.dart';
import 'package:medapp/pages/profile/doctor_profile.dart';
import 'package:medapp/pages/profile/profile.dart';
import 'package:medapp/pages/profile/update_profile.dart';
import 'package:medapp/pages/promotions.dart/promotions_detail.dart';
import 'package:medapp/pages/user_checkup/funcroom_info.dart';
import 'package:medapp/pages/user_checkup/my_checkup.dart';
import 'package:medapp/pages/visit/invoice.dart';
import 'package:medapp/pages/visit/latest_visit_detail.dart';
import 'package:medapp/pages/visit/test_html.dart';
import 'package:medapp/pages/visit/test_results.dart';
import 'package:medapp/pages/visit/visit_page.dart';

import '../pages/appointment/appointment_detail_page.dart';
import '../pages/appointment/my_appointments_page.dart';
import '../pages/booking/filter/filter_page.dart';
import '../pages/booking/step1/health_concern_page.dart';
import '../pages/booking/step2/choose_doctor_page.dart';
import '../pages/booking/step3/time_slot_page.dart';
import '../pages/booking/step4/patient_details_page.dart';
import '../pages/booking/step5/appointment_booked_page.dart';
import '../pages/doctor/doctor_profile_page.dart';
import '../pages/doctor/my_doctor_list_page.dart';
import '../pages/forgot/forgot_password_page.dart';
import '../pages/home/home.dart';
import '../pages/language/change_laguage_page.dart';
import '../pages/login/login_page.dart';
import '../pages/messages/messages_detail_page.dart';
import '../pages/notifications/notification_settings_page.dart';
import '../pages/notifications/notifications_page.dart';
import '../pages/prescription/prescription_detail_page.dart';
import '../pages/profile/edit_profile_page.dart';
import '../pages/signup/signup_page.dart';
import '../pages/splash_page.dart';
import '../pages/visit/visit_detail_page.dart';
import 'routes.dart';
import 'package:medapp/repository/login.dart';
import 'package:medapp/pages/appointment/book_appointment.dart';
import 'package:medapp/pages/prescription/prescription_page.dart';
import 'package:medapp/pages/loading/loading.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    final loginRepository = LoginRepository();
    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashPage());

      case Routes.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());

      case Routes.signup:
        return CupertinoPageRoute(builder: (_) => SignupPage());

      case Routes.forgotPassword:
        return CupertinoPageRoute(builder: (_) => ForgotPasswordPage());

      case Routes.home:
        return CupertinoPageRoute(
          builder: (_) => Home(
            responseTokenBody: args,
          ),
        );

      case Routes.filter:
        return CupertinoPageRoute(
          builder: (_) => FilterPage(),
          fullscreenDialog: true,
        );

      case Routes.bookingStep1:
        return CupertinoPageRoute(
          builder: (_) => HealthConcernPage(),
          fullscreenDialog: true,
        );

      case Routes.bookingStep2:
        return CupertinoPageRoute(builder: (_) => ChooseDoctorPage());

      case Routes.bookingStep3:
        return CupertinoPageRoute(builder: (_) => TimeSlotPage());

      case Routes.bookingStep4:
        return CupertinoPageRoute(builder: (_) => PatientDetailsPage());

      case Routes.bookingStep5:
        return CupertinoPageRoute(builder: (_) => AppointmentBookedPage());

      case Routes.bookAppointment:
        return CupertinoPageRoute(builder: (_) => BookTimePage());

      case Routes.appointmentDetail:
        return CupertinoPageRoute(builder: (_) => AppointmentDetailPage());

      case Routes.visitDetail:
        return CupertinoPageRoute(
          builder: (_) => VisitDetailPage(
            screenArguments: args,
          ),
        );

      case Routes.latestVisitDetail:
        return CupertinoPageRoute(
          builder: (_) => LatestVisitDetail(
            argument: args,
          ),
        );

      case Routes.prescriptionDetail:
        return CupertinoPageRoute(
          builder: (_) => PrescriptionDetailPage(
            argument: args,
          ),
        );

      case Routes.chatDetail:
        return CupertinoPageRoute(builder: (_) => MessagesDetailPage());

      case Routes.doctorProfile:
        return CupertinoPageRoute(builder: (_) => DoctorProfilePage());

      case Routes.editProfile:
        return CupertinoPageRoute(builder: (_) => EditProfilePage());

      case Routes.changeLanguage:
        return CupertinoPageRoute(builder: (_) => ChangeLanguagePage());

      case Routes.notificationSettings:
        return CupertinoPageRoute(builder: (_) => NotificationSettingsPage());

      case Routes.myDoctors:
        return CupertinoPageRoute(builder: (_) => MyDoctorListPage());

      case Routes.myAppointments:
        return CupertinoPageRoute(builder: (_) => MyAppointmentsPage());

      case Routes.prescriptionPage:
        return CupertinoPageRoute(builder: (_) => PrescriptionPage());

      case Routes.newBookingPage:
        return CupertinoPageRoute(builder: (_) => NewBookingPage());

      case Routes.newUpdateBookingPage:
        return CupertinoPageRoute(
          builder: (_) => UpdateBookingPage(
            upcoming: args,
          ),
        );

      case Routes.userProfile:
        return CupertinoPageRoute(builder: (_) => UserProfile());

      case Routes.newCheckupPage:
        return CupertinoPageRoute(builder: (_) => MyCheckupProcess());

      case Routes.visitPage:
        return CupertinoPageRoute(builder: (_) => VisitPage());

      case Routes.funcRoom:
        return CupertinoPageRoute(builder: (_) => FuncRoomPage());

      case Routes.updateProfile:
        return CupertinoPageRoute(
          builder: (_) => UpdateProfilePage(
            userInforBody: args,
          ),
        );

      case Routes.doctorProfileDetail:
        return CupertinoPageRoute(
          builder: (_) => DoctorProfile(
            doctorBody: args,
          ),
        );

      case Routes.promotionDetail:
        return CupertinoPageRoute(
          builder: (_) => PromotionDetail(
            argument: args,
          ),
        );

      case Routes.examinationPrescription:
        return CupertinoPageRoute(
          builder: (_) => ExaminationPrescriptionPage(
            argument: args,
          ),
        );

      case Routes.invoice:
        return CupertinoPageRoute(
          builder: (_) => ExamInvoicePage(
            screenArguments: args,
          ),
        );

      case Routes.funcroomInfo:
        return CupertinoPageRoute(
          builder: (_) => FuncroomInfoPage(
            argument: args,
          ),
        );

      case Routes.emptyPage:
        return CupertinoPageRoute(
          builder: (_) => EmptyPage(),
        );

      case Routes.notifications:
        return CupertinoPageRoute(
          builder: (_) => NotificationsPage(),
          fullscreenDialog: true,
          maintainState: true,
        );

      case Routes.loading:
        return MaterialPageRoute(
          builder: (_) => Loading(),
        );

      case Routes.testResult:
        return MaterialPageRoute(
          builder: (_) => TestResult(
            argument: args,
          ),
        );

      case Routes.testHtml:
        return MaterialPageRoute(
          builder: (_) => TestHtml(
            argument: args,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
