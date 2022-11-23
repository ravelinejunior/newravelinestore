import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/data/model/category_model.dart';
import 'package:newravelinestore/domain/repository/home/home_repository.dart';
import 'package:newravelinestore/domain/result/home/home_result.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxBool isLoading = false.obs;
  List<CategoryModel> allCategories = [];

  @override
  onInit() {
    super.onInit();

    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoadingState();
    final HomeResult<CategoryModel> homeResult =
        await _homeRepository.getCategories();
    setLoadingState();

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        debugPrint('All Categories $allCategories}');
      },
      error: (message) {
        setErrorSnackbar(
          'Error',
          message,
        );
      },
    );
  }

  void setLoadingState() {
    isLoading.update((loading) {
      isLoading.value = !loading!;
    });
  }
}
