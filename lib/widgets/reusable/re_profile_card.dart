import 'package:flutter/material.dart';
import 'package:mdtestapp/widgets/global/button.dart';

class ReProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final bool verified;
  final VoidCallback onSendVerification;

  const ReProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.verified,
    required this.onSendVerification,
  });

  static const primarySoftBlue = Color(0xFF5B8CFF);

  @override
  Widget build(BuildContext context) {
    final statusColor = verified
        ? const Color(0xFF34C759)
        : const Color(0xFFFF4D4F);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6ECFF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: primarySoftBlue.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: primarySoftBlue,
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: statusColor.withOpacity(0.25),
                        ),
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
                    const SizedBox(width: 10),
                    if (!verified)
                      GTextAction(
                        label: "Send Verification",
                        onPressed: onSendVerification,
                        color: primarySoftBlue,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
