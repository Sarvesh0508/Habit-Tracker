package com.streak7;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class BackendController extends HttpServlet {

    // ---- Simulated Database ----
    private List<Map<String, Object>> habits = new ArrayList<>();
    private List<Map<String, Object>> diaryEntries = new ArrayList<>();
    private int totalXP = 0;
    private int streak = 0;
    private int bestStreak = 0;

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        res.setContentType("application/json");
        PrintWriter out = res.getWriter();

        String action = req.getParameter("action");
        if (action == null) {
            out.print("{\"error\":\"Missing action parameter\"}");
            return;
        }

        switch (action) {
            case "addHabit":
                addHabit(req, out);
                break;
            case "deleteHabit":
                deleteHabit(req, out);
                break;
            case "addDiary":
                addDiary(req, out);
                break;
            case "fetchData":
                fetchData(out);
                break;
            default:
                out.print("{\"error\":\"Invalid action\"}");
                break;
        }
    }

    // ---- Helper to Escape JSON String ----
    private String escapeJson(Object val) {
        if (val == null) return "";
        return val.toString()
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r")
            .replace("\t", "\\t");
    }

    // ---- Habit Section ----
    private void addHabit(HttpServletRequest req, PrintWriter out) {
        String name = req.getParameter("name");
        String xpVal = req.getParameter("xp");
        String description = req.getParameter("description");
        if (description == null) description = "";

        if (name == null || name.trim().isEmpty()) {
            out.print("{\"error\":\"Habit name is required\"}");
            return;
        }
        if (name.length() > 100) {
            out.print("{\"error\":\"Habit name cannot exceed 100 characters\"}");
            return;
        }
        if (description.length() > 500) {
            out.print("{\"error\":\"Description cannot exceed 500 characters\"}");
            return;
        }

        int xp = 25;
        if (xpVal != null && !xpVal.isEmpty()) {
            try {
                xp = Integer.parseInt(xpVal);
                if (xp < 5 || xp > 100) {
                    out.print("{\"error\":\"XP must be a number between 5 and 100\"}");
                    return;
                }
            } catch (NumberFormatException e) {
                out.print("{\"error\":\"XP must be a number between 5 and 100\"}");
                return;
            }
        } else {
            out.print("{\"error\":\"XP must be a number between 5 and 100\"}");
            return;
        }

        Map<String, Object> habit = new HashMap<>();
        habit.put("id", UUID.randomUUID().toString());
        habit.put("name", name.trim());
        habit.put("xp", xp);
        habit.put("description", description.trim());
        habit.put("completed", false);
        habits.add(habit);

        totalXP += xp;
        streak++;
        if (streak > bestStreak) bestStreak = streak;

        out.print("{\"message\":\"Habit added successfully\",\"id\":\"" + habit.get("id") + "\",\"totalXP\":" + totalXP + "}");
    }

    private void deleteHabit(HttpServletRequest req, PrintWriter out) {
        String id = req.getParameter("id");
        if (id == null || id.isEmpty()) {
            out.print("{\"error\":\"Habit ID is required\"}");
            return;
        }
        boolean removed = habits.removeIf(h -> h.get("id").equals(id));
        if (!removed) {
            out.print("{\"error\":\"Habit not found\"}");
            return;
        }
        out.print("{\"message\":\"Habit deleted successfully\"}");
    }

    // ---- Diary Section ----
    private void addDiary(HttpServletRequest req, PrintWriter out) {
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        if (content == null || content.trim().isEmpty()) {
            out.print("{\"error\":\"Diary content must be a non-empty string\"}");
            return;
        }
        if (content.length() > 5000) {
            out.print("{\"error\":\"Diary content cannot exceed 5000 characters\"}");
            return;
        }

        String titleVal = title == null ? "Untitled Entry" : title.trim();
        if (titleVal.isEmpty()) {
            titleVal = "Untitled Entry";
        }
        if (titleVal.length() > 200) {
            out.print("{\"error\":\"Title cannot exceed 200 characters\"}");
            return;
        }

        Map<String, Object> entry = new HashMap<>();
        entry.put("id", UUID.randomUUID().toString());
        entry.put("title", titleVal);
        entry.put("content", content.trim());
        entry.put("date", new Date().toString());

        diaryEntries.add(entry);

        out.print("{\"message\":\"Diary entry added successfully\"}");
    }

    // ---- Fetch All Data ----
    private void fetchData(PrintWriter out) {
        StringBuilder json = new StringBuilder("{");
        json.append("\"totalXP\":").append(totalXP).append(",");
        json.append("\"streak\":").append(streak).append(",");
        json.append("\"bestStreak\":").append(bestStreak).append(",");

        json.append("\"habits\":[");
        for (int i = 0; i < habits.size(); i++) {
            Map<String, Object> h = habits.get(i);
            json.append("{\"id\":\"").append(h.get("id"))
                .append("\",\"name\":\"").append(escapeJson(h.get("name")))
                .append("\",\"xp\":").append(h.get("xp"))
                .append(",\"description\":\"").append(escapeJson(h.get("description")))
                .append("\",\"completed\":").append(h.get("completed") != null && (boolean)h.get("completed") ? "true" : "false")
                .append("}");
            if (i < habits.size() - 1) json.append(",");
        }
        json.append("],");

        json.append("\"diary\":[");
        for (int i = 0; i < diaryEntries.size(); i++) {
            Map<String, Object> d = diaryEntries.get(i);
            json.append("{\"id\":\"").append(d.get("id"))
                .append("\",\"title\":\"").append(escapeJson(d.get("title")))
                .append("\",\"content\":\"").append(escapeJson(d.get("content")))
                .append("\",\"date\":\"").append(escapeJson(d.get("date"))).append("\"}");
            if (i < diaryEntries.size() - 1) json.append(",");
        }
        json.append("]}");

        out.print(json.toString());
    }
}
