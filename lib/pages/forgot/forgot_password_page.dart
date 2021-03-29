import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../utils/constants.dart';

class ForgotPasswordPage extends StatelessWidget {
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: ScreenUtil().setHeight(80),
                        ),
                      ),
                      Text(
                        'Quên Mật Khẩu',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      WidgetForgot(),
                      Center(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Đăng Nhập',
                            style: Theme.of(context).textTheme.button.copyWith(fontSize: ScreenUtil().setHeight(20)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WidgetForgot extends StatefulWidget {
  @override
  _WidgetForgotState createState() => _WidgetForgotState();
}

class _WidgetForgotState extends State<WidgetForgot> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Liên Hệ Phòng Khám Để Cấp Lại Mật Khẩu',
          style: kInputTextStyle,
        ),
        CustomTextFormField(
          enabled: false,
          controller: _emailController,
          hintText: '0888989495',
        ),
        SizedBox(
          height: 35,
        ),
        Text(
          'Hoặc Gửi Mail Yêu Cầu',
          style: kInputTextStyle,
        ),
        CustomTextFormField(
          enabled: false,
          controller: _emailController,
          hintText: 'info@medotis.com.vn',
        ),
        SizedBox(
          height: 35,
        ),

        // CustomButton(
        //   onPressed: () {},
        //   text: 'reset_password',
        // )
      ],
    );
  }
}
