# 🍎 Calorie Calculator

A cross-platform mobile application built with **Flutter** for tracking daily calorie intake, managing meals, and monitoring nutrition goals.

---

## ✨ Features (Working on few of them)

* 👤 **User Accounts** – Register and log in with Firebase Authentication.
* 📂 **Food Database** – Organized categories (fast food, soups, chicken, etc.) stored in **Firestore**.
* 🔄 **Hybrid Storage** –

  * **Hive** for meal logs (offline-first).
  * **SharedPreferences** for app settings (theme, username).
  * **Firebase Firestore** for food database & cloud sync.
* 📊 **Daily Logs** – Add meals per day and view them via calendar navigation.
* 🌍 **Multi-language Support** – English & Bulgarian.
* 🌐 **Web Companion** – Access your account and view logs online.
* 🎨 **Dark & Light Mode** – Adaptive UI with Material Design.

---

## 🛠️ Tech Stack

* **Framework**: Flutter (Dart)
* **Local Storage**: Hive (meals), SharedPreferences (settings)
* **Cloud**: Firebase Firestore
* **Authentication**: Firebase Auth
* **UI**: Flutter Material + Dark/Light themes

---

## 🚀 Getting Started

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* Firebase project set up (Firestore & Auth)

### Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/your-username/calorie-calculator.git
   cd calorie-calculator
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase (Android, iOS, Web):

   * Add your `google-services.json` (Android)
   * Add your `GoogleService-Info.plist` (iOS)
   * Update Firebase configs for Web if applicable

4. Run the app:

   ```bash
   flutter run
   ```

---

### Author: Vladimir Goychev

