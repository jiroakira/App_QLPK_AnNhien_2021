import 'package:medapp/model/functional_room/functional_room.dart';
import 'package:medapp/api/functional_room.dart';

class FuncRoomRepository {
  final FuncRoomProvider _funcRoomProvider = FuncRoomProvider();
  Future<FunctionalRoom> getAllFuncRoom() async {
    return await _funcRoomProvider.getAllFuncRoom();
  }
}
