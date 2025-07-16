# 📱 Data Collection Flutter App & SDK

A lightweight system for collecting SMS and Call Log data on Android devices, built with **Flutter**, **Dart**, and a simple **Node.js backend API**.  
This project shows how to handle permissions, design a reusable SDK, batch events smartly, and send them securely to a backend — perfect for **fintech**, **analytics**, or **research** use cases.

---

## 🚀 Overview

**Core Components:**
- **Flutter App** — Handles permissions, reads SMS & Call Logs, and passes them to the SDK.
- **Custom Dart SDK** — Batches data, detects transactional SMS, and talks to the backend.
- **Backend API** — A minimal Node.js server to receive and log incoming events.

---

## 📂 Project Structure

clickpe/
├── app/ # Flutter app source
├── sdk/ # Reusable Dart SDK
├── backend/ # Node.js Express API server

---

## 🧩 How It Works

✅ **Flutter App**
- Requests permissions for SMS & Call Logs.
- Reads device data when granted.
- Initializes the SDK and sends events.
- Shows permission status & logs.

✅ **Dart SDK**
- Buffers non-transactional SMS & Call Logs.
- Detects transactional SMS by keywords (`otp`, `transaction`, `debited`, `credited`, `spent`) and sends them immediately.
- Flushes the buffer in batches of 50.

✅ **Backend**
- POST `/v1/events` endpoint.
- Receives JSON payloads and logs them.

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
```
### 2️⃣ Run the Backend

```bash
cd backend
npm install
node index.js
```
The backend will run on http://localhost:8000 by default.

### 3️⃣ Run the Flutter App

```bash
cd ../app
flutter pub get
flutter run
```
✅ Make sure an Android emulator is running or connect a real device.

---

## 📊 Architecture Diagram

```bash
 ┌────────────┐         ┌─────────────┐         ┌─────────────┐
 │  Flutter   │  ──▶──  │ Dart SDK 🧩 │  ──▶──  │  Backend API│
 │  App 📱     │        │ (Buffering) │         │  (Node.js)  │
 └────────────┘         └─────────────┘         └─────────────┘
```

---

## ✅ Demo Video
📽️ Watch the Assignment Walkthrough
(Replace # with your actual video link)

---

## 📜 SDK Design
**Public API**: initialize(), trackSms(), trackCallLog()

**Buffer**: Holds events in-memory.

**Immediate Send**: If SMS is transactional.

**Batch Send**: Flushes buffer when 50 events collected.

---

## 👤 Author
Riddhi Lahare
GitHub | LinkedIn
