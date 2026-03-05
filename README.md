# MD Test App

A Flutter application implementing authentication and user management using **Firebase Authentication** and **BLoC state management**.  
This project demonstrates login, registration, email verification, password reset, and user filtering/search.

---

# Requirements

Before running this project, ensure the following tools are installed:

- Flutter SDK (>= 3.x)
- Dart SDK
- Android Studio or VS Code
- Android Emulator / iOS Simulator / Physical Device
- Firebase Project

Check installation:

```bash
flutter doctor
```

Resolve any issues shown by the command before continuing.

---

# Installation

Clone the repository:

```bash
git clone https://github.com/your-repository/mdtestapp.git
```

Navigate into the project directory:

```bash
cd mdtestapp
```

Install dependencies:

```bash
flutter pub get
```

---

# Firebase Setup

This project uses **Firebase Authentication**.

1. Create a Firebase project at  
   https://console.firebase.google.com

2. Add a **Flutter app** to the project.

3. Download configuration files.

For Android:

```
android/app/google-services.json
```

For iOS:

```
ios/Runner/GoogleService-Info.plist
```

4. Place these files in their respective directories.

5. Enable the following Firebase Authentication method:

- Email / Password

---

# Run the Application

Start a device emulator or connect a physical device.

Run the project:

```bash
flutter run
```

---

# Project Structure

```
lib/
│
├── bloc/
│   └── account/
│       ├── auth/
│       ├── register/
│       ├── forgot_password/
│       └── user/
│
├── model/
│
├── ui/
│   ├── login_page.dart
│   ├── register_page.dart
│   ├── forgot_password_page.dart
│   └── home_page.dart
│
├── widgets/
│   ├── global/
│   └── reusable/
│
└── main.dart
```

---

# Architecture

This project follows:

- **BLoC (Business Logic Component)** for state management
- **Reusable UI Widgets** for consistent design
- **Firebase Authentication** for user management

---

# Features

## Authentication

- User Login
- User Registration
- Email Verification
- Resend Verification Email
- Password Reset via Email
- Logout

## User Management

- Load user list
- Search user by name/email
- Filter users (All / Verified / Not Verified)

## UI

- Minimalist UI
- Soft blue design theme
- Reusable global widgets
- Consistent form components

---

# Running Tests (Optional)

```bash
flutter test
```

---

# Troubleshooting

If the project fails to run:

Clean build cache:

```bash
flutter clean
flutter pub get
```

Check Flutter setup:

```bash
flutter doctor
```

---

# Author

Developed by **Fahlevi Ikhsanur Rizal**