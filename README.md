# 📋 Questionnaire App (Flutter)

An offline-first Flutter application that dynamically renders questionnaires, captures user responses, records device location metadata, and stores submissions locally using Hive. Backend services are simulated using MockAPI.

This project demonstrates clean architecture principles, user-scoped local persistence, and dynamic UI rendering.

---

## ✨ Features

✅ Dynamic questionnaires fetched from MockAPI  
✅ Offline-first architecture (works without internet)  
✅ Local database using Hive  
✅ Multi-user support with user-scoped submissions  
✅ Location capture during submission  
✅ GetX state management & navigation  
✅ Toast notifications & smooth UX  

---

## 🧱 Architecture Overview

The application follows a clean separation of concerns:

**UI Layer**
- Screens & Widgets
- Stateless presentation logic

**Controller Layer (GetX)**
- Business logic
- State management
- Navigation handling

**Service Layer**
- API communication (MockAPI)
- Local storage abstraction

**Data Layer**
- Hive models & adapters
- Persistent offline storage

---

## 🛠 Tech Stack

- **Flutter** → UI Framework
- **GetX** → State Management & Navigation
- **Hive** → Local NoSQL Database
- **HTTP** → API Communication
- **MockAPI** → Backend Simulation
- **Geolocator** → GPS / Location Services
- **Intl** → Date Formatting
- **FlutterToast** → Notifications
- **Flutter Native Splash** → Splash Screen

---

## 📦 Dependencies

Key packages used in this project:

- `get`
- `http`
- `hive`
- `hive_flutter`
- `path_provider`
- `geolocator`
- `intl`
- `fluttertoast`
- `flutter_native_splash`

---

## 🚀 Setup Instructions

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Adityakaldhone/questionnaire_application_flutter.git
