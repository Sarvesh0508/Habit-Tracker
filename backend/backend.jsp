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

    // ---- Habit Section ----
    private void addHabit(HttpServletRequest req, PrintWriter out) {
        String name = req.getParameter("name");
        String xpVal = req.getParameter("xp");

        if (name == null || name.trim().isEmpty()) {
            out.print("{\"error\":\"Habit name is required\"}");
            return;
        }

        int xp = (xpVal != null && !xpVal.isEmpty()) ? Integer.parseInt(xpVal) : 25;

        Map<String, Object> habit = new HashMap<>();
        habit.put("id", UUID.randomUUID().toString());
        habit.put("name", name);
        habit.put("xp", xp);
        habits.add(habit);

        totalXP += xp;
        streak++;
        if (streak > bestStreak) bestStreak = streak;

        out.print("{\"message\":\"Habit added successfully\",\"totalXP\":" + totalXP + "}");
    }

    private void deleteHabit(HttpServletRequest req, PrintWriter out) {
        String id = req.getParameter("id");
        habits.removeIf(h -> h.get("id").equals(id));
        out.print("{\"message\":\"Habit deleted\"}");
    }

    // ---- Diary Section ----
    private void addDiary(HttpServletRequest req, PrintWriter out) {
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Map<String, Object> entry = new HashMap<>();
        entry.put("id", UUID.randomUUID().toString());
        entry.put("title", title == null ? "Untitled" : title);
        entry.put("content", content);
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
                .append("\",\"name\":\"").append(h.get("name"))
                .append("\",\"xp\":").append(h.get("xp")).append("}");
            if (i < habits.size() - 1) json.append(",");
        }
        json.append("],");

        json.append("\"diary\":[");
        for (int i = 0; i < diaryEntries.size(); i++) {
            Map<String, Object> d = diaryEntries.get(i);
            json.append("{\"id\":\"").append(d.get("id"))
                .append("\",\"title\":\"").append(d.get("title"))
                .append("\",\"content\":\"").append(d.get("content"))
                .append("\",\"date\":\"").append(d.get("date")).append("\"}");
            if (i < diaryEntries.size() - 1) json.append(",");
        }
        json.append("]}");

        out.print(json.toString());
    }
}
