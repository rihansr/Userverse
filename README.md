# Userverse

<img src="https://github.com/rihansr/Userverse/blob/main/preview.gif" width="25%" height="25%"/>

## Project Structure

### Modules

The project is divided into several modules, each responsible for a specific feature or functionality. This modular approach helps in maintaining a clean architecture and makes the codebase more manageable and scalable.

- **Core**: Contains the core functionalities and services used across the application.
- **Features**:
    - **Authentication**: Handles user login, and authentication flows.
    - **Dashboard**: Displays an overview of all users and settings, providing a central hub for navigation.
    - **Settings**: Manages application settings, including localization and theming.
    - **User**: information for each user.
- **Shared**: Provides common functionalities such as network calls, local storage access, and reusable widgets, adhering to clean architecture principles.

### Dependency Injection

We use `get_it` and `injectable` for dependency injection to manage the dependencies across different modules. This ensures that the dependencies are easily testable and configurable.

### State Management

The application uses `flutter_bloc` for state management, which helps in managing the state of the application in a predictable manner.

## Getting Started

### Download

You can download the latest version of the application from the following links:

- [Google Drive](https://drive.google.com/file/d/1ZCsCEb1KP5vKe4oV2jsloJwE0KlFmYvG/view?usp=sharing)
- [GitHub Releases](https://github.com/rihansr/Userverse/releases/tag/v1.0.2)

### Prerequisites

Ensure you have the following installed on your system:

- Flutter SDK: [Installation Guide](https://docs.flutter.dev/get-started/install)
- Dart SDK: [Installation Guide](https://dart.dev/get-dart)

### Steps

1. Clone the repository:
    ```sh
    git clone https://github.com/rihansr/Userverse.git
    cd Userverse
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Run the application:
    ```sh
    flutter run
    ```

### Credentials

Use the following test credentials to log in:

- **Email:** eve.holt@reqres.in
- **Password:** 12345678
