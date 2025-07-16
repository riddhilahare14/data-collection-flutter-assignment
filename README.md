# 📱 Data Collection Flutter App & SDK

A lightweight system for collecting SMS and Call Log data on Android devices, built with Flutter, Dart, and a minimal Node.js backend API.  
This project demonstrates permission handling, custom SDK design, intelligent batching, and secure backend data flow — ideal for fintech, analytics, or research use cases.

---

## 🚀 Overview

**Core Components:**
- **Flutter App**: Handles permissions, reads SMS and Call Logs, and passes them to the SDK.
- **Custom Dart SDK**: Batches data, detects transactional SMS, and communicates with the backend.
- **Backend API**: A simple Node.js server to receive and log incoming events.

---

## 📂 Project Structure

clickpe/
├── app/ # Flutter app source code
├── sdk/ # Reusable Dart SDK module
├── backend/ # Node.js Express API server

yaml
Copy
Edit

---

## 🧩 How It Works

✅ **1. Flutter App**
- Requests permissions to read SMS and Call Logs.
- Reads device data once permissions are granted.
- Initializes the custom SDK and sends events one by one.
- Displays permission status & logs events sent.

✅ **2. Dart SDK**
- Buffers non-transactional SMS & Call Logs.
- Detects transactional SMS by keywords (`OTP`, `transaction`, `debited`, `credited`, `spent`) and sends them immediately.
- Flushes the buffer in batches of 50.

✅ **3. Backend**
- A simple POST `/v1/events` endpoint.
- Receives JSON payloads and logs them to console or file.

---

## 📌 Tech Stack

- **Mobile App:** Flutter, Dart
- **SDK:** Pure Dart module
- **Backend:** Node.js + Express

---

## 🛠️ Getting Started

### 1️⃣ Clone the repo

```bash
git clone https://github.com/riddhilahare14/data-collection-flutter-assignment.git
cd data-collection-flutter-assignment
2️⃣ Run the Backend
bash
Copy
Edit
cd backend
npm install
node index.js
The backend will run on http://localhost:3000 by default.

3️⃣ Run the Flutter App
bash
Copy
Edit
cd ../app
flutter pub get
flutter run
✅ Make sure an Android emulator is running or connect a real device.

📊 Architecture Diagram
plaintext
Copy
Edit
 ┌────────────┐         ┌─────────────┐         ┌─────────────┐
 │  Flutter   │  ──▶──  │ Dart SDK 🧩 │  ──▶──  │  Backend API │
 │  App 📱     │         │ (Buffering) │         │  (Node.js)   │
 └────────────┘         └─────────────┘         └─────────────┘
✅ Demo Video
📽️ Watch the Assignment Walkthrough
(Replace # with your actual video link)

📜 SDK Design
Public API: initialize, trackSms(), trackCallLog()

Buffer: Holds events in-memory.

Immediate Send: If SMS is transactional.

Batch Send: Flushes buffer when 50 events collected.

👤 Author
Riddhi Lahare
GitHub | LinkedIn