// ==========================================
// 🚀 STREAK7 - Node.js Backend (SQLite Persistence)
// ==========================================

import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import sqlite3 from "sqlite3";
import { fileURLToPath } from "url";
import path from "path";

const app = express();
const PORT = process.env.PORT || 8080;

app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Set up database directory and path
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const dbPath = path.resolve(__dirname, "streak7.db");

console.log(`📡 Database file location: ${dbPath}`);

const db = new sqlite3.Database(dbPath, (err) => {
  if (err) {
    console.error("❌ Error opening SQLite database:", err.message);
  } else {
    console.log("✔ Connected to SQLite database successfully.");
  }
});

// Initialize database schema
db.serialize(() => {
  db.run(`CREATE TABLE IF NOT EXISTS habits (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    xp INTEGER NOT NULL,
    description TEXT,
    completed INTEGER DEFAULT 0
  )`);

  db.run(`CREATE TABLE IF NOT EXISTS diary_entries (
    id TEXT PRIMARY KEY,
    title TEXT,
    content TEXT NOT NULL,
    date TEXT NOT NULL
  )`);

  db.run(`CREATE TABLE IF NOT EXISTS stats (
    key TEXT PRIMARY KEY,
    value INTEGER
  )`);
  
  // Insert default stats if they don't already exist
  db.run(`INSERT OR IGNORE INTO stats (key, value) VALUES ('totalXP', 1250)`);
  db.run(`INSERT OR IGNORE INTO stats (key, value) VALUES ('streak', 7)`);
  db.run(`INSERT OR IGNORE INTO stats (key, value) VALUES ('bestStreak', 21)`);
});

// SQLite Promise wrappers
const dbRun = (query, params = []) => {
  return new Promise((resolve, reject) => {
    db.run(query, params, function (err) {
      if (err) reject(err);
      else resolve(this);
    });
  });
};

const dbAll = (query, params = []) => {
  return new Promise((resolve, reject) => {
    db.all(query, params, (err, rows) => {
      if (err) reject(err);
      else resolve(rows);
    });
  });
};

const dbGet = (query, params = []) => {
  return new Promise((resolve, reject) => {
    db.get(query, params, (err, row) => {
      if (err) reject(err);
      else resolve(row);
    });
  });
};

// ==========================================
// 🧩 API ROUTES
// ==========================================

// ✅ Add Habit
app.post("/addHabit", async (req, res) => {
  try {
    const { name, xp, description } = req.body;
    if (typeof name !== "string" || !name.trim()) {
      return res.status(400).json({ error: "Habit name must be a non-empty string" });
    }
    if (name.length > 100) {
      return res.status(400).json({ error: "Habit name cannot exceed 100 characters" });
    }

    const xpVal = Number(xp);
    if (isNaN(xpVal) || xpVal < 5 || xpVal > 100) {
      return res.status(400).json({ error: "XP must be a number between 5 and 100" });
    }

    const descVal = description || "";
    if (descVal.length > 500) {
      return res.status(400).json({ error: "Description cannot exceed 500 characters" });
    }

    const id = Date.now().toString();

    await dbRun(
      "INSERT INTO habits (id, name, xp, description, completed) VALUES (?, ?, ?, ?, 0)",
      [id, name.trim(), xpVal, descVal.trim()]
    );

    // Fetch and increment total XP
    const xpRow = await dbGet("SELECT value FROM stats WHERE key = 'totalXP'");
    const totalXP = (xpRow ? xpRow.value : 0) + xpVal;
    await dbRun("UPDATE stats SET value = ? WHERE key = 'totalXP'", [totalXP]);

    // Fetch current streak values
    const streakRow = await dbGet("SELECT value FROM stats WHERE key = 'streak'");
    const bestStreakRow = await dbGet("SELECT value FROM stats WHERE key = 'bestStreak'");
    
    res.json({
      message: "Habit added successfully",
      id,
      totalXP,
      streak: streakRow ? streakRow.value : 0,
      bestStreak: bestStreakRow ? bestStreakRow.value : 0,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ✅ Delete Habit
app.post("/deleteHabit", async (req, res) => {
  try {
    const { id } = req.body;
    if (!id) {
      return res.status(400).json({ error: "Habit ID is required" });
    }

    const result = await dbRun("DELETE FROM habits WHERE id = ?", [id]);
    if (result.changes === 0) {
      return res.status(404).json({ error: "Habit not found" });
    }
    res.json({ message: "Habit deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ✅ Add Diary Entry
app.post("/addDiary", async (req, res) => {
  try {
    const { title, content } = req.body;
    if (typeof content !== "string" || !content.trim()) {
      return res.status(400).json({ error: "Diary content must be a non-empty string" });
    }
    if (content.length > 5000) {
      return res.status(400).json({ error: "Diary content cannot exceed 5000 characters" });
    }

    const titleVal = title || "Untitled Entry";
    if (typeof titleVal !== "string" || titleVal.length > 200) {
      return res.status(400).json({ error: "Title cannot exceed 200 characters" });
    }

    const id = Date.now().toString();
    const dateStr = new Date().toLocaleString();

    await dbRun(
      "INSERT INTO diary_entries (id, title, content, date) VALUES (?, ?, ?, ?)",
      [id, titleVal.trim(), content.trim(), dateStr]
    );
    res.json({ message: "Diary entry added successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ✅ Fetch All Data
app.post("/fetchData", async (req, res) => {
  try {
    const habits = await dbAll("SELECT * FROM habits");
    const diary = await dbAll("SELECT * FROM diary_entries ORDER BY id DESC");

    const totalXPRow = await dbGet("SELECT value FROM stats WHERE key = 'totalXP'");
    const streakRow = await dbGet("SELECT value FROM stats WHERE key = 'streak'");
    const bestStreakRow = await dbGet("SELECT value FROM stats WHERE key = 'bestStreak'");

    res.json({
      totalXP: totalXPRow ? totalXPRow.value : 0,
      streak: streakRow ? streakRow.value : 0,
      bestStreak: bestStreakRow ? bestStreakRow.value : 0,
      habits: habits.map((h) => ({ ...h, completed: !!h.completed })),
      diary,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ✅ Reset All Data
app.post("/reset", async (req, res) => {
  try {
    await dbRun("DELETE FROM habits");
    await dbRun("DELETE FROM diary_entries");
    await dbRun("UPDATE stats SET value = 0 WHERE key = 'totalXP'");
    await dbRun("UPDATE stats SET value = 0 WHERE key = 'streak'");
    await dbRun("UPDATE stats SET value = 0 WHERE key = 'bestStreak'");
    res.json({ message: "All data reset successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 🚀 Start Server
app.listen(PORT, () => {
  console.log(`✅ STREAK7 Backend running at http://localhost:${PORT}`);
});
