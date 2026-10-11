import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisualizationState {
  final int given;
  final int target;
  final Set<int> solvedPairs; // كل pair بنخزن أصغر رقم فيه (مثلاً 2 لزوج 2و8)

  const VisualizationState({
    required this.given,
    required this.target,
    required this.solvedPairs,
  });

  bool get isComplete => solvedPairs.length >= 6; // 6 أزواج: (0,10)(1,9)(2,8)(3,7)(4,6)(5,5)

  VisualizationState copyWith({
    int? given,
    int? target,
    Set<int>? solvedPairs,
  }) {
    return VisualizationState(
      given: given ?? this.given,
      target: target ?? this.target,
      solvedPairs: solvedPairs ?? this.solvedPairs,
    );
  }
}

class VisualizationNotifier extends Notifier<VisualizationState> {
  @override
  VisualizationState build() {
    final firstGiven = _pickRandomUnsolved({});
    return VisualizationState(
      given: firstGiven,
      target: 10 - firstGiven,
      solvedPairs: {},
    );
  }

  int _pickRandomUnsolved(Set<int> solved) {
    final remaining = <int>[];
    for (int n = 0; n <= 9; n++) {
      final pairKey = min(n, 10 - n);
      if (!solved.contains(pairKey)) remaining.add(n);
    }
    if (remaining.isEmpty) return 5; // fallback
    remaining.shuffle();
    return remaining.first;
  }

  bool submitAnswer(int selectedNode) {
    if (selectedNode != state.target) return false;

    final pairKey = min(state.given, state.target);
    final newSolved = {...state.solvedPairs, pairKey};

    if (newSolved.length >= 6) {
      state = state.copyWith(solvedPairs: newSolved);
      return true;
    }

    final nextGiven = _pickRandomUnsolved(newSolved);
    state = VisualizationState(
      given: nextGiven,
      target: 10 - nextGiven,
      solvedPairs: newSolved,
    );
    return true;
  }

  void resetSession() {
    final firstGiven = _pickRandomUnsolved({});
    state = VisualizationState(
      given: firstGiven,
      target: 10 - firstGiven,
      solvedPairs: {},
    );
  }
}

final visualizationProvider =
NotifierProvider<VisualizationNotifier, VisualizationState>(
  VisualizationNotifier.new,
);