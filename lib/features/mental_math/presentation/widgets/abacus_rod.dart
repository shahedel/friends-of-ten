import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AbacusRod extends StatelessWidget {
  final String label;
  final int activeCount;
  final int beadCount;
  final bool isCorrect;
  final ValueChanged<int> onChanged;

  const AbacusRod({
    super.key,
    required this.label,
    required this.activeCount,
    required this.onChanged,
    this.beadCount = 9,
    this.isCorrect = false,
  });

  void _handlePosition(double dx, double width) {
    final beadWidth = width / beadCount;
    final newActive = (dx / beadWidth).round().clamp(0, beadCount);
    if (newActive != activeCount) onChanged(newActive);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$activeCount',
              style: TextStyle(
                color: isCorrect ? Colors.greenAccent : AppColors.redGlow,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return GestureDetector(
              onPanUpdate: (details) =>
                  _handlePosition(details.localPosition.dx, width),
              onTapUp: (details) =>
                  _handlePosition(details.localPosition.dx, width),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.whiteFaint, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: List.generate(beadCount, (index) {
                    final active = index < activeCount;
                    return Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active ? AppColors.red : AppColors.whiteFaint,
                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color: AppColors.redGlow,
                                    blurRadius: 6,
                                  ),
                                ]
                              : [],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
