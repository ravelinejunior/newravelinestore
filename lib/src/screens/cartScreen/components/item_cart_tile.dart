import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/src/components/quantity_custom_widget.dart';

class ItemCartTile extends StatefulWidget {
  const ItemCartTile({
    Key? key,
    required this.cartItem,
    required this.function,
  }) : super(key: key);
  final CartItemModel cartItem;
  final Function(CartItemModel cartItem) function;

  @override
  State<ItemCartTile> createState() => _ItemCartTileState();
}

class _ItemCartTileState extends State<ItemCartTile> {
  @override
  Widget build(BuildContext context) {
    final utilService = UtilsService();
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        //Image
        leading: Image.asset(
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
            setState(() {
              widget.cartItem.quantity = quantity;

              if (quantity == 0) {
                //Remove item
                widget.function(widget.cartItem);
              }
            });
          },
        ),
      ),
    );
  }
}
