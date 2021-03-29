import 'package:medapp/api/list_services.dart';
import 'package:medapp/model/service/list_services.dart';

class ListServicesRepository {
  final ListServiceProvider listServiceProvider = ListServiceProvider();

  Future<ListServices> getAllServices(String funcRoomId) async {
    return await listServiceProvider.getAllServices(funcRoomId);
  }
}
