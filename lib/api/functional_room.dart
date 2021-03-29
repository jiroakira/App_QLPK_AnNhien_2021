import 'package:dio/dio.dart';
import 'package:medapp/model/functional_room/functional_room.dart';
import 'package:medapp/utils/constants.dart';

class FuncRoomProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;

  FuncRoomProvider() {
    _dio.options.baseUrl = _baseUrl;
  }

  Future<FunctionalRoom> getAllFuncRoom() async {
    final response = await _dio.get('api/danh_sach_phong_chuc_nang/');
    final json = response.data;
    return FunctionalRoom.fromJson(json);
  }
}
