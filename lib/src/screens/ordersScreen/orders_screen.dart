import 'package:flutter/material.dart';
import 'package:newravelinestore/src/screens/ordersScreen/components/orders_tile.dart';
import 'package:newravelinestore/src/utils/app_data.dart' as app_data;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final order = app_data.ordersModel[index];
          return OrdersTile(order: order);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: app_data.ordersModel.length,
      ),
    );
  }
}
