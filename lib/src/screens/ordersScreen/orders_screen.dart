import 'package:flutter/material.dart';

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
          /* final order = app_data.ordersModel[index];
          return OrdersTile(order: order); */
          return Container();
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: 0,
      ),
    );
  }
}
