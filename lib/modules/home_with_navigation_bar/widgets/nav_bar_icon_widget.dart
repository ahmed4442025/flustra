import 'package:flutter/material.dart';

class NavBarIconWidget extends StatelessWidget {
  final bool isSelected;
  final Function() onTap;
  final IconData icon;
  final String Function() label;

  const NavBarIconWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: Column(
          children: [
            Icon(icon, color: color),
            Text(label(), style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
