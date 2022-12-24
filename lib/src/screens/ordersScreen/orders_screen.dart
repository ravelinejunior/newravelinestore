import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/domain/controller/orders_controller.dart';
import 'package:newravelinestore/src/screens/ordersScreen/components/orders_tile.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: GetBuilder<OrdersController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: controller.getAllOrders,
          displacement: 13,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          edgeOffset: 14.6,
          color: Colors.teal,
          strokeWidth: 3,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final order = controller.allOrders[index];
              return OrdersTile(order: order);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: controller.allOrders.length,
          ),
        );
      }),
    );
  }
}
