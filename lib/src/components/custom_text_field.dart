// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? inputAction;
  final bool readOnly;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.inputFormatters,
    this.inputAction,
    this.readOnly = false,
    this.initialValue,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscure,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isSelected
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    !isObscure
                        ? Icons.visibility
                        : Icons.visibility_off_rounded,
                  ),
                )
              : null,
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textInputAction: widget.inputAction,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
      ),
    );
  }
}
