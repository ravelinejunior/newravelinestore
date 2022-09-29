import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';

class OrdersTile extends StatelessWidget {
  const OrdersTile({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final UtilsService utilsService = UtilsService();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pedido ${order.id}',
              ),
              Text(
                utilsService.formatDateTime(order.dateCreated),
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
