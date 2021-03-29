import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medapp/model/login.dart';

import '../../../components/labeled_text_form_field.dart';
import '../../../routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/bloc/auth/login/login_bloc.dart';
import 'package:medapp/model/token/token.dart';

class InputWidget extends StatefulWidget {
  final LoginBloc loginBloc;

  const InputWidget({Key key, this.loginBloc}) : super(key: key);
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onLoginButtonPressed() {
      String so_dien_thoai = _emailController.text.trim();
      String password = _passwordController.text.trim();
      widget.loginBloc.add(
        ButtonLoginPressed(
          loginBody: LoginBody(soDienThoai: so_dien_thoai, password: password),
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {},
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledTextFormField(
                title: 'Số Điện Thoại',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: '0961218121',
              ),
              LabeledTextFormField(
                title: 'Mật Khẩu',
                controller: _passwordController,
                obscureText: true,
                hintText: '* * * * * * * *',
                padding: 0,
              ),
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.forgotPassword);
                    },
                    child: Text(
                      'Quên Mật Khẩu',
                      style: Theme.of(context).textTheme.button.copyWith(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.signup);
                    },
                    child: Text(
                      'Đăng Ký',
                      style: Theme.of(context).textTheme.button.copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
              CustomButton(
                onPressed: state is LoginLoading ? () {} : _onLoginButtonPressed,
                //
                text: 'Đăng Nhập',
                // onPressed: () {
                //   print(requestModel.toJson());
                // },
              ),
            ],
          );
        },
      ),
    );
  }

  // void _showError(String error) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(error),
  //     backgroundColor: Theme.of(context).errorColor,
  //   ));
  // }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double elevation;
  final int borderRadius;
  final EdgeInsets padding;
  final double textSize;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation ?? 0,
      fillColor: kColorBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 4)),
      child: Padding(
        padding: padding ?? const EdgeInsets.only(top: 9, bottom: 10, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style:
                  Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: textSize ?? Theme.of(context).textTheme.button.fontSize),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
