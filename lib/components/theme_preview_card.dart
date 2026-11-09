import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ThemePreviewCard extends StatelessWidget {
  ThemePreviewCard({
    super.key,
    required this.mode,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final ThemeMode mode;
  final String label;
  final bool selected;
  final VoidCallback onTap;


  Widget _mini(ThemeData t, Color line) {
    return Container(
      color: t.colorScheme.surface,          // خلفية الثيم (أبيض أو 0F0F11)
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: t.colorScheme.primary,  // الأحمر بتاع الثيم ده
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Container(height: 5, color: line),
          const SizedBox(height: 5),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(height: 5, color: line),
          ),
          const SizedBox(height: 5),
          Container(height: 5, color: line),
        ],
      ),
    );
  }

  Widget _preview() {
    final light = _mini(lightTheme, const Color(0xFFD8D8DC));
    final dark = _mini(darkTheme, const Color(0xFF333336));
    switch (mode) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      case ThemeMode.system:
        return Row(children: [Expanded(child: light), Expanded(child: dark)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? activeColor : theme.dividerColor,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _preview(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected
                  ? activeColor
                  : theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}