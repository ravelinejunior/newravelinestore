import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class HomeItemTile extends StatelessWidget {
  HomeItemTile({
    Key? key,
    required this.itemModel,
    required this.cartAnimationMethod,
  }) : super(key: key);

  final ItemModel itemModel;
  final void Function(GlobalKey) cartAnimationMethod;
  final GlobalKey imageGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final UtilsService utilsService = UtilsService();
    return Stack(
      children: [
        InkWell(
          splashColor: Colors.teal.shade100,
          onTap: () =>
              Get.toNamed(ConstantsRoutes.detailRoute, arguments: itemModel),
          child: Card(
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // image
                  Expanded(
                    child: Hero(
                      child: Image.asset(
                        itemModel.imgUrl,
                        key: imageGlobalKey,
                      ),
                      tag: Random(100000000),
                    ),
                  ),
                  // name
                  Text(
                    itemModel.itemName,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  // price

                  Row(
                    children: [
                      Text(
                        utilsService.priceToCurrencyString(itemModel.price),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "/${itemModel.unit}",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () {
              cartAnimationMethod(imageGlobalKey);
            },
            child: Container(
              height: 48,
              width: 40,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          top: 4,
          right: 4,
        ),
      ],
    );
  }
}
