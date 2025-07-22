# 🌐 AI Translator - Flutter App

A beautiful, lightweight Flutter app that lets you translate text between multiple languages using **Google Translate API** and hear the results via **Text-to-Speech (TTS)**.

---

## 🚀 Features

- 🔤 Translate between:
  - English
  - Hindi
  - Nepali
  - Telugu
  - Tamil
  - Japanese
  - Korean
  - Spanish
  - French
  - Chinese
- 🗣️ Text-to-Speech playback of translated text
- 🌈 Clean, responsive Material UI
- 🔒 Handles errors (invalid API key, bad requests, same language selection)

---

## 🧑‍💻 Built With

- **Flutter** (UI)
- **Dart**
- **Google Translate API**
- **flutter_tts** for text-to-speech

---

## 📦 Dependencies

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.6
  flutter_tts: ^3.6.3
```

Install:

```bash
flutter pub get
```

---

## 🔑 Google Cloud API Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a project or select one
3. Enable **Cloud Translation API**
4. Navigate to `APIs & Services > Credentials`
5. Click “Create Credentials” → “API Key”
6. Copy your key and replace it in the code:

```dart
final String apiKey = "YOUR_API_KEY_HERE";
```

> ⚠️ For production, store your API key securely. Don't hardcode it in public repositories.

---

## 🛠 Run the App

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/ai-translator.git
cd ai-translator

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📁 Folder Structure

```
ai-translator/
├── lib/
│   └── main.dart
├── screenshots/
│   ├── input.png
│   └── output.png
├── pubspec.yaml
└── README.md
```

---
## 👤 Author

Built with 💙 by [MURALI KARTHIK ABBADASARI]  
GitHub: [@murali-karthik01](https://github.com/murali-karthik01)

