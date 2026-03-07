import 'package:flutter/material.dart';

class Characteristic extends StatelessWidget {
  final String label;
  final int? value;

  const Characteristic({
    super.key,
    required this.label,
    required this.value,
  });

  Color getColor(int rating) {
      if (rating >= 4) return Colors.green;
      if (rating >= 3) return Colors.orange;
      return Colors.red;
    }

  @override
  Widget build(BuildContext context) {
    if (value == null) return const SizedBox.shrink();

    final color = getColor(value!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$value/5',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}