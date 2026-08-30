# design_system

A Flutter design system template built around three pillars:

1. **Design Tokens** — colors, typography, and spacing as constants (`lib/src/tokens`).
2. **Reusable components** — built with Atomic Design (`lib/src/components/{atoms,molecules}`), each one flexible (variant-driven), type-safe (enums, not strings), performant (`const` constructors), and documented.
3. **Living documentation** — every public API has a DartDoc comment with a runnable example, and the sibling [`widgetbook/`](../widgetbook) app lets you browse and interact with every component live.

## Install

This package isn't published to pub.dev — it's a template meant to be copied. Once you've made it your own, there are a few ways to distribute it to consuming apps:

**Path dependency** — single repo/monorepo, one team (what this template uses by default):

```yaml
dependencies:
  design_system:
    path: ../design_system
```

**Git dependency** — multiple app repos, one shared design system repo, no publishing step:

```yaml
dependencies:
  design_system:
    git:
      url: https://github.com/your-org/your-design-system.git
```

**Self-hosted pub server** — many teams, real semver releases via plain `dart pub publish` / `flutter pub get`. If you don't want to depend on a third-party paid service, [Dartisan](https://github.com/tecrodrigocastro/dartisan) is an open-source (MIT), self-hosted server implementing the standard `pub` protocol — still under active development, not production-ready yet, but worth watching:

```yaml
dependencies:
  design_system:
    hosted: https://your-dartisan-instance.example.com
    version: ^0.3.0
```

## Usage

Import the single barrel file to get every token, enum, and component:

```dart
import 'package:design_system/design_system.dart';

DsButton(
  text: 'Enviar',
  variant: DsButtonVariant.primary,
  onPressed: () {},
)
```

## Structure

```
lib/
├── core/
│   └── enums/              # Type-safe variants (DsButtonVariant, DsButtonSize...)
├── src/
│   ├── tokens/              # Design tokens: colors.dart, typography.dart, spacing.dart
│   └── components/
│       ├── atoms/            # DsButton, DsInput
│       └── molecules/         # DsCard, DsBanner
└── design_system.dart        # Single export surface
```

## Generating the docs

```sh
dart pub global activate dartdoc  # once
cd design_system
dart doc .
open doc/api/index.html
```

## Design principles

- **Never hardcode a color, font size, or spacing value** in a component — read it from a token in `lib/src/tokens`.
- **Never take a `String` for a variant** — add a value to the relevant enum in `lib/core/enums` instead, so the compiler catches typos.
- **Every public class/member gets a `///` doc comment** with a `dart` example — enforced by `public_member_api_docs` in `analysis_options.yaml`.
- **Prefer `const` constructors and `StatelessWidget`** — components hold no internal state unless the interaction genuinely requires it.

## License

[MIT](LICENSE).
