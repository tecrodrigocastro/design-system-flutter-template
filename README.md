# design-system-template

[![CI](https://github.com/tecrodrigocastro/design-system-flutter-template/actions/workflows/ci.yml/badge.svg)](https://github.com/tecrodrigocastro/design-system-flutter-template/actions/workflows/ci.yml)

A starter template for building a Flutter design system the "right way":
design tokens, type-safe components built with Atomic Design, DartDoc on
every public API, and a live component gallery powered by
[Widgetbook](https://www.widgetbook.io/). Based on the talk **"Do Caos ao
Design System"**.

## Structure

This is a two-package monorepo:

```
.
├── design_system/   # The design system itself — a publishable Flutter package
└── widgetbook/       # Interactive gallery app that consumes design_system via a path dependency
```

They're kept as siblings on purpose: `design_system` stays a clean,
publishable package with no gallery/dev-tooling baggage, and `widgetbook`
is just one of potentially many consumers of it (an app could depend on
it the same way).

## Quickstart

```sh
# 1. Get dependencies for both packages
cd design_system && flutter pub get && cd ..
cd widgetbook && flutter pub get && cd ..

# 2. Run the component gallery
cd widgetbook
dart run build_runner build --delete-conflicting-outputs   # regenerate use-case registry
flutter run -d chrome
```

Whenever you add or edit a component, re-run `build_runner` (or `dart run
build_runner watch` while developing) so Widgetbook picks up the change.

## Generating the API docs

```sh
cd design_system
dart doc .
open doc/api/index.html
```

See [`design_system/README.md`](design_system/README.md) for the
package's architecture, principles, and folder layout.
