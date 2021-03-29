import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'profile_info_tile.dart';
import 'package:medapp/bloc/user_info/user_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoWidget extends StatefulWidget {
  @override
  _InfoWidgetState createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  final UserInfoBloc userInfoBloc = UserInfoBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfoBloc.add(GetUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userInfoBloc,
      child: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserInfoLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Họ Tên'.tr(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    state.userInforBody.user.hoTen,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    //backgroundImage: NetworkImage(avatarUrl),
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[200],
                  indent: 15,
                  endIndent: 15,
                ),
                ProfileInfoTile(
                  title: "Số Điện Thoại",
                  trailing: state.userInforBody.user.soDienThoai,
                  hint: 'Thêm Số Điện Thoại',
                ),
                ProfileInfoTile(
                  title: "Email",
                  trailing: state.userInforBody.user.email,
                  hint: "Thêm email",
                ),
                ProfileInfoTile(
                  title: "Giới Tính",
                  trailing: state.userInforBody.user.gioiTinh,
                  hint: "Thêm Giới Tính",
                ),
                ProfileInfoTile(
                  title: "Ngày Sinh",
                  trailing: state.userInforBody.user.ngaySinh,
                  hint: "Thêm Ngày Sinh",
                ),
                ProfileInfoTile(
                  title: "CMND/CCCD",
                  trailing: state.userInforBody.user.cmndCccd,
                  hint: "Thêm CMND/CCCD",
                ),
                ProfileInfoTile(
                  title: "Địa Chỉ",
                  trailing: state.userInforBody.user.diaChi,
                  hint: "Thêm Địa Chỉ",
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Bạn Không Có Thông Tin Cá Nhân"),
            );
          }
        },
      ),
    );
  }
}
