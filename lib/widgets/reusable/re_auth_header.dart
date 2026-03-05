import 'package:flutter/material.dart';
import 'package:mdtestapp/widgets/global/text.dart';

class ReAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ReAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.lock_outline_rounded,
  });

  static const primarySoftBlue = Color(0xFF5B8CFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primarySoftBlue.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: primarySoftBlue.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: primarySoftBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GText.title(title),
                const SizedBox(height: 4),
                GText.subtitle(subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
