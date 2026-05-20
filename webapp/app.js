// =======================
// 📡 STREAK7 Frontend API
// =======================

const API = {
  BASE_URL: "backend", // maps to /backend servlet

  // -----------------------
  // HABIT TRACKER FUNCTIONS
  // -----------------------
  async addHabit(name, xp = 25) {
    const body = `action=addHabit&name=${encodeURIComponent(name)}&xp=${xp}`;
    return await this._post(body);
  },

  async deleteHabit(id) {
    const body = `action=deleteHabit&id=${encodeURIComponent(id)}`;
    return await this._post(body);
  },

  // -----------------------
  // DIARY ENTRIES FUNCTIONS
  // -----------------------
  async addDiary(title, content) {
    const body = `action=addDiary&title=${encodeURIComponent(title)}&content=${encodeURIComponent(content)}`;
    return await this._post(body);
  },

  // -----------------------
  // GLOBAL FETCH FUNCTION
  // -----------------------
  async fetchAllData() {
    return await this._post("action=fetchData");
  },

  // -----------------------
  // PRIVATE POST WRAPPER
  // -----------------------
  async _post(body) {
    try {
      const response = await fetch(this.BASE_URL, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body
      });

      if (!response.ok) throw new Error(`HTTP error ${response.status}`);
      const data = await response.json();
      return data;
    } catch (err) {
      console.error("API Error:", err);
      return { error: err.message };
    }
  }
};

// ----------------------------
// 💡 Example UI Integration
// ----------------------------

async function refreshDashboard() {
  const data = await API.fetchAllData();

  if (data.error) {
    console.error("Failed to load:", data.error);
    return;
  }

  // Update XP, streaks, and habit list in DOM
  document.querySelector("#xpCount").textContent = data.totalXP;
  document.querySelector("#streakCount").textContent = data.streak;

  const habitList = document.querySelector("#habitList");
  habitList.innerHTML = "";

  data.habits.forEach(habit => {
    const item = document.createElement("div");
    item.className = "habit-item";
    item.innerHTML = `
      <span>${habit.name}</span>
      <button onclick="removeHabit('${habit.id}')">❌</button>
    `;
    habitList.appendChild(item);
  });
}

async function addNewHabit() {
  const name = document.querySelector("#newHabitName").value;
  const xp = document.querySelector("#newHabitXP").value || 25;

  if (!name.trim()) {
    alert("Please enter a habit name");
    return;
  }

  await API.addHabit(name, xp);
  document.querySelector("#newHabitName").value = "";
  refreshDashboard();
}

async function removeHabit(id) {
  await API.deleteHabit(id);
  refreshDashboard();
}

async function addDiaryEntry() {
  const title = document.querySelector("#diaryTitle").value;
  const content = document.querySelector("#diaryContent").value;

  if (!content.trim()) {
    alert("Write something in your diary!");
    return;
  }

  await API.addDiary(title, content);
  document.querySelector("#diaryTitle").value = "";
  document.querySelector("#diaryContent").value = "";
  alert("Diary entry saved successfully!");
}
