# Task Manager App

A Flutter-based task management application with Firebase authentication and Firestore database. This app allows users to register, log in, and manage their tasks efficiently.

## Features
- User authentication (Sign up, Login, Logout)
- Firebase Firestore integration for storing tasks
- Task management (Add, Update, Delete, Mark as Completed)
- Real-time task updates using GetX

## Tech Stack
- **Flutter**: Cross-platform mobile development
- **Firebase**: Authentication & Firestore database
- **GetX**: State management and navigation
- **Dart**: Programming language

## Installation

### Prerequisites
Ensure you have the following installed:
- Flutter SDK
- Dart SDK
- Firebase setup for Flutter

### Steps to Run the App
1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/task-manager.git
   cd task-manager
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Set up Firebase:
   - Follow [Firebase setup for Flutter](https://firebase.flutter.dev/docs/overview/)
   - Add your `google-services.json` file in `android/app/`
4. Run the app:
   ```sh
   flutter run
   ```

## Project Structure
```
lib/
├── controllers/       # GetX Controllers (Auth & Task Management)
├── models/           # Data Models (Task Model)
├── services/         # Firebase Services
├── views/            # UI Screens (Login, Register, Tasks)
├── widgets/          # Reusable UI Components
├── main.dart         # App Entry Point
├── routes.dart       # App Navigation
```

## Firebase Setup
Ensure Firebase is correctly set up:
- Enable Firestore and Authentication in Firebase Console
- Add the Firebase SDK dependencies to `pubspec.yaml`
- Configure Firebase options in `firebase_options.dart`

## Contributing
1. Fork the repository
2. Create a new branch: `git checkout -b feature-branch`
3. Commit changes: `git commit -m 'Add feature'`
4. Push the branch: `git push origin feature-branch`
5. Create a Pull Request

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For any inquiries, feel free to reach out:
- **Email**: rohit.varshney.glau@gmail.com
