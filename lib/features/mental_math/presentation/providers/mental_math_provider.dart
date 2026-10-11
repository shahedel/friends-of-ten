import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentalMathState {
  final int a;
  final int b;
  final int userTens;
  final int userOnes;
  final int solvedCount;
  final int totalProblems;
  final bool justSolved;

  const MentalMathState({
    required this.a,
    required this.b,
    required this.userTens,
    required this.userOnes,
    required this.solvedCount,
    required this.totalProblems,
    this.justSolved = false,
  });

  int get sum => a + b;
  int get targetTens => sum ~/ 10;
  int get targetOnes => sum % 10;
  bool get isCorrect => userTens == targetTens && userOnes == targetOnes;
  bool get isSessionComplete => solvedCount >= totalProblems;

  MentalMathState copyWith({
    int? a,
    int? b,
    int? userTens,
    int? userOnes,
    int? solvedCount,
    bool? justSolved,
  }) {
    return MentalMathState(
      a: a ?? this.a,
      b: b ?? this.b,
      userTens: userTens ?? this.userTens,
      userOnes: userOnes ?? this.userOnes,
      solvedCount: solvedCount ?? this.solvedCount,
      totalProblems: totalProblems,
      justSolved: justSolved ?? this.justSolved,
    );
  }
}

class MentalMathNotifier extends Notifier<MentalMathState> {
  static const int totalProblems = 5;
  final Random _rand = Random();

  @override
  MentalMathState build() => _generateProblem(solvedCount: 0);

  MentalMathState _generateProblem({required int solvedCount}) {
    final a = 2 + _rand.nextInt(8);
    final b = 2 + _rand.nextInt(8);
    return MentalMathState(
      a: a,
      b: b,
      userTens: 0,
      userOnes: 0,
      solvedCount: solvedCount,
      totalProblems: totalProblems,
    );
  }

  void setOnes(int value) {
    state = state.copyWith(userOnes: value, justSolved: false);
    _checkAnswer();
  }

  void setTens(int value) {
    state = state.copyWith(userTens: value, justSolved: false);
    _checkAnswer();
  }

  void _checkAnswer() {
    if (!state.isCorrect) return;

    final newSolvedCount = state.solvedCount + 1;
    state = state.copyWith(justSolved: true, solvedCount: newSolvedCount);

    if (newSolvedCount < totalProblems) {
      Future.delayed(const Duration(milliseconds: 700), () {
        state = _generateProblem(solvedCount: newSolvedCount);
      });
    }
  }

  void resetSession() {
    state = _generateProblem(solvedCount: 0);
  }
}

final mentalMathProvider =
    NotifierProvider<MentalMathNotifier, MentalMathState>(
  MentalMathNotifier.new,
);
