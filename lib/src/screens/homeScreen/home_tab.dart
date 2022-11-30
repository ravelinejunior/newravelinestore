import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/domain/controller/home_controller.dart';
import 'package:newravelinestore/src/components/custom_shimmer.dart';
import 'package:newravelinestore/src/screens/homeScreen/components/home_item_tile.dart';
import 'package:newravelinestore/src/utils/constants.dart';

import 'components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectectedCategory = 'Meats';
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  final homeController = Get.find<HomeController>();

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(
                text: 'Raveline',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              TextSpan(
                text: 'Grocery',
                style: TextStyle(
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Badge(
              badgeColor: Colors.red[700] ?? Colors.red,
              badgeContent: Text(
                '2',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              child: AddToCartIcon(
                key: gkCart,
                icon: Icon(
                  Icons.shopping_bag,
                  color: Colors.teal[600],
                ),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        gkCart: gkCart,
        rotation: true,
        dragToCardCurve: Curves.easeIn,
        dragToCardDuration: const Duration(milliseconds: 1000),
        previewCurve: Curves.easeOut,
        previewDuration: const Duration(milliseconds: 500),
        previewHeight: 30,
        previewWidth: 30,
        opacity: 0.85,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
          children: [
            //Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextFormField(
                onChanged: (value) {
                  homeController.setSearchTitle(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: hintTextSearchHomeString,
                  hintStyle: GoogleFonts.lato(color: Colors.grey.shade400),
                  prefixIcon:
                      Icon(Icons.search, color: Colors.red[700], size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),

            //Categories
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.only(left: 16),
                  height: MediaQuery.of(context).size.height / 10,
                  child: !controller.isCategoryLoading.value
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CategoryTile(
                            category: controller.allCategories[index].title
                                .toString(),
                            isSelected: controller.allCategories[index] ==
                                controller.currentCategory,
                            onPressed: () {
                              controller.selectCategory(
                                controller.allCategories[index],
                              );
                            },
                          ),
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 8),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (_) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 16,
                              ),
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width / 6,
                                isRounded: true,
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          )),
                );
              },
            ),

            //GridView
            GetBuilder<HomeController>(builder: (controller) {
              return Expanded(
                child: !controller.isProductsLoading.value
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                        ),
                        itemCount: controller.allProducts.length,
                        itemBuilder: (_, index) {
                          if (((index + 1) == controller.allProducts.length) &&
                              !controller.isLastPage) {
                            // List
                            controller.loadMoreProducts();
                          }

                          return HomeItemTile(
                            itemModel: controller.allProducts[index],
                            cartAnimationMethod: itemSelectedCartAnimation,
                          );
                        },
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                          10,
                          (_) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
