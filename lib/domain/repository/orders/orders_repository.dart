import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/domain/result/orders/orders_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: getOrdersEndPoint,
      method: HttpAbstractMethod.post,
      body: {'user': userId},
      headers: {'X-Parse-Session-Token': token},
    );

    if (result['result'] != null) {
      final List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map((order) => OrderModel.fromJson(order))
              .toList();

      return OrdersResult.success(orders);
    } else {
      return OrdersResult.error('Error requesting data from lasts orders');
    }
  }
}
