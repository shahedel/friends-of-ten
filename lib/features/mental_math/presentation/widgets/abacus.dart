import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class Abacus extends StatefulWidget {
  final int columns;
  final ValueChanged<int>? onValueChanged;

  const Abacus({super.key, this.columns = 10, this.onValueChanged});

  @override
  State<Abacus> createState() => _AbacusState();
}

class _AbacusState extends State<Abacus> {
  static const double _height = 300;
  static const double _beadH = 24;

  late List<bool> _top;
  late List<int> _low;

  @override
  void initState() {
    super.initState();
    _top = List.filled(widget.columns, false);
    _low = List.filled(widget.columns, 0);
  }

  int get _value {
    var total = 0;
    for (var i = 0; i < widget.columns; i++) {
      final digit = (_top[i] ? 5 : 0) + _low[i];
      total = total * 10 + digit;
    }
    return total;
  }

  void _notify() => widget.onValueChanged?.call(_value);

  void _tapTop(int i) {
    setState(() {
      final turningOn = !_top[i];
      _top[i] = turningOn;
      if (turningOn && _low[i] == 4) {
        _low[i] = 0;
      }
    });
    _notify();
  }

  void _tapLow(int i, int j) {
    setState(() => _low[i] = j < _low[i] ? j : j + 1);
    _notify();
  }

  Widget _bead({
    required double left,
    required double top,
    required double width,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      left: left,
      top: top,
      width: width,
      height: _beadH,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(_beadH),
            border: Border.all(color: Colors.black38, width: 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.whiteFaint, width: 1.5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final colW = constraints.maxWidth / widget.columns;
          final beadW = colW * 0.82;
          final children = <Widget>[];

          for (var i = 0; i < widget.columns; i++) {
            final x = i * colW;
            children.add(Positioned(
              left: x + colW / 2 - 1.5,
              top: 8,
              width: 3,
              height: _height - 16,
              child: Container(color: Colors.white24),
            ));
          }

          children.add(Positioned(
            left: 8,
            right: 8,
            top: 118,
            height: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ));

          for (var i = 0; i < widget.columns; i++) {
            final left = i * colW + (colW - beadW) / 2;
            final color = i.isEven ? AppColors.red : AppColors.white;

            children.add(_bead(
              left: left,
              top: _top[i] ? 90 : 16,
              width: beadW,
              color: color,
              onTap: () => _tapTop(i),
            ));

            for (var j = 0; j < 4; j++) {
              final active = j < _low[i];
              final y = active ? 142.0 + j * 25 : 270.0 - (3 - j) * 25;
              children.add(_bead(
                left: left,
                top: y,
                width: beadW,
                color: color,
                onTap: () => _tapLow(i, j),
              ));
            }
          }

          return Stack(children: children);
        },
      ),
    );
  }
}
