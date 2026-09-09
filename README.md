# Sick-bae

## GitHub Repository
https://github.com/gDiva-blip/Sick-bae

## Demo & Download
**Build Status:** Ready for APK compilation

To get the executable demo:
1. Clone the repository
2. Run: `flutter build apk --release`
3. APK location: `build/app/outputs/flutter-app.apk`
4. Install on Android device or emulator

## About
Sick Bay is a healthcare support application designed to make it easier for users to access basic health information and get guidance when they are feeling unwell.

### Features
- **Symptom Checker**: Input symptoms and receive health guidance
- **World Clock**: Digital clock displaying multiple time zones (New York, London, Tokyo, Sydney, Dubai, Los Angeles)
- **Material Design 3 UI**: Modern, responsive interface
- **Real-time Updates**: Clock updates every second

## Technology Stack
- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Timezone Support**: timezone & intl packages
- **UI**: Material Design 3

## Usage
1. Open the Sick Bay application
2. Navigate through the home screen to access health-support features:
   - Enter or select symptoms you're experiencing
   - Review health guidance provided
   - Follow recommended next steps
3. Use the World Clock tab to see time in different zones
4. Use the app as a general health-support tool and not as a replacement for professional medical diagnosis or treatment

## Build Instructions
See [BUILD_DEPLOYMENT_GUIDE.md](BUILD_DEPLOYMENT_GUIDE.md) or [QUICK_BUILD.md](QUICK_BUILD.md)

### Quick Build
```bash
flutter clean
flutter pub get
flutter build apk --release
```

## Installation
- Android: Install the generated APK on any Android device (min SDK: 21)
- Can also be built for iOS, Web, Windows, and macOS

## Requirements
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0+
- Android SDK (for Android builds)

## Development
```bash
flutter run              # Run in debug mode
flutter analyze         # Check code quality
flutter test           # Run tests
flutter run --release  # Run in release mode
```

---

**Status:** Ready for compilation and distribution ✅
