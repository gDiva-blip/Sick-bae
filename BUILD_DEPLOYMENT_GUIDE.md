# Sick Bay Build & Deployment Guide

## Prerequisites
- Flutter SDK installed (`flutter --version` to check)
- Android SDK (for Android APK builds)
- Xcode (for iOS builds on macOS)

## Quick Start - Build APK (Android)

### Step 1: Get Dependencies
```bash
cd Sick-bae
flutter clean
flutter pub get
```

### Step 2: Run Tests & Analysis
```bash
flutter analyze
flutter test
```

### Step 3: Build Release APK
```bash
flutter build apk --release
```

**APK Location:** `build/app/outputs/flutter-app.apk`

This is your executable that can be:
- Installed on Android devices
- Distributed via Google Play Store
- Tested on Android emulators

## Other Build Options

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS App (macOS required)
```bash
flutter build ios --release
```

### Web Build
```bash
flutter build web --release
```
**Output:** `build/web/` - Deploy to GitHub Pages

### Windows Executable
```bash
flutter build windows --release
```
**Output:** `build/windows/runner/Release/`

### macOS App
```bash
flutter build macos --release
```

## Features in Sick Bay

### Home Screen
- Symptom checker interface
- Health guidance system
- Medical recommendations
- Uses Provider for state management

### World Clock Screen
- Digital clock displaying current local time
- 6 major world time zones:
  - New York (EST/EDT)
  - London (GMT/BST)
  - Tokyo (JST)
  - Sydney (AEDT/AEST)
  - Dubai (GST)
  - Los Angeles (PST/PDT)
- Real-time updates every second
- Beautiful gradient UI
- Date and time display

## Testing the App

### Run on Emulator/Device
```bash
flutter run
```

### Run in Release Mode
```bash
flutter run --release
```

## Distribution Checklist

- ✅ Code compiles without errors
- ✅ App runs on device/emulator
- ✅ Features tested (Home + World Clock)
- ✅ APK generated and ready for distribution
- ✅ Can be installed on Android devices
- ✅ Can be distributed via Google Play Store

## Troubleshooting

**Build fails:**
```bash
flutter clean
flutter pub get
flutter pub cache repair
```

**Dependencies issue:**
```bash
flutter doctor
```

**Emulator not found:**
- Android Studio → Device Manager → Create virtual device

## Next Steps
1. Build the APK: `flutter build apk --release`
2. Test on device/emulator: `flutter run`
3. Share APK with reviewers for feedback
4. Address any feedback and rebuild
