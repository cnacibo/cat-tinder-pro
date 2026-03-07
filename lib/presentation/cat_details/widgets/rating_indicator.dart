import 'package:flutter/material.dart';

class RatingIndicator extends StatelessWidget {
  final String title;
  final int? value;

  const RatingIndicator({super.key, required this.title, this.value});

  Color getColor(double value) {
    if (value >= 0.8) return Colors.green;
    if (value >= 0.6) return Colors.lightGreen;
    if (value >= 0.4) return Colors.orange;
    return Colors.red;
  }

  String _getRatingText(int value) {
    switch (value) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Medium';
      case 4:
        return 'High';
      case 5:
        return 'Very High';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) return const SizedBox.shrink();

    final double percentage = value! / 5;

    final color = getColor(percentage);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < value! ? Icons.star : Icons.star_border,
                        size: 16,
                        color: index < value! ? color : Colors.grey.shade300,
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$value/5',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              Container(
                height: 28,
                width: (MediaQuery.of(context).size.width - 88) * percentage,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.8),
                      color,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    _getRatingText(value!),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}