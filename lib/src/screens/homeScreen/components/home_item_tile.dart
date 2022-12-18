import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/domain/controller/cart_controller.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class HomeItemTile extends StatefulWidget {
  const HomeItemTile({
    Key? key,
    required this.itemModel,
    required this.cartAnimationMethod,
  }) : super(key: key);

  final ItemModel itemModel;
  final void Function(GlobalKey) cartAnimationMethod;

  @override
  State<HomeItemTile> createState() => _HomeItemTileState();
}

class _HomeItemTileState extends State<HomeItemTile> {
  final GlobalKey imageGlobalKey = GlobalKey();

  IconData iconTile = Icons.add_shopping_cart_rounded;
  final cartController = Get.find<CartController>();

  Future<void> switchIcons() async {
    setState(() => iconTile = Icons.check);
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() => iconTile = Icons.add_shopping_cart_rounded);
  }

  @override
  Widget build(BuildContext context) {
    final UtilsService utilsService = UtilsService();
    return Stack(
      children: [
        InkWell(
          splashColor: Colors.teal.shade100,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.toNamed(
              ConstantsRoutes.detailRoute,
              arguments: widget.itemModel,
            );
          },
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
                      child: !widget.itemModel.imgUrl
                              .contains('assets/images/fruits')
                          ? Image.network(
                              widget.itemModel.imgUrl,
                              key: imageGlobalKey,
                            )
                          : Image.asset(
                              widget.itemModel.imgUrl,
                              key: imageGlobalKey,
                            ),
                      tag: Random(100000000),
                    ),
                  ),
                  // name
                  Text(
                    widget.itemModel.itemName,
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
                        utilsService
                            .priceToCurrencyString(widget.itemModel.price),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "/${widget.itemModel.unit}",
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Material(
              child: InkWell(
                splashColor: Colors.teal.shade100,
                onTap: () {
                  cartController.addItemToCart(item: widget.itemModel);
                  widget.cartAnimationMethod(imageGlobalKey);
                  switchIcons();
                },
                child: Ink(
                  height: 48,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Icon(
                    iconTile,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
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
