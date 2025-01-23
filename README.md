# cc_enpal

Steps to Run the Flutter App

Clone the repository:
git clone <repository-url>
cd <project-folder>

Install Flutter dependencies:
flutter pub get

Run the Flutter app:
flutter run


Notes:
- Ensure the Docker container (backend) is running before starting the Flutter app.
- If running on a physical device, replace localhost with your machine's local IP address in the API URL (lib/data/datasource/remote/energy_remote_data_source.dart).

Used Flutter SDK Version: 3.27.2
Dart SDK Version: 3.6.1
the project supports Dart 3.5.3 or higher, but does not enforce a specific Flutter version.


1. Architecture Overview :

- Clean Architecture: Separates concerns into Presentation, Domain, and Data layers.
- State Management: Uses BLoC (Business Logic Component) for efficient state management.
- Dependency Injection: Managed via GetIt, ensuring loose coupling between layers.
- Local Storage (Caching): Uses Hive, a lightweight and fast key-value database.
- Networking: Uses Dio, a powerful HTTP client for making API requests.

2. Folder Structure :

The project follows a modular and scalable folder structure:

lib/
│── core/                 # Core utilities (constants, themes, helpers, etc.)
│── data/
│   ├── datasources/      # Remote & local data sources (API, DB, etc.)
│   ├── models/           # Data models
│   ├── repositories/     # Implementations of repositories
│── domain/
│   ├── entities/         # Business logic entities
│   ├── repositories/     # Abstract repository interfaces
│   ├── usecases/         # Application-specific use cases
│── presentation/
│   ├── feature1/     # Example feature folder
│   │   ├── view/     # UI screens and widgets
│   │   ├── bloc/     # BLoC state management
│── init_dependencies.dart  # Dependency injection setup (GetIt)
│── main.dart  
