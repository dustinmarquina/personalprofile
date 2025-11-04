# Personal Profile App

A minimal Flutter app that shows a personal profile, skills, and social links. Demonstrates layout widgets (Column, ListTile, CircleAvatar, Card) and a dark mode toggle.

## Run

1. Ensure Flutter is installed and on your PATH.
2. From the project root run:

```bash
flutter pub get
flutter run
```

## Notes
- The app expects `assets/profile.jpg`. You can place a local JPEG there or edit `lib/main.dart` to use `NetworkImage` instead.
- The app uses `url_launcher` for opening links.
 - By default the app uses a network placeholder avatar (no local asset required). To use a local image:
	 1. Place your image at `assets/profile.jpg`.
	 2. Uncomment and add the `assets:` entry in `pubspec.yaml`.
	 3. In `lib/main.dart` replace the `NetworkImage` with `AssetImage('assets/profile.jpg')`.
# personalprofile
# personalprofile
