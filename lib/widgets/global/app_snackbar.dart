import 'package:flutter/material.dart';

enum AppSnackType { success, error, info }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackType type = AppSnackType.info,
  }) {
    final color = _color(type);
    final icon = _icon(type);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        content: _SnackContent(message: message, color: color, icon: icon),
      ),
    );
  }

  static Color _color(AppSnackType type) {
    switch (type) {
      case AppSnackType.success:
        return const Color(0xFF34C759);
      case AppSnackType.error:
        return const Color(0xFFFF4D4F);
      case AppSnackType.info:
        return const Color(0xFF5B8CFF);
    }
  }

  static IconData _icon(AppSnackType type) {
    switch (type) {
      case AppSnackType.success:
        return Icons.check_circle_outline_rounded;
      case AppSnackType.error:
        return Icons.error_outline_rounded;
      case AppSnackType.info:
        return Icons.info_outline_rounded;
    }
  }
}

class _SnackContent extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;

  const _SnackContent({
    required this.message,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6ECFF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.35,
                color: Color(0xFF111827),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
