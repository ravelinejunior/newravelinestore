import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/data/model/category_model.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/domain/repository/home/home_repository.dart';
import 'package:newravelinestore/domain/result/home/home_result.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';
import 'package:newravelinestore/src/utils/app_data.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxBool isCategoryLoading = false.obs;
  RxBool isProductsLoading = false.obs;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  RxString searchTitle = "".obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.items.length * itemsPerPage > allProducts.length;
  }

  @override
  onInit() {
    super.onInit();

    debounce(
      searchTitle,
      (_) {
        update();
      },
      time: const Duration(
        milliseconds: 500,
      ),
    );

    getAllCategories();
  }

  void filterByTitle() {
    //Erase all the products from categories
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      final CategoryModel? c = allCategories.firstWhereOrNull(
        (_category) => _category.id == '',
      );

      if (c == null) {
        //Create a new category with all products
        final allProductsCategory = CategoryModel(
          items: items,
          pagination: 0,
          title: 'All',
          id: '',
        );

        allCategories.insert(0, allProductsCategory);
      } else {
        //Remove all items because products already exists
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = allCategories.first;
    update();
    getAllProducts();
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

  void setSearchTitle(String value) {
    searchTitle.value = value;
  }
}
