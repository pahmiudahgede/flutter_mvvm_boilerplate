# Flutter Clean MVVM Architecture with Google Sheets API

A Flutter application built with Clean MVVM (Model-View-ViewModel) architecture pattern, demonstrating how to integrate Google Sheets as a backend API using Google Apps Script. This project emphasizes separation of concerns, testability, and maintainability while showcasing serverless backend integration.

## 🌟 Key Features

- **Clean MVVM Architecture** with Repository Pattern
- **Google Sheets as Backend** - No traditional server required
- **Complete CRUD Operations** - Create, Read, Update, Delete users
- **Dependency Injection** using GetIt service locator
- **State Management** with Provider pattern
- **Responsive Design** with ScreenUtil
- **Form Validation** and error handling
- **Indonesian Date Formatting** with timezone support
- **Search Functionality** with real-time filtering
- **Modern UI/UX** with loading states and animations

## 🔗 Backend Integration

This Flutter app integrates with a **Google Sheets API** built using Google Apps Script. The backend implementation is available at:

**🔗 [Google Sheets API Repository](https://github.com/pahmiudahgede/spreadsheet_api)**

### Why Google Sheets as Backend?

- ✅ **Zero Server Costs** - No hosting fees or server maintenance
- ✅ **Real-time Collaboration** - Multiple users can edit data simultaneously  
- ✅ **Easy Data Management** - Non-technical users can manage data directly
- ✅ **Instant Deployment** - API ready in minutes
- ✅ **Built-in Backup** - Google's infrastructure handles data safety
- ✅ **Perfect for Prototyping** - Quick MVPs and proof of concepts

## 🏗️ Architecture Overview

This project implements a **Clean MVVM Architecture** with Repository Pattern and Dependency Injection, providing:

- **Separation of Concerns**: Clear boundaries between UI, business logic, and data layers
- **Testability**: Each layer can be unit tested independently
- **Maintainability**: Well-organized codebase that's easy to modify and extend
- **Scalability**: Architecture that supports feature growth
- **Reusability**: Components and services designed for reuse

```
┌─────────────────┐    HTTP/JSON    ┌──────────────────┐    ┌─────────────────┐
│   Flutter App   │ ──────────────→ │ Google Apps      │ ←──│ Google Sheets   │
│                 │                 │ Script API       │    │ Database        │
│ • MVVM Pattern  │ ←────────────── │                  │    │                 │
│ • State Mgmt    │   REST Response │ • doGet()        │    │ • User Data     │
│ • Clean Arch    │                 │ • doPost()       │    │ • Real-time     │
└─────────────────┘                 └──────────────────┘    └─────────────────┘
```
![MVVM Architecture Pattern](assets/mvvm-pattern.png)

## 📁 Project Structure

```
lib/
├── component/                 # Reusable UI Components
│   ├── avatars/
│   │   └── avatar.component.dart
│   ├── cards/
│   │   └── card.component.dart
│   ├── header/
│   │   └── header.component.dart
│   ├── refresh/
│   │   └── refresh.component.dart
│   ├── shimmer/
│   │   └── shimmer.component.dart
│   └── states/
│       └── state.component.dart
├── core/                      # Core Infrastructure
│   ├── utils/
│   │   ├── date_helper.dart   # Indonesian date formatting
│   │   ├── provider.injection.dart
│   │   ├── router.dart
│   │   └── varguide.dart
│   └── apiclient.dart         # HTTP client for Sheets API
├── data/                      # Data Layer
│   └── user/
│       ├── user.model.dart    # User data model with date conversion
│       ├── user.repo.dart     # Repository implementation
│       ├── user.service.dart  # API service layer
│       └── user.vmod.dart     # ViewModel with state management
├── screen/                    # UI Screens
│   ├── adduser.screen.dart    # Create user form
│   ├── edituser.screen.dart   # Update user form
│   ├── user.screen.dart       # User list with search
│   └── userdetail.screen.dart # User details with actions
├── main.dart                  # Application entry point
└── .env                       # Environment variables
```

## 🏛️ Architecture Layers

### 1. **Presentation Layer** (`screen/`, `component/`)
- **Screens**: Main UI pages (User List, Add User, Edit User, User Details)
- **Components**: Reusable UI widgets (cards, headers, loading states)
- **Features**:
  - Responsive design with ScreenUtil
  - Form validation and error handling
  - Loading states and animations
  - Search functionality
  - Pull-to-refresh

### 2. **ViewModel Layer** (`*.vmod.dart`)
- **State Management**: Provider pattern implementation
- **Responsibilities**:
  - Manage UI state (loading, success, error)
  - Handle CRUD operations
  - Input validation and sanitization
  - Real-time search filtering
  - Local state synchronization

### 3. **Service Layer** (`*.service.dart`)
- **API Integration**: Communicates with Google Sheets API
- **Business Logic**: 
  - Data transformation and validation
  - Error handling and retry logic
  - Request/response formatting
  - Date formatting and timezone conversion

### 4. **Repository Layer** (`*.repo.dart`)
- **Data Abstraction**: Clean interface for data operations
- **Responsibilities**:
  - Abstract API implementation details
  - Error handling and transformation
  - Data caching strategies
  - Response parsing and validation

### 5. **Model Layer** (`*.model.dart`)
- **Data Models**: User entity with helper methods
- **Features**:
  - JSON serialization/deserialization
  - Date formatting (ISO ↔ Indonesian format)
  - Timezone conversion (UTC ↔ WIB)
  - Data validation helpers
  - Update data generation

### 6. **Core Layer** (`core/`)
- **Infrastructure**: Common utilities and configurations
- **Components**:
  - **API Client**: HTTP client for Google Sheets API
  - **Date Helper**: Indonesian date formatting utilities
  - **Dependency Injection**: GetIt service locator
  - **Router**: Go Router navigation
  - **Style Guide**: Design system constants

## 🔄 Data Flow Example

### Creating a New User:
1. **User fills form** → `AddUserScreen`
2. **Form validation** → `AddUserScreen` validates inputs
3. **Submit action** → Calls `UserViewModel.createUser()`
4. **Business logic** → `UserService.createUser()` processes data
5. **API call** → `UserRepository` calls Google Sheets API
6. **Data transformation** → Convert Indonesian date to ISO format
7. **HTTP request** → `ApiClient.post()` sends data to Apps Script
8. **Response handling** → Parse response and update local state
9. **UI update** → Show success message and navigate back

## 🌐 API Integration

### Google Sheets API Endpoints

The app integrates with the following API endpoints:

```dart
// Get all users
GET https://script.google.com/.../exec?action=getAll

// Get user by ID  
GET https://script.google.com/.../exec?action=getById&id={id}

// Create user
POST https://script.google.com/.../exec
Body: {"action": "create", "data": {...}}

// Update user
POST https://script.google.com/.../exec  
Body: {"action": "update", "id": "{id}", "data": {...}}

// Delete user
POST https://script.google.com/.../exec
Body: {"action": "delete", "id": "{id}"}
```

### Data Format Handling

The app handles automatic conversion between different date formats:

```dart
// API Response (ISO) → App (Indonesian)
"2004-09-01T17:00:00.000Z" → "02-09-2004"

// App (Indonesian) → API Request (ISO)  
"02-09-2004" → "2004-09-01T17:00:00.000Z"

// Display (Human Readable)
"02-09-2004" → "2 September 2004, 00:00"
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.19.0)
- Google account for Sheets API setup
- IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-clean-mvvm-sheets
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Google Sheets API**
   - Follow setup guide in [spreadsheet_api repository](https://github.com/pahmiudahgede/spreadsheet_api)
   - Deploy Google Apps Script and get the Web App URL

4. **Configure environment**
   ```bash
   cp .env.example .env
   # Add your Google Sheets API URL
   BASE_URL="https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec"
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

## 📱 Features Showcase

### User Management
- **User List**: Displays all users with search functionality
- **Add User**: Form with validation for creating new users
- **User Details**: Complete user information display
- **Edit User**: Update user information with pre-filled forms
- **Delete User**: Confirmation dialog with safe deletion

### UI/UX Features  
- **Responsive Design**: Adapts to different screen sizes
- **Loading States**: Shimmer effects and progress indicators
- **Error Handling**: User-friendly error messages
- **Form Validation**: Real-time input validation
- **Search**: Real-time filtering of user list
- **Pull-to-Refresh**: Update data with pull gesture
- **Smooth Navigation**: Go Router with proper transitions

### Data Features
- **Automatic Date Conversion**: ISO ↔ Indonesian format
- **Timezone Handling**: UTC to WIB conversion
- **Form Pre-filling**: Edit forms populated with existing data
- **Real-time Updates**: UI reflects API changes immediately
- **Offline Handling**: Graceful degradation when offline

## 🧪 Testing

### API Testing
Test the Google Sheets API endpoints using cURL or Postman:

```bash
# Test getting all users
curl "YOUR_API_URL?action=getAll"

# Test creating a user
curl -X POST YOUR_API_URL \
  -H "Content-Type: application/json" \
  -d '{"action": "create", "data": {...}}'
```

### Unit Testing
```bash
# Run unit tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # Network
  http: ^1.1.0
  flutter_dotenv: ^5.1.0
  
  # UI
  flutter_screenutil: ^5.9.0
  go_router: ^12.1.3
  
  # Utilities
  get_it: ^7.6.4
  intl: ^0.19.0
  crypto: ^3.0.3
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Coding Standards
- Follow Dart/Flutter conventions
- Write meaningful commit messages  
- Add tests for new features
- Update documentation as needed
- Maintain MVVM architecture patterns
- Follow the established project structure

## 📚 Learning Resources

- **Google Sheets API**: [spreadsheet_api repository](https://github.com/pahmiudahgede/spreadsheet_api)
- **Flutter Clean Architecture**: [Official Guide](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options#provider)
- **MVVM Pattern**: [Flutter MVVM](https://medium.com/flutter-community/flutter-mvvm-architecture-f8bed2521958)
- **Provider State Management**: [Provider Documentation](https://pub.dev/packages/provider)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy Coding!** 🚀

*Built with ❤️ using Flutter and Google Sheets*