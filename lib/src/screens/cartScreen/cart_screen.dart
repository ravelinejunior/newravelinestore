import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/src/components/payment_dialog.dart';
import 'package:newravelinestore/src/screens/cartScreen/components/item_cart_tile.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/src/utils/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItems.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double totalPrice = 0.0;
    for (var itemC in app_data.cartItems) {
      totalPrice += itemC.totalQuantity();
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final UtilsService utilsService = UtilsService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        leading: null,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                final itemCart = app_data.cartItems[index];
                return ItemCartTile(
                  cartItem: itemCart,
                  function: removeItemFromCart,
                );
              },
              separatorBuilder: (_, __) {
                return const Divider(
                  indent: 4,
                  endIndent: 4,
                  color: Colors.grey,
                );
              },
              itemCount: app_data.cartItems.length,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height / 5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    utilsService.priceToCurrencyString(cartTotalPrice()),
                    style: GoogleFonts.lato(
                      color: Colors.teal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      shadowColor: Colors.greenAccent,
                      minimumSize: const Size(50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) => PaymentDialog(
                            order: app_data.ordersModel.first,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                    ),
                    label: Text(
                      finishOrderString,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() async {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Confirmation'),
        content: const Text('Do you really want to finish your order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.greenAccent,
              minimumSize: const Size(50, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                      color: Colors.teal, style: BorderStyle.solid, width: 1)),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Yes',
              style: GoogleFonts.montserrat(color: Colors.teal[700]),
            ),
          ),
        ],
      ),
    );
  }
}
