import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  Future<void> getCategories() async {
    final result = await _httpManager.restRequest(
      url: getCategoriesEndPoint,
      method: HttpAbstractMethod.post,
    );
    if (result['result'] != null) {
      //Success
    } else {
      //Error
    }
  }
}
