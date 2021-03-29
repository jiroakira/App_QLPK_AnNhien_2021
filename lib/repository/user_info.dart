import 'package:medapp/api/user_service.dart';
import 'package:medapp/model/user/user_info.dart';

class UserInfoRepository {
  final UserApiServices userApiServices = UserApiServices();

  Future<UserInforBody> getUserInfo() async {
    return await userApiServices.getUserInfo();
  }
}
