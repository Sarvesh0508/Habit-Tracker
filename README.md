# 📊 Streak7 - Professional Gamified Habit Tracker & Productivity Suite

Streak7 is a modern, responsive, and feature-rich gamified productivity dashboard designed to help users establish habits, document daily reflections, and optimize focus using the Pomodoro technique. The project features full responsiveness, dynamic charts, progress analytics, and dual-mode persistence (browser LocalStorage for standalone use and a RESTful backend API).

---

## 🚀 Key Features

*   **Gamified XP and Leveling System:** Earn XP by completing habits (+15 to +40 XP depending on difficulty), focusing with the Pomodoro timer (+15 XP), or writing diary entries (+10 XP). Level up automatically for every 100 XP accumulated!
*   **Persistent Habit Checklist:** Add, track, and complete daily habits with check-off mechanics.
*   **Editable User Profile:** Customize your profile's Full Name and Email directly within the user details card (with zero-flash placeholder fallbacks to "Guest User").
*   **Premium Visual Page Loader:** Fully responsive Netflix-style loading overlay with dynamic CSS spinner to prevent initial Layout Flash (FOUC).
*   **Activity Heatmap:** Visualizes daily habit completions over the past 28 days using a GitHub-style contribution grid.
*   **Interactive Analytics Graphs:** Beautiful bar charts displaying daily XP gains and habit completion rates for the past 7 days.
*   **Integrated Pomodoro Timer:** High-intensity interval focus timer with a progress pulse animation and completion reward.
*   **Personal Diary Journal:** Record thoughts, goals, and reflections with a title and timestamp.
*   **Comprehensive Test Suite:** Backend testing with native Node.js asserts covering routes validation, data updates, and 404 responses.
*   **Recruiter-Friendly Architecture:** Implements a multi-layered design. Runs immediately in any browser using LocalStorage persistence, or connects to the Node.js/SQLite REST API or Java JSP Controller.

---

## 🛠️ Technology Stack & Architecture

### Frontend (Client Side)
*   **UI/UX:** Vanilla HTML5, CSS3 Custom Properties (Netflix-style dark mode theme), CSS Grid/Flexbox layouts.
*   **State Machine:** React-like central application state (`appState`) with a pub-sub UI rendering cycle.
*   **Visualizations:** Custom DOM-based rendering for charts and heatmaps (no bulky external charting libraries).
*   **Micro-Animations:** Fluid CSS transitions, floating keyframe animations (`+XP` float-up effects), pulse timers, and level-up flashes.

### Backend Options (Server Side)
1.  **Node.js / Express Server:**
    *   REST API endpoints for CRUD habit actions, diary logging, and stat increments.
    *   **SQLite Persistence:** Structured database schemas utilizing Node `sqlite3` driver with Promise-based asynchronous queries.
2.  **Java Servlet Controller:**
    *   OOP architecture executing under a Tomcat container.
    *   Dispatches servlet requests via standard routing parameters using HttpServlet mapping.

---

## 📁 Repository Structure

```text
Habit-Tracker/
├── backend/
│   ├── back.js            # Node.js/Express SQLite REST Server
│   ├── package.json       # Node.js dependencies configuration
│   └── backend.jsp        # Java Servlet controller class
├── webapp/
│   ├── WEB-INF/
│   │   └── web.xml        # Servlet web app deployment descriptor
│   ├── app.js             # Client-side API fetch wrapper
│   └── index.jsp          # Main frontend app page (HTML, CSS, JS Engine)
└── README.md              # Documentation
```

---

## 🏁 Quick Start & Setup

### Option A: Standalone Browser Mode (No Server Required)
Simply double-click the `index.html` file in the root of the repository or open it in any modern browser. All features—including habit completions, Pomodoro sessions, diary entries, history logs, heatmap activity, streaks, and editable profiles—are automatically saved to your browser's `LocalStorage`.

### Option B: Node.js SQLite API Server
1. Navigate to the `backend` directory:
   ```bash
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the Express server:
   ```bash
   npm start
   ```
   The backend API will start running at `http://localhost:8080` and initialize a SQLite database file `streak7.db` automatically.

### 🧪 Running Tests
The backend includes a zero-dependency integration test suite using Node's built-in test runner.
1. Navigate to the `backend` directory:
   ```bash
   cd backend
   ```
2. Run the test command:
   ```bash
   npm test
   ```
   This will spin up a temporary server on port `9000`, validate the API endpoints (including POST actions, parameters validation, 404 status codes for invalid IDs), and cleanly shut down the server.

### Option C: Java Web Application (Tomcat Servlet)
1. Deploy the `webapp` folder into the `webapps` directory of your Apache Tomcat installation (e.g., inside XAMPP Tomcat).
2. Start the Tomcat server.
3. Access the application via `http://localhost:8080/Habit-Tracker/` (or the mapped servlet context path).

---

## 📋 API Design (REST Endpoints)

| HTTP Method | Endpoint | Description | Request Body |
| :--- | :--- | :--- | :--- |
| **POST** | `/fetchData` | Retrieves all habits, diary entries, and user stats. | `{}` |
| **POST** | `/addHabit` | Creates a new habit and increments total XP. | `{"name": "Exercise", "xp": 25, "description": "30 mins"}` |
| **POST** | `/deleteHabit` | Deletes an existing habit by unique identifier. | `{"id": "1716912345678"}` |
| **POST** | `/addDiary` | Creates a new time-stamped diary entry. | `{"title": "Day 1", "content": "Learned SQLite!"}` |
| **POST** | `/reset` | Resets all statistics, habits, and entries. | `{}` |

---

## 🛡️ Best Coding Practices Implemented
*   **Security:** Avoids code injections by using parametrized SQL queries in the SQLite database driver.
*   **Zero-Dependency Frontend:** The UI is fast, clean, and requires no React, Vue, or Tailwind, demonstrating a deep understanding of core web fundamentals (HTML/CSS/JS).
*   **Fallback Architecture:** The frontend automatically checks for active backend configurations, maintaining seamless functionality via local state persistence when run offline.