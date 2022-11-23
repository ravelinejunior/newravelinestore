import 'package:newravelinestore/data/model/category_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/domain/result/home/home_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  Future<HomeResult> getCategories() async {
    final result = await _httpManager.restRequest(
      url: getCategoriesEndPoint,
      method: HttpAbstractMethod.post,
    );
    if (result['result'] != null) {
      //Success
      List<CategoryModel> data =
          (result['result'] as List<Map<String, dynamic>>)
              .map((json) => CategoryModel.fromMap(json))
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      //Error
      return HomeResult.error('Something went wrong. Please try again!');
    }
  }
}
