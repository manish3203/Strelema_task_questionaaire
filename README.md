# 🖥️ Digital Questionnaire Platform (Flutter)

A robust, offline-capable Flutter application engineered to deliver dynamic surveys to end users, record geo-tagged responses, and persist structured data locally — all without requiring continuous network access. REST integration is handled through MockAPI, simulating production backend behavior.

Built to showcase scalable architecture patterns, device-aware data collection, and per-user data isolation in a mobile-first environment.

---

## ✨ Capabilities

✅ Surveys rendered dynamically from remote API  
✅ Offline-first design — fully functional without internet  
✅ Structured local persistence via Hive NoSQL database  
✅ Isolated data per user — no cross-user data leakage  
✅ Geo-coordinates captured and stored at submission time  
✅ Reactive state management and routing via GetX  
✅ Contextual toast feedback throughout the user journey  

---

## 🧱 Architecture

The platform is structured around a strict separation of responsibilities:

**Presentation Layer**
- Screens & reusable widget components
- Purely declarative, logic-free UI

**Controller Layer (GetX)**
- All business logic encapsulated here
- Drives reactive state and screen transitions

**Service Layer**
- HTTP communication with MockAPI
- Abstracted local storage interface

**Data Layer**
- Hive-backed models with registered TypeAdapters
- Durable offline-first data contracts

---

## 🛠 Tech Stack

| Concern | Tool |
|---|---|
| UI Framework | Flutter |
| State & Navigation | GetX |
| Local Database | Hive |
| Network | HTTP |
| Backend Simulation | MockAPI |
| Location Services | Geolocator |
| Date Formatting | Intl |
| In-app Notifications | FlutterToast |
| Splash Screen | Flutter Native Splash |

---

## 📦 Package Dependencies

```yaml
dependencies:
  get:
  http:
  hive:
  hive_flutter:
  path_provider:
  geolocator:
  intl:
  fluttertoast:
  flutter_native_splash:
```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git https://github.com/manish3203/Strelema_task_questionaaire.git
cd Strelema_task_questionaaire
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Run the Application

```bash
flutter run
```