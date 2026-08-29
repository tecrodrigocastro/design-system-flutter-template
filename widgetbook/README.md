# widgetbook_gallery

Interactive component gallery for the [`design_system`](../design_system)
package, built with [Widgetbook](https://www.widgetbook.io/).

## Running

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

While developing, use `dart run build_runner watch` instead so new use
cases show up as you save.

## Adding a use case

Drop a file under `lib/use_cases/`, mirroring the component's location in
`design_system/lib/src/components/`, with a function annotated with
`@widgetbook.UseCase`. Re-run `build_runner` and it appears in the
navigation tree automatically — no manual registration.
