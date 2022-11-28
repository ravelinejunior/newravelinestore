import 'package:get/get.dart';
import 'package:newravelinestore/data/model/category_model.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/domain/repository/home/home_repository.dart';
import 'package:newravelinestore/domain/result/home/home_result.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxBool isCategoryLoading = false.obs;
  RxBool isProductsLoading = false.obs;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.items.length * itemsPerPage > allProducts.length;
  }

  @override
  onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setCategoryLoadingState(true);
    final HomeResult<CategoryModel> homeResult =
        await _homeRepository.getCategories();
    setCategoryLoadingState(false);

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
    setProductsLoadingState(true);

    final Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    final HomeResult<ItemModel> result =
        await _homeRepository.getAllProducts(body);
    setProductsLoadingState(false);

    result.when(
      success: (data) {
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        setErrorSnackbar(
          'Error',
          message,
        );
      },
    );
  }

  void setCategoryLoadingState(bool value) {
    isCategoryLoading.value = value;
    update();
  }

  void setProductsLoadingState(bool value) {
    isProductsLoading.value = value;
    update();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts();
  }
}
