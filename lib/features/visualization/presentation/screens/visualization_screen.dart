import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/web_node.dart';
import '../providers/visualization_provider.dart';

class VisualizationScreen extends ConsumerStatefulWidget {
  const VisualizationScreen({super.key});

  @override
  ConsumerState<VisualizationScreen> createState() =>
      _VisualizationScreenState();
}

class _VisualizationScreenState extends ConsumerState<VisualizationScreen>
    with SingleTickerProviderStateMixin {
  int? _wrongNodeValue; // الرقم يلي غلط فيه المستخدم حالياً (لعرض الاهتزاز)
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _handleTap(int nodeValue) {
    final success =
    ref.read(visualizationProvider.notifier).submitAnswer(nodeValue);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('صح! 🎉'),
          duration: Duration(milliseconds: 600),
        ),
      );
    } else {
      setState(() => _wrongNodeValue = nodeValue);
      _shakeController.forward(from: 0).then((_) {
        if (mounted) setState(() => _wrongNodeValue = null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(visualizationProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/spider_web.webp',
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Center(
                  child: Text(
                    'من رفيق ${state.given} ليوصلو لـ 10؟',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              ...webNodes.map((node) {
                final isGiven = node.value == state.given;
                final isTarget = node.value == state.target;
                final isWrong = node.value == _wrongNodeValue;

                Color bgColor = Colors.white.withValues(alpha: 0.3);
                Color glowColor = Colors.transparent;

                if (isGiven) {
                  bgColor = const Color(0xFFE6371F);
                  glowColor = const Color(0xFFE6371F);
                } else if (isTarget) {
                  bgColor = Colors.white;
                  glowColor = Colors.white;
                }

                Widget circle = Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor,
                    boxShadow: glowColor != Colors.transparent
                        ? [BoxShadow(color: glowColor, blurRadius: 12)]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      '${node.value}',
                      style: TextStyle(
                        color: isGiven ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );

                // إذا هالرقم غلط حاليًا، لفّه بحركة اهتزاز
                if (isWrong) {
                  circle = AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, child) {
                      final offset =
                          8 * (0.5 - (_shakeController.value * 4).floor() % 2) ;
                      final shakeX =
                          8 * ((_shakeController.value * 10).floor() % 2 == 0 ? 1 : -1) *
                              (1 - _shakeController.value);
                      return Transform.translate(
                        offset: Offset(shakeX, 0),
                        child: child,
                      );
                    },
                    child: circle,
                  );
                }

                return Positioned(
                  left: node.xPercent * width - 18,
                  top: node.yPercent * height - 18,
                  child: GestureDetector(
                    onTap: () => _handleTap(node.value),
                    child: circle,
                  ),
                );
              }),

              if (state.isComplete)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref.read(visualizationProvider.notifier).resetSession();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.15),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('أعد المحاولة'),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => context.goNamed('mathSession'),
                          child: const Text('Continue to Mental Math'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}