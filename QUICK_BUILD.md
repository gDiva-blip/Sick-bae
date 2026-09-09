# Build APK for Sick Bay

## Quick Commands

```bash
# Navigate to project
cd Sick-bae

# Clean and get dependencies
flutter clean
flutter pub get

# Build release APK
flutter build apk --release
```

## Output Location
After successful build, your APK will be at:
```
build/app/outputs/flutter-app.apk
```

## Install & Test
```bash
# Install on connected device/emulator
flutter install

# Or use adb directly
adb install -r build/app/outputs/flutter-app.apk
```

## Share for Review
- Send `build/app/outputs/flutter-app.apk` to reviewer
- They can install it on their Android device
- They can test all features:
  - Home screen with symptom checker
  - World Clock with multiple time zones
  - Navigation between screens

## If Build Fails

**Check Flutter installation:**
```bash
flutter doctor
```

**Fix common issues:**
```bash
flutter clean
flutter pub get
flutter pub cache repair
flutter doctor --android-licenses
```

**Check for errors:**
```bash
flutter build apk --verbose
```

This provides a genuine, compilable Android executable rather than just a README demo!
