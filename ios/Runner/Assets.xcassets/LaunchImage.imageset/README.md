# 📋 Questionnaire Application (Flutter)

An offline-first Flutter application that dynamically renders questionnaires, captures user responses, records location metadata, and stores submissions locally using Hive. The app uses MockAPI to simulate backend services and GetX for state management.

---

## ✨ Features

✅ Dynamic questionnaires fetched from MockAPI  
✅ Offline-first architecture (works without internet)  
✅ Local persistence using Hive database  
✅ Multi-user login with user-scoped data isolation  
✅ Location capture at submission time  
✅ Clean state management with GetX  
✅ Smooth and responsive UI  

---

## 🧱 Architecture Overview

The app follows a clean separation of concerns:

- **UI Layer** → Screens & Widgets
- **Controller Layer (GetX)** → Business logic & state
- **Service Layer** → API & Local Storage
- **Data Layer** → Hive Models

---

## 🛠 Tech Stack

- **Flutter**
- **GetX** (State Management & Navigation)
- **Hive** (Local Database)
- **MockAPI** (Backend Simulation)
- **Geolocator** (GPS / Location Services)

---

## 📦 Data Persistence Strategy

This application uses an **offline-first design**:

- Questionnaires → Fetched from MockAPI
- Submissions → Stored locally via Hive
- Data Isolation → Submissions scoped per logged-in user

This prevents cross-user data leakage on shared devices.

---

## 🚀 Getting Started

### 1️⃣ Clone the repository

```bash
git clone https://github.com/Adityakaldhone/questionnaire_application_flutter.git
