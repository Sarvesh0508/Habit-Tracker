import assert from "node:assert";
import test from "node:test";
import { spawn } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const backendPath = path.resolve(__dirname, "../back.js");

test("Streak7 API Backend Test Suite", async (t) => {
  // Start the server on a test port (9000)
  const serverProcess = spawn("node", [backendPath], {
    env: { ...process.env, PORT: "9000" },
    stdio: "pipe",
  });

  // Wait for the server to spin up and log its startup message
  await new Promise((resolve) => {
    serverProcess.stdout.on("data", (data) => {
      if (data.toString().includes("Backend running")) {
        resolve();
      }
    });
  });

  const baseUrl = "http://localhost:9000";

  await t.test("POST /addHabit adds a habit and returns 200 with stats", async () => {
    const res = await fetch(`${baseUrl}/addHabit`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        name: "Test Exercise",
        xp: 50,
        description: "Test daily exercise",
      }),
    });
    
    assert.strictEqual(res.status, 200);
    const data = await res.json();
    assert.strictEqual(data.message, "Habit added successfully");
    assert.ok(data.id);
    assert.ok(data.totalXP >= 50);
  });

  await t.test("POST /addHabit fails when name is missing", async () => {
    const res = await fetch(`${baseUrl}/addHabit`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        xp: 50,
      }),
    });
    
    assert.strictEqual(res.status, 400);
    const data = await res.json();
    assert.strictEqual(data.error, "Habit name is required");
  });

  await t.test("POST /deleteHabit returns 404 for invalid ID", async () => {
    const res = await fetch(`${baseUrl}/deleteHabit`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        id: "nonexistent-id-12345",
      }),
    });
    
    assert.strictEqual(res.status, 404);
    const data = await res.json();
    assert.strictEqual(data.error, "Habit not found");
  });

  await t.test("POST /fetchData returns habits list", async () => {
    const res = await fetch(`${baseUrl}/fetchData`, {
      method: "POST",
    });
    
    assert.strictEqual(res.status, 200);
    const data = await res.json();
    assert.ok(Array.isArray(data.habits));
    assert.ok(Array.isArray(data.diary));
    assert.ok(typeof data.totalXP === "number");
  });

  // Clean up and kill server process
  serverProcess.kill();
});
