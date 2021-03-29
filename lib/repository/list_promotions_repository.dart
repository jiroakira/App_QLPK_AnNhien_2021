import 'package:medapp/api/list_promotions.dart';
import 'package:medapp/model/list_promotions.dart';

class ListPromotionsRepository {
  final ListPromotionsProvider listPromotionsProvider = ListPromotionsProvider();
  Future<ListPromotions> getListPromotions() async {
    return await listPromotionsProvider.getListPromotions();
  }
}
