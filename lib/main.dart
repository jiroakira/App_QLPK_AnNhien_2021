import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/components/utils/screen_size.dart';
import 'package:medapp/pages/custom_animation.dart';
import 'package:medapp/pages/home/home.dart';
import 'routes/route_generator.dart';
import 'routes/routes.dart';
import 'utils/themebloc/theme_bloc.dart';
import 'bloc/authentication/authentication.dart';

import 'pages/login/login_page.dart';
import 'package:medapp/pages/splash_page.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(
      EasyLocalization(
        child: MyApp(),
        supportedLocales: [
          Locale('en', 'US'),

          // Locale('es', 'ES'),
          // Locale('it', 'IT'),
          // Locale('pt', 'PT'),
          //Locale('fr', 'FR'),
        ],
        path: 'assets/languages',
      ),
    );

    configLoading();
  } catch (e) {}
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 25.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    bool _isAlreadyLoggedIn = _sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyIsLogin)
        ? _sharedPreferencesManager.getBool(SharedPreferencesManager.keyIsLogin)
        : false;

    // bool _isAlreadyLoggedIn = false;

    return MaterialApp(
      builder: (context, child) {
        // return ScrollConfiguration(
        //   behavior: MyBehavior(),
        //   child: child,
        // );
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        ScreenUtil.init(
          context,
          designSize: Size(width, height),
          allowFontScaling: true,
        );
        return FlutterEasyLoading(
            child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: child,
        ));
      },
      title: 'Medotis Pharma',
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // DefaultCupertinoLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: {
        Locale('vi', 'VI'),
      },
      locale: EasyLocalization.of(context).locale,
      debugShowCheckedModeBanner: false,
      theme: state.themeData,
      home: _isAlreadyLoggedIn ? Home() : LoginPage(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
