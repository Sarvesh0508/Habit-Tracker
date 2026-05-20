// =========================================
// 🚀 STREAK7 - Node.js Backend (Single File)
// =========================================

import express from "express";
import bodyParser from "body-parser";
import cors from "cors";

const app = express();
const PORT = process.env.PORT || 8080;

app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// -------------------------------
// 🧠 In-Memory “Database”
// -------------------------------
let habits = [];
let diaryEntries = [];
let totalXP = 0;
let streak = 0;
let bestStreak = 0;

// -------------------------------
// 🪄 Helper Functions
// -------------------------------
function updateXP(xpValue) {
  totalXP += xpValue;
  streak++;
  if (streak > bestStreak) bestStreak = streak;
}

// -------------------------------
// 🧩 ROUTES
// -------------------------------

// ✅ Add Habit
app.post("/addHabit", (req, res) => {
  const { name, xp } = req.body;
  if (!name) return res.status(400).json({ error: "Habit name is required" });

  const habit = {
    id: Date.now().toString(),
    name,
    xp: Number(xp) || 25,
  };

  habits.push(habit);
  updateXP(habit.xp);

  res.json({
    message: "Habit added successfully",
    totalXP,
    streak,
    bestStreak,
  });
});

// ✅ Delete Habit
app.post("/deleteHabit", (req, res) => {
  const { id } = req.body;
  habits = habits.filter((h) => h.id !== id);
  res.json({ message: "Habit deleted successfully" });
});

// ✅ Add Diary Entry
app.post("/addDiary", (req, res) => {
  const { title, content } = req.body;
  if (!content) return res.status(400).json({ error: "Diary content required" });

  const entry = {
    id: Date.now().toString(),
    title: title || "Untitled Entry",
    content,
    date: new Date().toLocaleString(),
  };

  diaryEntries.push(entry);
  res.json({ message: "Diary entry added successfully" });
});

// ✅ Fetch All Data
app.post("/fetchData", (req, res) => {
  res.json({
    totalXP,
    streak,
    bestStreak,
    habits,
    diary: diaryEntries,
  });
});

// ✅ Reset All Data (optional dev route)
app.post("/reset", (req, res) => {
  habits = [];
  diaryEntries = [];
  totalXP = 0;
  streak = 0;
  bestStreak = 0;
  res.json({ message: "All data reset" });
});

// -------------------------------
// 🚀 Start Server
// -------------------------------
app.listen(PORT, () => {
  console.log(`✅ STREAK7 Backend running at http://localhost:${PORT}`);
});
