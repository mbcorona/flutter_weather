# Flutter Weather App

This app will show you the current weather of a city by entering the name or by geolocation.
- You can see the weather information for the current day (in progress)
- You can see a list of days containing the overall information of the day (in progress)
- You can select any given day from the list to see more information about it (in progress)

## Getting started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

## Libraries used
- flutter_bloc for state management

- Hydrated_bloc is an extension for flutter_bloc that allows us to save the latest state of a bloc, so when the user comes back to the app will see the latest weather cached, or if the user does not have an internet connection.

- flutter_test for unit and widget testing
- bloc_test a Dart package that makes testing blocs and cubits easy
- mocktail focuses on providing a familiar, simple API for creating mocks in Dart

## Install dependencies

Use the package manager to get the packages needed for this app

```bash
flutter pub get
```

## Running tests

```flutter
# Generate test coverage (lcov.info)
fluter test --coverage

# Generate HTML view from LCOV coverage data files
genhtml coverage/lcov.info -o coverage
```


## TODO:
- Write bloc tests
- Write widget tests
