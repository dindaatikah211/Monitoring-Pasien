# Monitoring-Pasien

A real-time patient monitoring system built with Flutter, Arduino, and Firebase. The system collects health data from sensors and displays it through a mobile application, enabling remote and continuous monitoring to support better patient care.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Firebase Setup](#firebase-setup)
- [Arduino Setup](#arduino-setup)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

Monitoring-Pasien is an IoT-based health monitoring application designed to collect patient vital data through Arduino sensors and transmit it to Firebase in real time. A Flutter mobile application reads this data and displays it to healthcare personnel, allowing remote observation of patient conditions without the need for physical presence.

---

## Features

- Real-time health data collection from Arduino sensors
- Data synchronization via Firebase Realtime Database or Firestore
- Cross-platform mobile application (Android and iOS)
- Continuous monitoring support for patient care environments
- Clean and responsive user interface built with Flutter

---

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter (Dart) |
| Backend / Database | Firebase (Realtime Database / Firestore) |
| Hardware | Arduino |
| Platforms | Android, iOS, Web, Windows, macOS, Linux |

---

## Prerequisites

Before getting started, make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.x or later recommended)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension
- A Firebase account and project
- Arduino IDE (for hardware setup)
- A physical Arduino board with compatible sensors

---

## Installation

1. Clone this repository:

```bash
git clone https://github.com/dindaatikah211/Monitoring-Pasien.git
cd Monitoring-Pasien
```

2. Install Flutter dependencies:

```bash
flutter pub get
```

3. Run the application:

```bash
flutter run
```

---

## Firebase Setup

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Add an Android and/or iOS app to your Firebase project.
3. Download the `google-services.json` file (for Android) and place it in the `android/app/` directory.
4. Download the `GoogleService-Info.plist` file (for iOS) and place it in the `ios/Runner/` directory.
5. Enable Firebase Realtime Database or Firestore in your Firebase project.
6. Set up your database rules according to your security requirements.

The `firebase.json` and `.metadata` files are already included in the repository to assist with Firebase CLI configuration.

---

## Arduino Setup

1. Open the Arduino IDE and load the sensor sketch from the hardware configuration folder (if available).
2. Install the required libraries for your sensors (e.g., pulse oximeter, temperature sensor).
3. Configure your Wi-Fi credentials and Firebase project URL inside the Arduino sketch.
4. Upload the sketch to your Arduino board.
5. Power the Arduino and verify that data is being sent to Firebase.

---

## Project Structure

```
Monitoring-Pasien/
├── android/             # Android platform files
├── ios/                 # iOS platform files
├── lib/                 # Main Flutter application source code
├── linux/               # Linux platform files
├── macos/               # macOS platform files
├── web/                 # Web platform files
├── windows/             # Windows platform files
├── test/                # Unit and widget tests
├── firebase.json        # Firebase CLI configuration
├── pubspec.yaml         # Flutter dependencies and project metadata
├── pubspec.lock         # Locked dependency versions
├── analysis_options.yaml# Dart static analysis configuration
└── .gitignore           # Git ignore rules
```

---

## Usage

1. Ensure the Arduino device is powered on and connected to the internet.
2. Launch the Flutter application on your mobile device or emulator.
3. The application will automatically fetch real-time data from Firebase and display the patient's health metrics.
4. Healthcare personnel can monitor the patient remotely through the app interface.

---
