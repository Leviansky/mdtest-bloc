import 'package:flutter/material.dart';

class ReUserTile extends StatelessWidget {
  final String name;
  final String email;
  final bool verified;

  const ReUserTile({
    super.key,
    required this.name,
    required this.email,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = verified
        ? const Color(0xFF34C759)
        : const Color(0xFFFF4D4F);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6ECFF)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF5B8CFF).withOpacity(0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            size: 18,
            color: Color(0xFF5B8CFF),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(email, style: const TextStyle(color: Color(0xFF6B7280))),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: statusColor.withOpacity(0.25)),
          ),
          child: Text(
            verified ? "Verified" : "Not Verified",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: statusColor,
            ),
          ),
        ),
      ),
    );
  }
}
