import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';

class NavBarIconWidget extends StatelessWidget {
  // ========================== 🔒 Private variables 🔒 ==========================
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String Function() label;
  final int badgeCount;

  // ========================== Constructor ========================== //
  const NavBarIconWidget({super.key, required this.isSelected, required this.onTap, required this.icon, required this.label, this.badgeCount = 0});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [_buildIndicator(), const SizedBox(height: 8), _buildIcon(), const SizedBox(height: 4), _buildLabel()],
          ),
        ),
      ),
    );
  }

  // --------------------------[ _buildIndicator ]-------------------------- //
  Widget _buildIndicator() {
    return Container(
      width: 24,
      height: 3,
      decoration: BoxDecoration(color: isSelected ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(1.5)),
    );
  }

  // --------------------------[ _buildIcon ]-------------------------- //
  Widget _buildIcon() {
    final iconWidget = Icon(icon, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant, size: 24);

    if (badgeCount <= 0) return iconWidget;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        Positioned(
          top: -4,
          // end: -6,
          child: _buildBadge(),
        ),
      ],
    );
  }

  // --------------------------[ _buildBadge ]-------------------------- //
  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          '$badgeCount',
          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, height: 1),
        ),
      ),
    );
  }

  // --------------------------[ _buildLabel ]-------------------------- //
  Widget _buildLabel() => Text(
    label(),
    style: AppTextStyle.bodySmall.copyWith(
      color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}
