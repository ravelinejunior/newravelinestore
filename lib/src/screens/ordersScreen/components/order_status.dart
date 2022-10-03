import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);
  final String status;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StatusDot(
          isActive: isOverdue,
          title: status,
        ),
        _StatusDot(
          isActive: isOverdue,
          title: status,
        ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({Key? key, required this.isActive, required this.title})
      : super(key: key);
  final bool isActive;
  final String title;

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
            color: isActive ? Colors.teal : Colors.transparent,
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
        Expanded(child: Text(title)),
      ],
    );
  }
}
