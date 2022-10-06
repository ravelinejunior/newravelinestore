import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  OrderStatus({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);
  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refund_payment': 1,
    'paid_payment': 2,
    'prepare_purchase': 3,
    'shiping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status] ?? 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusDot(
          isActive: isOverdue,
          title: 'Confirmed Order',
        ),
        const _CustomDivider(),
        if (currentStatus == 1) ...[
          const _StatusDot(
            isActive: true,
            title: 'Reversed Transaction',
            backgroundColor: Colors.orange,
          )
        ] else if (isOverdue) ...[
          const _StatusDot(
              isActive: false,
              title: 'Overdue Payment',
              backgroundColor: Colors.red),
        ]
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot(
      {Key? key,
      required this.isActive,
      required this.title,
      this.backgroundColor})
      : super(key: key);
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.teal,
            ),
            color:
                isActive ? backgroundColor ?? Colors.teal : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      alignment: Alignment.center,
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}
