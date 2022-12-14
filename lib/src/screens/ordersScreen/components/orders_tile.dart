import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/domain/controller/items_controller.dart';
import 'package:newravelinestore/src/components/payment_dialog.dart';
import 'package:newravelinestore/src/screens/ordersScreen/components/order_status.dart';

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
        child: GetBuilder<ItemsController>(
            init: ItemsController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                initiallyExpanded: order.dateCreated!
                    .add(const Duration(minutes: 30))
                    .toLocal()
                    .isAfter(DateTime.now().toLocal()),
                onExpansionChanged: (value) {
                  if (value && order.items.isNotEmpty) {
                    controller.getAllItems();
                  }
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pedido ${order.id}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      utilsService.formatDateTime(order.dateCreated!),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isItemsLoading
                    ? [
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.teal,
                              ),
                            ),
                          ),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    addAutomaticKeepAlives: true,
                                    addRepaintBoundaries: true,
                                    shrinkWrap: true,
                                    children: order.items
                                        .map(
                                          (orderItem) => _OrderItemMapped(
                                            utilsService: utilsService,
                                            orderItem: orderItem,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                  color: Colors.grey, thickness: 2, width: 8),
                              Expanded(
                                flex: 2,
                                child: OrderStatus(
                                  status: order.status,
                                  isOverdue: order.dateOverdue.isBefore(
                                    DateTime.now().toLocal(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Total
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.montserrat(fontSize: 20),
                            children: [
                              const TextSpan(
                                text: 'Total: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: utilsService
                                    .priceToCurrencyString(order.total),
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        //Bot??o de pagamento
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal[300],
                              shadowColor: Colors.greenAccent,
                              minimumSize: const Size(35, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => PaymentDialog(order: order),
                              );
                            },
                            icon: Image.asset('assets/images/icons/pix.png',
                                height: 20),
                            label: Text(
                              'See Pix QR Code',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          replacement: Container(),
                        ),
                      ],
              );
            }),
      ),
    );
  }
}

class _OrderItemMapped extends StatelessWidget {
  const _OrderItemMapped({
    Key? key,
    required this.utilsService,
    required this.orderItem,
  }) : super(key: key);

  final UtilsService utilsService;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              orderItem.item.itemName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
          ),
          Text(
            utilsService.priceToCurrencyString(orderItem.item.price),
          ),
        ],
      ),
    );
  }
}
