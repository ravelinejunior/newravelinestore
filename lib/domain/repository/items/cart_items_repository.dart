import 'dart:developer';

import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:retrofit/http.dart';

class CartItemsRepository {
  final _httpManager = HttpManager();

  Future getCartItems({
    required String? token,
    required String? userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: getCartItemsEndPoint,
      method: HttpAbstractMethod.post,
      headers: {'X-Parse-Session-Token': token},
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      //Treat data
      log(result['result'].toString(), name: 'Data_Cart_Items');
    } else {
      //Return message
      log(result['result'], name: 'Data_Cart_Items_Error');
    }
  }
}
