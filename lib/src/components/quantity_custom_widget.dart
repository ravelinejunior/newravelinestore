import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantityCustomWidget extends StatelessWidget {
  const QuantityCustomWidget({
    Key? key,
    required this.suffixTextUnit,
    required this.value,
    required this.isRemovable,
    required this.function,
  }) : super(key: key);

  final String suffixTextUnit;
  final int value;
  final bool isRemovable;
  final Function(int quantity) function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuantityButton(
            color: Colors.red[700] as Color,
            icon: Icon(
              !isRemovable || value > 1 ? Icons.remove : Icons.delete_forever,
              color: Colors.white,
              size: 16,
            ),
            callback: () {
              if (value <= 1 && !isRemovable) return;
              final result = value - 1;
              function(result);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '$value $suffixTextUnit',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          QuantityButton(
            color: Colors.teal,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
            callback: () {
              final result = value + 1;
              function(result);
            },
          )
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {Key? key,
      required this.color,
      required this.icon,
      required this.callback})
      : super(key: key);
  final Color color;
  final Icon icon;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.lime.shade800,
        borderRadius: BorderRadius.circular(40),
        onTap: callback,
        child: Ink(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
      ),
    );
  }
}
