# Friends of Ten

Flutter educational app that teaches children mental math in stages. It starts with the pairs that make 10 (number bonds to 10) and moves to an interactive abacus.

تطبيق Flutter تعليمي للأطفال، يعلّم الحساب الذهني على مراحل: يبدأ بأزواج العدد 10 ثم ينتقل إلى عداد (Abacus) تفاعلي.

**Author:** Shahad

## Features

- **Visualization screen:** a number is shown on a spider web and the child taps its partner that makes 10, with immediate feedback and six pairs to complete.
- **Interactive abacus:** each column has one upper bead worth 5 and four lower beads worth 1. The widget takes the number of columns as a parameter, so the same component serves ones, tens and hundreds.
- **Ones practice:** a number from 1 to 9 is shown and the child represents it on a one-column abacus. Three correct answers unlock skipping.

## Tech

- Flutter and Dart
- State management: Riverpod
- Navigation: go_router
- Feature-based folder structure

## Structure

```
lib/
├── main.dart
├── core/theme/app_theme.dart
├── routing/app_router.dart
└── features/
    ├── home/
    ├── visualization/
    └── mental_math/
```

## Documentation

System analysis and UML diagrams (use case, class, sequence), screens, architecture and the design system: [`docs/Friends_of_Ten_Analysis_and_UML.pdf`](docs/Friends_of_Ten_Analysis_and_UML.pdf)

## Status

Done: Visualization screen, abacus widget, ones practice, math session screen.
In progress: intro screens, tens stage, addition on the abacus, scoring from bead movement.

## Note

This repository currently holds the `lib/` source and the documentation. Platform folders, `pubspec.yaml` and assets (such as `assets/images/spider_web.webp`) will be added with the full project.
