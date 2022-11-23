import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/data/model/category_model.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/domain/repository/home/home_repository.dart';
import 'package:newravelinestore/domain/result/home/home_result.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxBool isLoading = false.obs;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  @override
  onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoadingState(true);
    final HomeResult<CategoryModel> homeResult =
        await _homeRepository.getCategories();
    setLoadingState(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      },
      error: (message) {
        setErrorSnackbar(
          'Error',
          message,
        );
      },
    );
  }

  Future<void> getAllProducts() async {
    setLoadingState(true);

    final Map<String, dynamic> body = {
      'page': 0,
      'title': null,
      'categoryId': '5mjkt5ERRo',
      'itemsPerPage': 6
    };

    final HomeResult<ItemModel> result =
        await _homeRepository.getAllProducts(body);
    setLoadingState(false);

    result.when(
      success: (data) {
        debugPrint(data.toString());
      },
      error: (message) {
        setErrorSnackbar(
          'Error',
          message,
        );
      },
    );
  }

  void setLoadingState(bool value) {
    isLoading.value = value;
    update();
  }
}
