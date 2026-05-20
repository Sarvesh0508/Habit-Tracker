<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Streak7</title>
    <style>
        :root {
            --netflix-black: #141414;
            --netflix-dark: #181818;
            --netflix-red: #e50914;
            --netflix-white: #ffffff;
            --netflix-gray: #808080;
            --netflix-light-gray: #2f2f2f;
            --primary: #e50914;
            --secondary: #b20710;
            --accent: #ff6b6b;
            --success: #2ecc71;
            --warning: #f39c12;
            --info: #3498db;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Netflix Sans', 'Helvetica Neue', Arial, sans-serif;
        }
        
        body {
            background: var(--netflix-black);
            color: var(--netflix-white);
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .netflix-header {
            background: linear-gradient(180deg, rgba(0,0,0,0.8) 0%, transparent 100%);
            padding: 20px 50px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: var(--transition);
        }
        
        .netflix-header.scrolled {
            background: var(--netflix-black);
        }
        
        .logo {
            font-size: 2rem;
            font-weight: bold;
            color: var(--netflix-red);
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .nav-tabs {
            display: flex;
            gap: 30px;
            background: rgba(0,0,0,0.8);
            padding: 15px 50px;
            margin-top: 80px;
            border-bottom: 1px solid var(--netflix-light-gray);
        }
        
        .nav-tab {
            padding: 10px 20px;
            cursor: pointer;
            transition: var(--transition);
            border-radius: 4px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }
        
        .nav-tab:hover {
            background: var(--netflix-light-gray);
            transform: translateY(-2px);
        }
        
        .nav-tab.active {
            background: var(--netflix-red);
            color: var(--netflix-white);
        }
        
        .tab-content {
            display: none;
            padding: 40px 50px;
            min-height: 80vh;
        }
        
        .tab-content.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }
        
        .hero-section {
            background: linear-gradient(135deg, rgba(229,9,20,0.1) 0%, rgba(0,0,0,0.9) 100%);
            padding: 100px 50px 50px;
            border-radius: 10px;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="%23e50914" opacity="0.05"><polygon points="0,0 1000,50 1000,100 0,100"/></svg>');
            background-size: cover;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            background: linear-gradient(45deg, var(--netflix-white), var(--netflix-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        
        .hero-subtitle {
            font-size: 1.2rem;
            color: var(--netflix-gray);
            margin-bottom: 30px;
            max-width: 600px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .stat-card {
            background: var(--netflix-dark);
            padding: 25px;
            border-radius: 8px;
            border-left: 4px solid var(--netflix-red);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--netflix-red);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(229,9,20,0.2);
        }
        
        .stat-title {
            font-size: 0.9rem;
            color: var(--netflix-gray);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--netflix-white);
        }
        
        .pomodoro-timer {
            background: var(--netflix-dark);
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            margin: 40px 0;
            border: 1px solid var(--netflix-light-gray);
            position: relative;
            overflow: hidden;
        }
        
        .timer-display {
            font-size: 5rem;
            font-weight: bold;
            margin: 30px 0;
            color: var(--netflix-white);
            text-shadow: 0 0 20px rgba(229,9,20,0.5);
            font-family: 'Courier New', monospace;
        }
        
        .timer-controls {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }
        
        .btn-primary {
            background: var(--netflix-red);
            color: var(--netflix-white);
        }
        
        .btn-primary:hover {
            background: var(--secondary);
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(229,9,20,0.4);
        }
        
        .btn-secondary {
            background: transparent;
            color: var(--netflix-white);
            border: 2px solid var(--netflix-gray);
        }
        
        .btn-secondary:hover {
            border-color: var(--netflix-white);
            transform: scale(1.05);
        }
        
        .habits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .habit-card {
            background: var(--netflix-dark);
            padding: 25px;
            border-radius: 8px;
            border: 1px solid var(--netflix-light-gray);
            transition: var(--transition);
            position: relative;
        }
        
        .habit-card:hover {
            border-color: var(--netflix-red);
            transform: translateY(-3px);
        }
        
        .habit-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .habit-name {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--netflix-white);
        }
        
        .habit-xp {
            background: var(--warning);
            color: var(--netflix-black);
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.8rem;
        }
        
        .add-habit-form {
            background: var(--netflix-dark);
            padding: 30px;
            border-radius: 8px;
            margin: 30px 0;
            border: 2px dashed var(--netflix-light-gray);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--netflix-gray);
            font-weight: 500;
        }
        
        .form-input {
            width: 100%;
            padding: 12px;
            background: var(--netflix-black);
            border: 1px solid var(--netflix-light-gray);
            border-radius: 4px;
            color: var(--netflix-white);
            font-size: 1rem;
            transition: var(--transition);
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--netflix-red);
            box-shadow: 0 0 0 2px rgba(229,9,20,0.2);
        }
        
        .profile-container {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 40px;
            margin: 30px 0;
        }
        
        .profile-sidebar {
            background: var(--netflix-dark);
            padding: 30px;
            border-radius: 8px;
            text-align: center;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--netflix-red), var(--accent));
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: bold;
            color: var(--netflix-white);
            border: 4px solid var(--netflix-white);
        }
        
        .profile-details {
            text-align: left;
            margin-top: 20px;
        }
        
        .profile-detail {
            margin-bottom: 15px;
            padding: 10px;
            background: var(--netflix-black);
            border-radius: 4px;
        }
        
        .detail-label {
            font-size: 0.8rem;
            color: var(--netflix-gray);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .detail-value {
            font-size: 1rem;
            color: var(--netflix-white);
            font-weight: 500;
        }
        
        .heatmap-container {
            background: var(--netflix-dark);
            padding: 30px;
            border-radius: 8px;
            margin: 30px 0;
        }
        
        .heatmap {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
            margin: 20px 0;
        }
        
        .heatmap-day {
            height: 30px;
            background: var(--netflix-light-gray);
            border-radius: 2px;
            transition: var(--transition);
            position: relative;
        }
        
        .heatmap-day.active {
            background: var(--success);
        }
        
        .heatmap-day.high {
            background: var(--netflix-red);
        }
        
        .heatmap-day.medium {
            background: var(--warning);
        }
        
        .heatmap-day.low {
            background: var(--info);
        }
        
        .graph-container {
            background: var(--netflix-dark);
            padding: 30px;
            border-radius: 8px;
            margin: 30px 0;
        }
        
        .graph {
            height: 300px;
            background: var(--netflix-black);
            border-radius: 4px;
            position: relative;
            overflow: hidden;
        }
        
        .graph-bar {
            position: absolute;
            bottom: 0;
            background: var(--netflix-red);
            transition: var(--transition);
            border-radius: 2px 2px 0 0;
        }
        
        .diary-entries {
            display: grid;
            gap: 20px;
            margin: 30px 0;
        }
        
        .diary-entry {
            background: var(--netflix-dark);
            padding: 25px;
            border-radius: 8px;
            border-left: 4px solid var(--netflix-red);
            transition: var(--transition);
        }
        
        .diary-entry:hover {
            transform: translateX(5px);
            border-left-color: var(--accent);
        }
        
        .entry-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .entry-title {
            font-size: 1.3rem;
            font-weight: bold;
            color: var(--netflix-white);
        }
        
        .entry-date {
            color: var(--netflix-gray);
            font-size: 0.9rem;
        }
        
        .entry-content {
            color: var(--netflix-gray);
            line-height: 1.6;
        }
        
        .new-entry-form {
            background: var(--netflix-dark);
            padding: 30px;
            border-radius: 8px;
            margin: 30px 0;
        }
        
        .xp-earned {
            position: fixed;
            color: var(--success);
            font-weight: bold;
            font-size: 1.2rem;
            pointer-events: none;
            z-index: 10000;
            text-shadow: 0 0 10px rgba(0,0,0,0.8);
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 4px;
            color: var(--netflix-white);
            font-weight: bold;
            z-index: 10000;
            animation: slideInRight 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @keyframes floatUp {
            0% { transform: translateY(0) scale(1); opacity: 1; }
            100% { transform: translateY(-50px) scale(1.5); opacity: 0; }
        }
        
        .pulse {
            animation: pulse 1s infinite;
        }
        
        .level-up {
            animation: pulse 0.5s 3;
        }
        
        .section-title {
            font-size: 2rem;
            font-weight: bold;
            margin: 40px 0 20px;
            color: var(--netflix-white);
            border-bottom: 2px solid var(--netflix-red);
            padding-bottom: 10px;
        }
        
        @media (max-width: 768px) {
            .netflix-header {
                padding: 15px 20px;
            }
            
            .nav-tabs {
                padding: 10px 20px;
                margin-top: 60px;
                gap: 10px;
            }
            
            .tab-content {
                padding: 20px;
            }
            
            .hero-section {
                padding: 80px 20px 30px;
            }
            
            .hero-title {
                font-size: 2.5rem;
            }
            
            .profile-container {
                grid-template-columns: 1fr;
            }
            
            .timer-display {
                font-size: 3rem;
            }
        }
    </style>
</head>
<body>
    <!-- Netflix-style Header -->
    <header class="netflix-header" id="mainHeader">
        <div class="logo">STREAK7</div>
        <div class="user-menu">
            <div class="profile-avatar" style="width: 40px; height: 40px; font-size: 1rem;">K</div>
        </div>
    </header>

    <!-- Navigation Tabs -->
    <nav class="nav-tabs">
        <div class="nav-tab active" data-tab="home">Dashboard</div>
        <div class="nav-tab" data-tab="habits">Habits</div>
        <div class="nav-tab" data-tab="diary">Diary</div>
        <div class="nav-tab" data-tab="profile">Profile</div>
        <div class="nav-tab" data-tab="progress">Progress</div>
    </nav>

    <!-- Home Tab Content -->
    <div class="tab-content active" id="home-tab">
        <div class="hero-section">
            <h1 class="hero-title">Welcome Back, Koushigan!</h1>
            <p class="hero-subtitle">Track your productivity, build better habits, and level up your life. Let's make today count!</p>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-title">Current Streak</div>
                    <div class="stat-value" id="currentStreak">7 days</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Total XP</div>
                    <div class="stat-value" id="totalXP">1,250</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Level</div>
                    <div class="stat-value" id="userLevel">12</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Best Streak</div>
                    <div class="stat-value" id="bestStreak">21 days</div>
                </div>
            </div>
        </div>

        <div class="pomodoro-timer">
            <h2 style="margin-bottom: 20px; color: var(--netflix-white);">Pomodoro Timer</h2>
            <div class="timer-display" id="timerDisplay">25:00</div>
            <div class="timer-controls">
                <button class="btn btn-primary" id="startTimer">Start Focus</button>
                <button class="btn btn-secondary" id="resetTimer">Reset</button>
            </div>
        </div>

        <h2 class="section-title">Today's Habits</h2>
        <div class="habits-grid">
            <div class="habit-card">
                <div class="habit-header">
                    <div class="habit-name">Morning Exercise</div>
                    <div class="habit-xp">+25 XP</div>
                </div>
                <p style="color: var(--netflix-gray); margin-bottom: 15px;">Start your day with energy and focus</p>
                <input type="checkbox" class="habit-checkbox" id="habit1" data-xp="25" style="transform: scale(1.2);">
                <label for="habit1" style="color: var(--netflix-white); margin-left: 10px;">Mark as completed</label>
            </div>
            
            <div class="habit-card">
                <div class="habit-header">
                    <div class="habit-name">Reading</div>
                    <div class="habit-xp">+30 XP</div>
                </div>
                <p style="color: var(--netflix-gray); margin-bottom: 15px;">Read for at least 30 minutes</p>
                <input type="checkbox" class="habit-checkbox" id="habit2" data-xp="30" style="transform: scale(1.2);">
                <label for="habit2" style="color: var(--netflix-white); margin-left: 10px;">Mark as completed</label>
            </div>
            
            <div class="habit-card">
                <div class="habit-header">
                    <div class="habit-name">Meditation</div>
                    <div class="habit-xp">+20 XP</div>
                </div>
                <p style="color: var(--netflix-gray); margin-bottom: 15px;">10 minutes of mindfulness practice</p>
                <input type="checkbox" class="habit-checkbox" id="habit3" data-xp="20" style="transform: scale(1.2);">
                <label for="habit3" style="color: var(--netflix-white); margin-left: 10px;">Mark as completed</label>
            </div>
        </div>
    </div>

    <!-- Habits Tab Content -->
    <div class="tab-content" id="habits-tab">
        <h1 class="section-title">Habit Tracker</h1>
        <p style="color: var(--netflix-gray); margin-bottom: 30px; font-size: 1.1rem;">Build consistency and earn XP for your daily routines</p>

        <div class="add-habit-form">
            <h3 style="color: var(--netflix-white); margin-bottom: 20px;">Add New Habit</h3>
            <div class="form-group">
                <label class="form-label">Habit Name</label>
                <input type="text" class="form-input" id="newHabitName" placeholder="e.g., Morning Journaling">
            </div>
            <div class="form-group">
                <label class="form-label">XP Value</label>
                <input type="number" class="form-input" id="newHabitXP" placeholder="e.g., 25" min="5" max="100">
            </div>
            <div class="form-group">
                <label class="form-label">Description</label>
                <textarea class="form-input" id="newHabitDesc" placeholder="Describe your habit..." rows="3"></textarea>
            </div>
            <button class="btn btn-primary" id="addHabitBtn">Add Habit</button>
        </div>

        <h3 style="color: var(--netflix-white); margin: 40px 0 20px;">Your Habits</h3>
        <div class="habits-grid" id="habitsContainer">
            <!-- Habits will be dynamically added here -->
        </div>
    </div>

    <!-- Diary Tab Content -->
    <div class="tab-content" id="diary-tab">
        <h1 class="section-title">Personal Diary</h1>
        <p style="color: var(--netflix-gray); margin-bottom: 30px; font-size: 1.1rem;">Record your thoughts, reflections, and daily experiences</p>

        <div class="new-entry-form">
            <h3 style="color: var(--netflix-white); margin-bottom: 20px;">New Diary Entry</h3>
            <div class="form-group">
                <label class="form-label">Title (Optional)</label>
                <input type="text" class="form-input" id="diaryTitle" placeholder="Give your entry a title...">
            </div>
            <div class="form-group">
                <label class="form-label">Your Thoughts</label>
                <textarea class="form-input" id="diaryContent" placeholder="Write about your day, thoughts, feelings..." rows="6"></textarea>
            </div>
            <button class="btn btn-primary" id="saveEntry">Save Entry</button>
        </div>

        <h3 style="color: var(--netflix-white); margin: 40px 0 20px;">Previous Entries</h3>
        <div class="diary-entries" id="diaryEntries">
            <!-- Diary entries will be dynamically added here -->
        </div>
    </div>

    <!-- Profile Tab Content -->
    <div class="tab-content" id="profile-tab">
        <h1 class="section-title">My Profile</h1>
        
        <div class="profile-container">
            <div class="profile-sidebar">
                <div class="profile-avatar">K</div>
                <h2 style="color: var(--netflix-white); margin-bottom: 10px;">Koushigan</h2>
                <p style="color: var(--netflix-gray); margin-bottom: 20px;">Productivity Enthusiast</p>
                <div style="background: var(--netflix-red); color: white; padding: 8px 16px; border-radius: 20px; font-weight: bold; display: inline-block;">
                    Level 12
                </div>
            </div>
            
            <div class="profile-details">
                <div class="stat-card">
                    <div class="stat-title">Personal Information</div>
                    <div class="profile-detail">
                        <div class="detail-label">Full Name</div>
                        <div class="detail-value">Koushigan S</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Email</div>
                        <div class="detail-value">koushigans514@gmail.com</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Member Since</div>
                        <div class="detail-value">January 2024</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-title">Statistics</div>
                    <div class="profile-detail">
                        <div class="detail-label">Total XP Earned</div>
                        <div class="detail-value">1,250 XP</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Habits Completed</div>
                        <div class="detail-value">47</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Diary Entries</div>
                        <div class="detail-value">23</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Pomodoro Sessions</div>
                        <div class="detail-value">89</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-title">Achievements</div>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-top: 15px;">
                        <div style="text-align: center; padding: 15px; background: var(--netflix-black); border-radius: 8px;">
                            <div style="font-size: 2rem; margin-bottom: 10px;">🔥</div>
                            <div style="font-size: 0.8rem; color: var(--netflix-white);">7-Day Streak</div>
                        </div>
                        <div style="text-align: center; padding: 15px; background: var(--netflix-black); border-radius: 8px;">
                            <div style="font-size: 2rem; margin-bottom: 10px;">📚</div>
                            <div style="font-size: 0.8rem; color: var(--netflix-white);">Book Worm</div>
                        </div>
                        <div style="text-align: center; padding: 15px; background: var(--netflix-black); border-radius: 8px;">
                            <div style="font-size: 2rem; margin-bottom: 10px;">⏰</div>
                            <div style="font-size: 0.8rem; color: var(--netflix-white);">Time Master</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Progress Tab Content -->
    <div class="tab-content" id="progress-tab">
        <h1 class="section-title">Progress Analytics</h1>
        <p style="color: var(--netflix-gray); margin-bottom: 30px; font-size: 1.1rem;">Track your journey and visualize your growth</p>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-title">This Week's XP</div>
                <div class="stat-value">325</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Habits Completed</div>
                <div class="stat-value">14</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Productivity Score</div>
                <div class="stat-value">87%</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Focus Time</div>
                <div class="stat-value">12.5h</div>
            </div>
        </div>

        <div class="heatmap-container">
            <h3 style="color: var(--netflix-white); margin-bottom: 20px;">Activity Heatmap</h3>
            <div class="heatmap" id="activityHeatmap">
                <!-- Heatmap will be generated by JavaScript -->
            </div>
        </div>

        <div class="graph-container">
            <h3 style="color: var(--netflix-white); margin-bottom: 20px;">XP Progress (Last 30 Days)</h3>
            <div class="graph" id="xpGraph">
                <!-- Graph will be generated by JavaScript -->
            </div>
        </div>

        <div class="graph-container">
            <h3 style="color: var(--netflix-white); margin-bottom: 20px;">Habit Completion Rate</h3>
            <div class="graph" id="habitsGraph">
                <!-- Graph will be generated by JavaScript -->
            </div>
        </div>
    </div>

    <script>
        // Application State
        const appState = {
            timer: {
                running: false,
                minutes: 25,
                seconds: 0,
                interval: null
            },
            user: {
                name: 'Koushigan',
                email: 'koushigans514@gmail.com',
                level: 12,
                xp: 1250,
                currentStreak: 7,
                bestStreak: 21
            },
            habits: [
                { id: 1, name: 'Morning Exercise', xp: 25, description: 'Start your day with energy and focus', completed: false },
                { id: 2, name: 'Reading', xp: 30, description: 'Read for at least 30 minutes', completed: false },
                { id: 3, name: 'Meditation', xp: 20, description: '10 minutes of mindfulness practice', completed: false },
                { id: 4, name: 'Coding Practice', xp: 40, description: 'Work on coding projects', completed: false },
                { id: 5, name: 'Evening Walk', xp: 15, description: '30 minute walk after dinner', completed: false }
            ],
            diaryEntries: [
                { 
                    title: 'Productive Day', 
                    content: 'Completed all my habits today and finished the project ahead of schedule. Feeling accomplished!', 
                    date: 'October 15, 2024 at 8:30 PM' 
                },
                { 
                    title: 'Learning New Things', 
                    content: 'Spent the day learning about new web technologies. The pomodoro technique really helped me stay focused.', 
                    date: 'October 14, 2024 at 9:15 PM' 
                },
                { 
                    title: 'Weekend Planning', 
                    content: 'Planning my goals for the upcoming week. Need to focus more on consistency with my exercise routine.', 
                    date: 'October 13, 2024 at 7:45 PM' 
                }
            ]
        };

        // Initialize Application
        document.addEventListener('DOMContentLoaded', function() {
            initializeApp();
            setupEventListeners();
            updateUI();
            renderHabits();
            renderDiaryEntries();
            generateHeatmap();
            generateGraphs();
        });

        function initializeApp() {
            // Set up header scroll effect
            window.addEventListener('scroll', function() {
                const header = document.getElementById('mainHeader');
                if (window.scrollY > 100) {
                    header.classList.add('scrolled');
                } else {
                    header.classList.remove('scrolled');
                }
            });

            // Initialize timer display
            updateTimerDisplay();
        }

        function setupEventListeners() {
            // Timer controls
            document.getElementById('startTimer').addEventListener('click', toggleTimer);
            document.getElementById('resetTimer').addEventListener('click', resetTimer);
            
            // Navigation tabs
            document.querySelectorAll('.nav-tab').forEach(tab => {
                tab.addEventListener('click', handleTabNavigation);
            });
            
            // Habit management
            document.getElementById('addHabitBtn').addEventListener('click', addNewHabit);
            
            // Diary
            document.getElementById('saveEntry').addEventListener('click', saveDiaryEntry);
        }

        // Timer Functions
        function toggleTimer() {
            if (appState.timer.running) {
                pauseTimer();
            } else {
                startTimer();
            }
        }

        function startTimer() {
            appState.timer.running = true;
            document.getElementById('startTimer').textContent = 'Pause Focus';
            document.getElementById('timerDisplay').classList.add('pulse');
            
            appState.timer.interval = setInterval(() => {
                if (appState.timer.seconds === 0) {
                    if (appState.timer.minutes === 0) {
                        completeTimer();
                        return;
                    }
                    appState.timer.minutes--;
                    appState.timer.seconds = 59;
                } else {
                    appState.timer.seconds--;
                }
                
                updateTimerDisplay();
            }, 1000);
        }

        function pauseTimer() {
            appState.timer.running = false;
            document.getElementById('startTimer').textContent = 'Resume Focus';
            document.getElementById('timerDisplay').classList.remove('pulse');
            clearInterval(appState.timer.interval);
        }

        function resetTimer() {
            pauseTimer();
            appState.timer.minutes = 25;
            appState.timer.seconds = 0;
            updateTimerDisplay();
            document.getElementById('startTimer').textContent = 'Start Focus';
        }

        function completeTimer() {
            clearInterval(appState.timer.interval);
            appState.timer.running = false;
            document.getElementById('startTimer').textContent = 'Start Focus';
            document.getElementById('timerDisplay').classList.remove('pulse');
            
            showNotification('Pomodoro session completed! Time for a break. 🎉', 'success');
            awardXP(15);
        }

        function updateTimerDisplay() {
            document.getElementById('timerDisplay').textContent = 
                `${appState.timer.minutes.toString().padStart(2, '0')}:${appState.timer.seconds.toString().padStart(2, '0')}`;
        }

        // Navigation Functions
        function handleTabNavigation(event) {
            const tab = event.target;
            const tabId = tab.getAttribute('data-tab');
            
            // Remove active class from all tabs and content
            document.querySelectorAll('.nav-tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            
            // Add active class to clicked tab
            tab.classList.add('active');
            
            // Show corresponding content
            document.getElementById(`${tabId}-tab`).classList.add('active');
        }

        // Habit Functions
        function renderHabits() {
            const container = document.getElementById('habitsContainer');
            container.innerHTML = '';
            
            appState.habits.forEach(habit => {
                const habitCard = document.createElement('div');
                habitCard.className = 'habit-card';
                habitCard.innerHTML = `
                    <div class="habit-header">
                        <div class="habit-name">${habit.name}</div>
                        <div class="habit-xp">+${habit.xp} XP</div>
                    </div>
                    <p style="color: var(--netflix-gray); margin-bottom: 15px;">${habit.description}</p>
                    <input type="checkbox" class="habit-checkbox" id="habit-${habit.id}" data-xp="${habit.xp}" data-habit-id="${habit.id}" ${habit.completed ? 'checked' : ''} style="transform: scale(1.2);">
                    <label for="habit-${habit.id}" style="color: var(--netflix-white); margin-left: 10px;">Mark as completed</label>
                    <button class="btn btn-secondary" onclick="removeHabit(${habit.id})" style="margin-top: 15px; padding: 8px 16px; font-size: 0.8rem;">Remove</button>
                `;
                container.appendChild(habitCard);
                
                // Add event listener for the checkbox
                const checkbox = habitCard.querySelector('.habit-checkbox');
                checkbox.addEventListener('change', handleHabitCompletion);
            });
        }

        function handleHabitCompletion(event) {
            const checkbox = event.target;
            const xpValue = parseInt(checkbox.getAttribute('data-xp'));
            const habitId = parseInt(checkbox.getAttribute('data-habit-id'));
            
            if (checkbox.checked) {
                const habit = appState.habits.find(h => h.id === habitId);
                if (habit && !habit.completed) {
                    habit.completed = true;
                    awardXP(xpValue);
                    showXPEarnedAnimation(checkbox, xpValue);
                    showNotification(`Completed: ${habit.name}! +${xpValue} XP earned`, 'success');
                }
            } else {
                const habit = appState.habits.find(h => h.id === habitId);
                if (habit) {
                    habit.completed = false;
                }
            }
        }

        function addNewHabit() {
            const nameInput = document.getElementById('newHabitName');
            const xpInput = document.getElementById('newHabitXP');
            const descInput = document.getElementById('newHabitDesc');
            
            const name = nameInput.value.trim();
            const xp = parseInt(xpInput.value);
            const description = descInput.value.trim();
            
            if (!name || isNaN(xp) || xp < 5 || !description) {
                showNotification('Please fill all fields with valid values', 'error');
                return;
            }
            
            const newHabit = {
                id: Date.now(), // Simple ID generation
                name: name,
                xp: xp,
                description: description,
                completed: false
            };
            
            appState.habits.push(newHabit);
            renderHabits();
            
            // Clear form
            nameInput.value = '';
            xpInput.value = '';
            descInput.value = '';
            
            showNotification('New habit added successfully!', 'success');
        }

        function removeHabit(habitId) {
            appState.habits = appState.habits.filter(h => h.id !== habitId);
            renderHabits();
            showNotification('Habit removed', 'info');
        }

        // Diary Functions
        function renderDiaryEntries() {
            const container = document.getElementById('diaryEntries');
            container.innerHTML = '';
            
            appState.diaryEntries.forEach(entry => {
                const entryElement = document.createElement('div');
                entryElement.className = 'diary-entry';
                entryElement.innerHTML = `
                    <div class="entry-header">
                        <div class="entry-title">${entry.title}</div>
                        <div class="entry-date">${entry.date}</div>
                    </div>
                    <div class="entry-content">${entry.content}</div>
                `;
                container.appendChild(entryElement);
            });
        }

        function saveDiaryEntry() {
            const titleInput = document.getElementById('diaryTitle');
            const contentInput = document.getElementById('diaryContent');
            
            const title = titleInput.value.trim();
            const content = contentInput.value.trim();
            
            if (content === '') {
                showNotification('Please write something in your diary entry.', 'error');
                return;
            }
            
            const now = new Date();
            const entryDate = now.toLocaleDateString('en-US', { 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric',
                hour: 'numeric',
                minute: 'numeric'
            });
            
            const newEntry = {
                title: title || 'Untitled Entry',
                content: content,
                date: entryDate
            };
            
            appState.diaryEntries.unshift(newEntry);
            renderDiaryEntries();
            
            // Clear form
            titleInput.value = '';
            contentInput.value = '';
            
            showNotification('Diary entry saved successfully!', 'success');
            awardXP(10);
        }

        // Progress Visualization
        function generateHeatmap() {
            const heatmap = document.getElementById('activityHeatmap');
            heatmap.innerHTML = '';
            
            const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            const activityLevels = [3, 2, 1, 0, 2, 3, 1]; // Example data
            
            days.forEach((day, index) => {
                const dayElement = document.createElement('div');
                dayElement.className = 'heatmap-day';
                dayElement.textContent = day;
                
                const level = activityLevels[index];
                if (level > 0) {
                    dayElement.classList.add('active');
                    if (level === 3) dayElement.classList.add('high');
                    else if (level === 2) dayElement.classList.add('medium');
                    else if (level === 1) dayElement.classList.add('low');
                }
                
                heatmap.appendChild(dayElement);
            });
        }

        function generateGraphs() {
            generateXPGraph();
            generateHabitsGraph();
        }

        function generateXPGraph() {
            const graph = document.getElementById('xpGraph');
            graph.innerHTML = '';
            
            // Sample XP data for last 7 days
            const xpData = [45, 60, 30, 75, 90, 50, 65];
            const maxXP = Math.max(...xpData);
            
            xpData.forEach((xp, index) => {
                const bar = document.createElement('div');
                bar.className = 'graph-bar';
                const width = (100 / xpData.length) * 0.8;
                const height = (xp / maxXP) * 100;
                const left = (index * (100 / xpData.length)) + (width * 0.1);
                
                bar.style.width = `${width}%`;
                bar.style.height = `${height}%`;
                bar.style.left = `${left}%`;
                bar.style.background = `linear-gradient(to top, var(--netflix-red), var(--accent))`;
                
                graph.appendChild(bar);
            });
        }

        function generateHabitsGraph() {
            const graph = document.getElementById('habitsGraph');
            graph.innerHTML = '';
            
            // Sample completion data for last 7 days
            const completionData = [80, 60, 90, 70, 85, 75, 95];
            const maxCompletion = Math.max(...completionData);
            
            completionData.forEach((completion, index) => {
                const bar = document.createElement('div');
                bar.className = 'graph-bar';
                const width = (100 / completionData.length) * 0.8;
                const height = (completion / maxCompletion) * 100;
                const left = (index * (100 / completionData.length)) + (width * 0.1);
                
                bar.style.width = `${width}%`;
                bar.style.height = `${height}%`;
                bar.style.left = `${left}%`;
                bar.style.background = `linear-gradient(to top, var(--info), var(--success))`;
                
                graph.appendChild(bar);
            });
        }

        // Utility Functions
        function awardXP(amount) {
            appState.user.xp += amount;
            
            // Check for level up (every 100 XP)
            const newLevel = Math.floor(appState.user.xp / 100) + 1;
            if (newLevel > appState.user.level) {
                appState.user.level = newLevel;
                showLevelUpAnimation();
                showNotification(`🎉 Congratulations! You reached Level ${newLevel}!`, 'success');
            }
            
            updateUI();
        }

        function updateUI() {
            document.getElementById('currentStreak').textContent = `${appState.user.currentStreak} days`;
            document.getElementById('totalXP').textContent = appState.user.xp.toLocaleString();
            document.getElementById('userLevel').textContent = appState.user.level;
            document.getElementById('bestStreak').textContent = `${appState.user.bestStreak} days`;
        }

        function showXPEarnedAnimation(element, xp) {
            const rect = element.getBoundingClientRect();
            const xpElement = document.createElement('div');
            xpElement.className = 'xp-earned';
            xpElement.textContent = `+${xp} XP`;
            xpElement.style.left = `${rect.left + rect.width / 2}px`;
            xpElement.style.top = `${rect.top}px`;
            
            document.body.appendChild(xpElement);
            
            // Animate
            xpElement.style.animation = 'floatUp 1s ease-out forwards';
            
            // Remove after animation
            setTimeout(() => {
                xpElement.remove();
            }, 1000);
        }

        function showLevelUpAnimation() {
            const levelElement = document.querySelector('.profile-level');
            if (levelElement) {
                levelElement.classList.add('level-up');
                setTimeout(() => {
                    levelElement.classList.remove('level-up');
                }, 1500);
            }
        }

        function showNotification(message, type = 'info') {
            // Remove existing notifications
            const existingNotification = document.querySelector('.notification');
            if (existingNotification) {
                existingNotification.remove();
            }
            
            const notification = document.createElement('div');
            notification.className = `notification`;
            notification.textContent = message;
            
            // Set background color based on type
            const colors = {
                success: '#2ecc71',
                error: '#e74c3c',
                info: '#3498db',
                warning: '#f39c12'
            };
            
            notification.style.backgroundColor = colors[type] || colors.info;
            
            document.body.appendChild(notification);
            
            // Auto remove after 4 seconds
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            }, 4000);
        }
    </script>
</body>
</html>