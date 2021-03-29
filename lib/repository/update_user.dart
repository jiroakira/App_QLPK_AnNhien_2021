import 'package:medapp/api/user_service.dart';
import 'package:medapp/model/token/update.dart';
import 'package:medapp/model/update_user_info/user_update_info.dart';

class UpdateUserRepository {
  final UserApiServices userApiServices = UserApiServices();

  Future<void> putUpdateUser(UpdateUserBody updateUserBody) async {
    return await userApiServices.putUpdateUser(updateUserBody);
  }

  Future<UserUpdateInfoBody> getUserUpdateInfo() async {
    return await userApiServices.getUserUpdateInfo();
  }

  Future<ResponseUserUpdateInfoBody> putUserUpdateInfoRequest(UserUpdateInfoRequestBody userUpdateInfoRequestBody) async {
    return await userApiServices.putUserUpdateInfoRequest(userUpdateInfoRequestBody);
  }
}
