# 📊 Streak7 - Professional Gamified Habit Tracker & Productivity Suite

**⚡ Live Demo:** [https://habit-tracker-ifzv.vercel.app/](https://habit-tracker-ifzv.vercel.app/)

Streak7 is a modern, responsive, and feature-rich gamified productivity dashboard designed to help users establish habits, document daily reflections, and optimize focus using the Pomodoro technique. The project features a unified dark-mode matte glassmorphic design, balanced grid system layouts, dynamic charts, progress analytics, and dual-mode persistence (browser LocalStorage for standalone use and a RESTful backend API).

---

## 🚀 Key Features

*   **Premium Header Navigation:** Fully integrated inline tab navigation (`Dashboard`, `Habits`, `Goals` -> Progress, `Community` -> Diary, `Rewards` -> Profile) embedded inside the top fixed header with a custom logo container (stylized red '7' SVG icon + text), dynamic avatar letter rendering, user name, level, and dropdown caret.
*   **Evenly Distributed Columns (No Wasted Space):** Balanced grid system column heights by placing the Checklist, Streak Summary, Achievements, and reflections in the left column, while analytics graphs and the Pomodoro timer sit in the right column, leaving zero empty spaces.
*   **Gamified XP and Leveling System:** Earn XP by completing habits (+15 to +40 XP depending on difficulty), focusing with the Pomodoro timer (+15 XP), or writing diary reflections (+10 XP). Level up automatically for every 100 XP accumulated!
*   **Persistent Habit Checklist:** Track and complete daily habits with custom-styled checkboxes, individual completion streak tracking, and horizontal percentage progress bars.
*   **Quick Journal / Reflections Card:** Directly log diary thoughts from the dashboard tab. Features input titles, description textareas, one-click reflections save, and a dynamic "Recent Entries" preview card synced with the main Diary tab.
*   **Interactive Pomodoro Timer:** High-intensity interval focus timer featuring a circular SVG progress ring countdown animation, short break controls, pulse timer effects, and automatic focus completions.
*   **Achievements & Badges:** Progress tracking bar showing XP progress toward the next level, and 4 toggleable achievement badges (*Consistency Champ*, *Night Owl*, *Early Riser*, *10-Day Streak*) that unlock dynamically based on user stats.
*   **Editable User Profile:** Customize your profile's Full Name and Email directly within the user details card (with zero-flash placeholder fallbacks to "Guest User" and standalone client persistence).
*   **Activity Heatmap:** Visualizes daily habit completions over the past 28 days using a GitHub-style contribution grid with color intensity ranges.
*   **Interactive Analytics Graphs:** Beautiful vertical bar charts displaying daily XP gains and habit completion rates for the past 7 days.
*   **Comprehensive Test Suite:** Backend testing with native Node.js asserts covering routes validation, parameters check-in, and 404 error responses.
*   **Recruiter-Friendly Architecture:** Implements a multi-layered design. Runs immediately in any browser using LocalStorage persistence, or connects to the Node.js/SQLite REST API or Java JSP Controller.

---

## 🛠️ Technology Stack & Architecture

### Frontend (Client Side)
*   **UI/UX:** Vanilla HTML5, CSS3 Custom Properties (matte dark theme), CSS Grid/Flexbox layouts, glassmorphic frosted-glass cards, and custom Google Fonts ('Inter' and 'Outfit').
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
├── .github/
│   └── workflows/
│       └── test.yml       # Node.js CI test workflow for GitHub Actions
├── backend/
│   ├── back.js            # Node.js/Express SQLite REST Server
│   ├── package.json       # Node.js dependencies configuration
│   └── backend.jsp        # Java Servlet controller class
├── webapp/
│   ├── WEB-INF/
│   │   └── web.xml        # Servlet web app deployment descriptor
│   ├── app.js             # Client-side API fetch wrapper
│   └── index.jsp          # Main frontend app page (HTML, CSS, JS Engine)
├── index.html             # Standalone frontend client page (HTML, CSS, JS Engine)
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