import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/domain/controller/cart_controller.dart';
import 'package:newravelinestore/src/components/quantity_custom_widget.dart';

class ItemCartTile extends StatefulWidget {
  const ItemCartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final CartItemModel cartItem;

  @override
  State<ItemCartTile> createState() => _ItemCartTileState();
}

class _ItemCartTileState extends State<ItemCartTile> {
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    final utilService = UtilsService();
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        //Image
        leading: !widget.cartItem.item.imgUrl.contains('assets/images/')
            ? Image.network(
                widget.cartItem.item.imgUrl,
                height: 60,
                width: 60,
              )
            : Image.asset(
                widget.cartItem.item.imgUrl,
                height: 60,
                width: 60,
              ),

        //Title
        title: Text(
          widget.cartItem.item.itemName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.fade,
        ),

        //Total
        subtitle: Text(
          utilService.priceToCurrencyString(widget.cartItem.totalQuantity()),
          style: GoogleFonts.montserrat(
            color: Colors.teal[700],
            fontWeight: FontWeight.bold,
          ),
        ),

        //Quantity
        trailing: QuantityCustomWidget(
          suffixTextUnit: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          isRemovable: true,
          function: (quantity) {
            cartController.modifyItemQuantity(
              cartItem: widget.cartItem,
              quantity: quantity,
            );
          },
        ),
      ),
    );
  }
}
