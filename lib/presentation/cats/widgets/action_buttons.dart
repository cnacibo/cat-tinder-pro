import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onLike;

  const ActionButtons({super.key, required this.onDislike, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          context,
          icon: Icons.close,
          color: Color(0xFFBF0603),
          onTap: onDislike,
        ),
        _buildActionButton(
          context,
          icon: Icons.favorite,
          color: Color(0xFF386641),
          onTap: onLike,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context,{
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, 
          shape: BoxShape.circle,
          border: Border.all(
            color: color, 
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 30), 
      ),
    );
  }
}