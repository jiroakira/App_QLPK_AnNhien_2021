import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../components/labeled_text_form_field.dart';
import '../../../utils/constants.dart';

class InputWidget extends StatefulWidget {
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _fullnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledTextFormField(
                title: 'Họ Ten'.tr(),
                controller: _fullnameController,
                hintText: 'Jiro Akira',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledTextFormField(
                title: 'Số Điện Thoại'.tr(),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                hintText: '0888989495',
              ),
              LabeledTextFormField(
                title: "Mật Khẩu".tr(),
                controller: _passwordController,
                obscureText: true,
                hintText: '* * * * * *',
              ),
              LabeledTextFormField(
                title: "Mật".tr(),
                controller: _passwordController,
                obscureText: true,
                hintText: '* * * * * *',
              ),
              LabeledTextFormField(
                title: 'Xác Nhận Mật Khẩu'.tr(),
                controller: _confirmPasswordController,
                obscureText: true,
                hintText: '* * * * * *',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
