import 'package:flutter/material.dart';

class GDropdownItem<T> {
  final T value;
  final String label;

  const GDropdownItem({required this.value, required this.label});
}

class GDropdown<T> extends StatelessWidget {
  final T value;
  final List<GDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final IconData? prefixIcon;

  const GDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.prefixIcon,
  });

  static const primarySoftBlue = Color(0xFF5B8CFF);
  static const cardBorder = Color(0xFFE6ECFF);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      isExpanded: true,
      icon: const Icon(Icons.expand_more_rounded),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor: const Color(0xFFF8FAFF),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primarySoftBlue, width: 1.6),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem<T>(value: e.value, child: Text(e.label)))
          .toList(),
    );
  }
}
