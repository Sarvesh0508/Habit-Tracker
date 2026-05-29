<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Streak7 - Gamified Productivity Tracker</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="https://img.icons8.com/color/48/checkmark--v1.png">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Inter & Outfit) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">
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
            min-height: calc(100vh - 110px);
            margin-top: 110px;
            box-sizing: border-box;
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
        @keyframes loadingSpinner {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Mockup Premium Layout & Theme Styling */
        :root {
            --mockup-bg: #0d0f12;
            --mockup-card-bg: #15181e;
            --mockup-border: #20252e;
            --mockup-red: #ff4a5a;
            --mockup-gray: #8c96a3;
        }

        body {
            background: var(--mockup-bg) !important;
            font-family: 'Inter', sans-serif !important;
        }

        .logo {
            font-family: 'Outfit', sans-serif !important;
            color: var(--mockup-red) !important;
            font-weight: 800 !important;
        }

        .netflix-header {
            background: #0d0f12 !important;
            border-bottom: 1px solid var(--mockup-border);
            padding: 15px 50px !important;
        }

        /* Glassmorphic Mockup Cards */
        .mockup-card {
            background: var(--mockup-card-bg);
            border: 1px solid var(--mockup-border);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .mockup-card:hover {
            box-shadow: 0 8px 30px rgba(255, 74, 90, 0.08);
            border-color: rgba(255, 74, 90, 0.3);
        }

        .mockup-card-title {
            font-family: 'Outfit', sans-serif;
            font-size: 0.95rem;
            color: var(--mockup-gray);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 15px;
            font-weight: 700;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Dashboard Grid System */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 43% 57%;
            gap: 20px;
            margin-top: 20px;
        }

        .dashboard-col {
            display: flex;
            flex-direction: column;
        }

        /* Hero Row */
        .dashboard-hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px 0;
        }

        .dashboard-welcome {
            font-family: 'Outfit', sans-serif;
            font-size: 2.2rem;
            font-weight: 800;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Habits checklist layout */
        .habit-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid var(--mockup-border);
        }

        .habit-row:last-child {
            border-bottom: none;
        }

        .habit-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Custom Checkbox */
        .custom-cb {
            appearance: none;
            width: 22px;
            height: 22px;
            border: 2px solid var(--mockup-border);
            border-radius: 6px;
            outline: none;
            cursor: pointer;
            position: relative;
            background: #1c2128;
            transition: all 0.2s;
        }

        .custom-cb:checked {
            background: var(--mockup-red);
            border-color: var(--mockup-red);
        }

        .custom-cb:checked::after {
            content: '\f00c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 11px;
            color: #ffffff;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .habit-title-text {
            color: #ffffff;
            font-weight: 600;
            font-size: 1.05rem;
        }

        .habit-streak-bar-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .habit-streak-label {
            color: var(--mockup-gray);
            font-size: 0.8rem;
            font-weight: 500;
        }

        .habit-streak-bar {
            width: 60px;
            height: 6px;
            background: #1c2128;
            border-radius: 3px;
            overflow: hidden;
        }

        .habit-streak-fill {
            height: 100%;
            background: var(--mockup-red);
            width: 0%;
            border-radius: 3px;
            transition: width 0.3s ease;
        }

        /* Streak Summary */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            text-align: center;
        }

        .summary-stat-val {
            font-family: 'Outfit', sans-serif;
            font-size: 1.6rem;
            font-weight: 800;
            color: #ffffff;
        }

        .summary-stat-lbl {
            font-size: 0.75rem;
            color: var(--mockup-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 4px;
        }

        /* Quick Journal reflections styling */
        .journal-textarea {
            width: 100%;
            background: #0d0f12;
            border: 1px solid var(--mockup-border);
            border-radius: 8px;
            color: #ffffff;
            padding: 12px;
            font-size: 0.95rem;
            resize: none;
            outline: none;
            transition: border-color 0.2s;
            margin-bottom: 12px;
        }

        .journal-textarea:focus {
            border-color: var(--mockup-red);
        }

        .journal-input {
            width: 100%;
            background: #0d0f12;
            border: 1px solid var(--mockup-border);
            border-radius: 8px;
            color: #ffffff;
            padding: 8px 12px;
            font-size: 0.95rem;
            outline: none;
            transition: border-color 0.2s;
            margin-bottom: 10px;
        }

        .journal-input:focus {
            border-color: var(--mockup-red);
        }

        .quick-journal-preview {
            border-top: 1px solid var(--mockup-border);
            margin-top: 15px;
            padding-top: 15px;
        }

        .reflection-preview-title {
            color: #ffffff;
            font-weight: 700;
            font-size: 0.95rem;
        }

        .reflection-preview-body {
            color: var(--mockup-gray);
            font-size: 0.85rem;
            margin-top: 5px;
            line-height: 1.4;
        }

        /* Focus Timer SVG elements */
        .circular-timer-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 10px 0;
        }

        .timer-svg-wrapper {
            position: relative;
            width: 180px;
            height: 180px;
        }

        .timer-center-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }

        .timer-countdown {
            font-family: 'Outfit', monospace;
            font-size: 2.2rem;
            font-weight: 800;
            color: #ffffff;
        }

        .timer-countdown-lbl {
            font-size: 0.75rem;
            color: var(--mockup-gray);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .timer-status-text {
            color: var(--mockup-gray);
            font-weight: 600;
            margin-top: 15px;
            font-size: 0.95rem;
        }

        /* Vertical Progress Bar Chart */
        .progress-chart-bars {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            height: 180px;
            padding: 10px 10px 0 10px;
            border-bottom: 2px solid var(--mockup-border);
        }

        .progress-bar-col {
            display: flex;
            flex-direction: column;
            align-items: center;
            flex: 1;
            height: 100%;
            justify-content: flex-end;
        }

        .progress-bar-fill {
            width: 25px;
            background: var(--mockup-red);
            border-radius: 4px 4px 0 0;
            height: 0%;
            transition: height 0.6s cubic-bezier(0.1, 0.76, 0.55, 0.94);
            position: relative;
        }

        .progress-bar-fill::after {
            content: attr(data-xp);
            position: absolute;
            top: -22px;
            left: 50%;
            transform: translateX(-50%);
            color: #ffffff;
            font-size: 0.7rem;
            font-weight: bold;
            opacity: 0;
            transition: opacity 0.2s;
        }

        .progress-bar-fill:hover::after {
            opacity: 1;
        }

        .progress-chart-labels {
            display: flex;
            justify-content: space-between;
            margin-top: 8px;
            padding: 0 10px;
        }

        .progress-chart-lbl {
            font-size: 0.75rem;
            color: var(--mockup-gray);
            font-weight: 700;
            width: 25px;
            text-align: center;
        }

        /* Contribution Heatmap */
        .heatmap-grid {
            display: grid;
            grid-template-columns: repeat(14, 1fr);
            grid-template-rows: repeat(2, 1fr);
            gap: 6px;
            margin: 15px 0;
        }

        .heatmap-cell {
            aspect-ratio: 1;
            background: #1c2128;
            border-radius: 2px;
            position: relative;
        }

        .heatmap-cell-tooltip {
            visibility: hidden;
            background-color: #000000;
            color: #fff;
            text-align: center;
            padding: 5px 10px;
            border-radius: 4px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            transform: translateX(-50%);
            opacity: 0;
            transition: opacity 0.2s;
            font-size: 0.7rem;
            white-space: nowrap;
        }

        .heatmap-cell:hover .heatmap-cell-tooltip {
            visibility: visible;
            opacity: 1;
        }

        .heatmap-bottom-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            font-size: 0.8rem;
            color: var(--mockup-gray);
        }

        .heatmap-legends {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .heatmap-legend-box {
            width: 10px;
            height: 10px;
            border-radius: 1px;
        }

        /* Achievements Badges styling */
        .badges-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-top: 15px;
        }

        .achievement-badge-card {
            background: #1c2128;
            border: 1px solid var(--mockup-border);
            border-radius: 8px;
            padding: 10px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: all 0.3s ease;
        }

        .achievement-badge-card.locked {
            opacity: 0.25;
            filter: grayscale(1);
        }

        .achievement-badge-icon {
            font-size: 1.5rem;
            color: var(--mockup-red);
            margin-bottom: 6px;
        }

        .achievement-badge-name {
            font-size: 0.68rem;
            font-weight: 700;
            color: #ffffff;
            line-height: 1.2;
        }

        /* Media responsiveness for dashboard grid */
        @media (max-width: 992px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Header navigation and timer SVG styles */
        .header-nav-tab {
            color: #8c96a3;
            font-family: 'Inter', sans-serif;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 6px 14px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: none !important;
        }
        .header-nav-tab:hover {
            color: #ffffff;
        }
        .header-nav-tab.active {
            background-color: #ff4a5a !important;
            color: #ffffff !important;
            box-shadow: 0 4px 12px rgba(255, 74, 90, 0.3);
        }
        .timer-svg {
            transform: rotate(-90deg);
        }
        .timer-svg-circle-bg {
            fill: none;
            stroke: rgba(255, 255, 255, 0.05);
            stroke-width: 8px;
        }
        .timer-svg-circle-fg {
            fill: none;
            stroke: var(--mockup-red);
            stroke-width: 8px;
            stroke-linecap: round;
            transition: stroke-dashoffset 1s linear;
        }
        @media (max-width: 768px) {
            .netflix-header {
                padding: 10px 20px !important;
                height: 95px !important;
            }
            .logo-text {
                font-size: 1.4rem !important;
            }
            .header-nav {
                gap: 8px !important;
                margin-top: 8px !important;
            }
            .header-nav-tab {
                font-size: 0.7rem !important;
                padding: 4px 8px !important;
            }
            .profile-avatar {
                width: 32px !important;
                height: 32px !important;
                font-size: 0.95rem !important;
            }
            .tab-content {
                margin-top: 95px !important;
                padding: 20px !important;
            }
        }

        /* Overhauled layout styles */
        .dashboard-grid-top {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .dashboard-grid-bottom {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .achievement-badge-card {
            border-color: var(--mockup-border) !important;
        }
        .achievement-badge-card:not(.locked)#badgeStreak {
            border-color: #ff4a5a !important;
            box-shadow: 0 0 10px rgba(255, 74, 90, 0.2);
            background: rgba(255, 74, 90, 0.05) !important;
        }
        .achievement-badge-card:not(.locked)#badgeNight {
            border-color: #b55aff !important;
            box-shadow: 0 0 10px rgba(181, 90, 255, 0.2);
            background: rgba(181, 90, 255, 0.05) !important;
        }
        .achievement-badge-card:not(.locked)#badgeEarly {
            border-color: #ffd25a !important;
            box-shadow: 0 0 10px rgba(255, 210, 90, 0.2);
            background: rgba(255, 210, 90, 0.05) !important;
        }
        .achievement-badge-card:not(.locked)#badgeTenStreak {
            border-color: #ff8f5a !important;
            box-shadow: 0 0 10px rgba(255, 143, 90, 0.2);
            background: rgba(255, 143, 90, 0.05) !important;
        }
        @media (max-width: 992px) {
            .dashboard-grid-top, .dashboard-grid-bottom {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div id="loadingOverlay" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: var(--netflix-black); z-index: 9999; display: flex; flex-direction: column; justify-content: center; align-items: center; transition: opacity 0.5s ease; opacity: 1;">
        <div style="width: 50px; height: 50px; border: 5px solid rgba(229, 9, 20, 0.2); border-top-color: var(--netflix-red); border-radius: 50%; animation: loadingSpinner 1s linear infinite; margin-bottom: 20px;"></div>
        <h2 style="color: var(--netflix-white); font-family: 'Inter', sans-serif; font-weight: 700; letter-spacing: 1px;">STREAK7</h2>
    </div>
    <!-- Premium Header with Inline Tabs -->
    <header class="netflix-header" id="mainHeader" style="position: fixed; top: 0; left: 0; right: 0; height: 110px; z-index: 1000; background: #0d0f12 !important; border-bottom: 1px solid var(--mockup-border); padding: 15px 50px !important; display: flex; justify-content: space-between; align-items: center; box-sizing: border-box;">
        <!-- Left side: contains Logo on top, Nav Tabs below -->
        <div class="header-left-col" style="display: flex; flex-direction: column; justify-content: space-between; height: 100%; align-items: flex-start;">
            <div class="logo-text" style="font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800; color: #ff4a5a !important; text-transform: uppercase; letter-spacing: 1.5px; line-height: 1; cursor: pointer; user-select: none;" onclick="switchTabDirect('home')">STREAK7</div>
            <div class="header-nav" style="display: flex; gap: 15px; align-items: center; margin-top: 12px;">
                <div class="header-nav-tab active" data-tab="home" onclick="switchTabDirect('home')">DASHBOARD</div>
                <div class="header-nav-tab" data-tab="habits" onclick="switchTabDirect('habits')">HABITS</div>
                <div class="header-nav-tab" data-tab="diary" onclick="switchTabDirect('diary')">DIARY</div>
                <div class="header-nav-tab" data-tab="profile" onclick="switchTabDirect('profile')">PROFILE</div>
                <div class="header-nav-tab" data-tab="progress" onclick="switchTabDirect('progress')">PROGRESS</div>
            </div>
        </div>

        <!-- Right side: User Profile Avatar -->
        <div class="header-right-col" style="display: flex; align-items: center; justify-content: center; height: 100%;">
            <div class="profile-avatar" id="headerAvatar" style="width: 38px; height: 38px; border-radius: 50%; background-color: #ff4a5a; color: #ffffff; border: 2px solid #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1.1rem; cursor: pointer; transition: transform 0.2s;" onclick="switchTabDirect('profile')">G</div>
        </div>
    </header>



    <!-- Home Tab Content -->
    <div class="tab-content active" id="home-tab">
        <!-- Hero Welcome Row -->
        <div class="dashboard-hero" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;">
            <h1 class="dashboard-welcome" id="welcomeTitle" style="font-family: 'Outfit', sans-serif; font-size: 2.2rem; font-weight: 800; color: #ffffff; letter-spacing: 0.5px; margin: 0;">WELCOME BACK, GUEST USER!</h1>
            <button class="btn btn-primary" id="startStreakBtn" style="background: #ff4a5a; border: none; padding: 12px 24px; font-weight: bold; border-radius: 8px; font-size: 0.9rem; cursor: pointer; transition: all 0.2s;"><i class="fas fa-play" style="margin-right: 6px;"></i> Start Your Streak</button>
        </div>

        <!-- Top Grid: 2 Columns (Habits/Streaks on Left, Charts/Heatmap on Right) -->
        <div class="dashboard-grid-top">
            <!-- Left Column: Habits & Streak Summary -->
            <div class="dashboard-col">
                <!-- Daily Habits Checklist Card -->
                <div class="mockup-card" style="flex: 1; display: flex; flex-direction: column;">
                    <div class="mockup-card-title" id="dailyHabitsTitle">DAILY HABITS - TODAY</div>
                    <div id="dashboardHabitsContainer" style="display: flex; flex-direction: column; gap: 12px;">
                        <!-- Dynamic habit rows will be loaded here by JavaScript -->
                    </div>
                </div>

                <!-- Streak Summary Card -->
                <div class="mockup-card" style="margin-top: 20px;">
                    <div class="mockup-card-title">STREAK SUMMARY</div>
                    <div class="summary-grid" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; text-align: center;">
                        <div>
                            <div class="summary-stat-val" id="currentStreak" style="font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800; color: #ffffff;">0 days</div>
                            <div class="summary-stat-lbl" style="font-size: 0.75rem; color: var(--mockup-gray); text-transform: uppercase; letter-spacing: 0.5px; margin-top: 4px;">Current</div>
                        </div>
                        <div>
                            <div class="summary-stat-val" id="bestStreak" style="font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800; color: #ffffff;">0 days</div>
                            <div class="summary-stat-lbl" style="font-size: 0.75rem; color: var(--mockup-gray); text-transform: uppercase; letter-spacing: 0.5px; margin-top: 4px;">Longest</div>
                        </div>
                        <div>
                            <div class="summary-stat-val" id="totalXP" style="font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800; color: #ffffff;">0</div>
                            <div class="summary-stat-lbl" style="font-size: 0.75rem; color: var(--mockup-gray); text-transform: uppercase; letter-spacing: 0.5px; margin-top: 4px;">Total XP</div>
                        </div>
                        <div>
                            <div class="summary-stat-val" id="habitAvgCompletions" style="font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800; color: #ffffff;">0.0</div>
                            <div class="summary-stat-lbl" style="font-size: 0.75rem; color: var(--mockup-gray); text-transform: uppercase; letter-spacing: 0.5px; margin-top: 4px;">Average/Day</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Progress Overview & Activity Heatmap -->
            <div class="dashboard-col">
                <!-- Progress Overview Chart -->
                <div class="mockup-card" style="flex: 1; display: flex; flex-direction: column;">
                    <div class="mockup-card-title" id="progressOverviewTitle">PROGRESS OVERVIEW</div>
                    <div style="display: flex; gap: 15px; height: 180px; align-items: flex-end; margin-top: auto;">
                        <!-- Y-Axis Labels -->
                        <div class="progress-chart-y-axis" style="display: flex; flex-direction: column; justify-content: space-between; height: 100%; color: var(--mockup-gray); font-size: 0.8rem; font-weight: 600; padding-bottom: 2px;">
                            <span>5</span>
                            <span>4</span>
                            <span>3</span>
                            <span>2</span>
                            <span>1</span>
                            <span>0</span>
                        </div>
                        <!-- Bars Container -->
                        <div style="flex: 1; display: flex; flex-direction: column; height: 100%;">
                            <div class="progress-chart-bars" id="weeklyProgressBars" style="display: flex; justify-content: space-between; align-items: flex-end; height: 100%; border-bottom: 2px solid var(--mockup-border); padding: 0 10px;">
                                <!-- Bars dynamically loaded by JavaScript -->
                            </div>
                        </div>
                    </div>
                    <div class="progress-chart-labels" id="weeklyProgressLabels" style="display: flex; justify-content: space-between; margin-top: 8px; padding-left: 25px; padding-right: 10px;">
                        <!-- Labels dynamically loaded by JavaScript -->
                    </div>
                </div>

                <!-- Activity Heatmap -->
                <div class="mockup-card" style="margin-top: 20px;">
                    <div class="mockup-card-title" id="activityHeatmapTitle">ACTIVITY HEATMAP</div>
                    <div class="heatmap-grid" id="dashboardHeatmapCells" style="display: grid; grid-template-columns: repeat(14, 1fr); grid-template-rows: repeat(2, 1fr); gap: 6px; margin: 15px 0;">
                        <!-- Heatmap cells dynamically loaded by JavaScript -->
                    </div>
                    <div class="heatmap-bottom-row" style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px; font-size: 0.8rem; color: var(--mockup-gray);">
                        <div id="heatmapStreakLabel">0 day current streak</div>
                        <div class="heatmap-legends" style="display: flex; align-items: center; gap: 4px;">
                            <span style="margin-right: 4px;">Less</span>
                            <div class="heatmap-legend-box level-0" style="width: 10px; height: 10px; border-radius: 1px; background: #1c2128;"></div>
                            <div class="heatmap-legend-box level-1" style="width: 10px; height: 10px; border-radius: 1px; background: #3c1618;"></div>
                            <div class="heatmap-legend-box level-2" style="width: 10px; height: 10px; border-radius: 1px; background: #6b1d22;"></div>
                            <div class="heatmap-legend-box level-3" style="width: 10px; height: 10px; border-radius: 1px; background: #a82730;"></div>
                            <div class="heatmap-legend-box level-4" style="width: 10px; height: 10px; border-radius: 1px; background: #ff4a5a;"></div>
                            <span style="margin-left: 4px;">More</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bottom Grid: 3 Columns (Quick Journal, Focus Timer, Achievements) -->
        <div class="dashboard-grid-bottom">
            <!-- Column 1: Quick Journal / Reflections (Useful Feature replacing logo) -->
            <div class="mockup-card" style="display: flex; flex-direction: column; justify-content: space-between; min-height: 350px; box-sizing: border-box;">
                <div>
                    <div class="mockup-card-title" style="margin-bottom: 12px;">QUICK JOURNAL / REFLECTIONS</div>
                    <input type="text" class="journal-input" id="quickJournalTitle" placeholder="Reflection Title (Optional)..." style="width: 100%; background: #0d0f12; border: 1px solid var(--mockup-border); border-radius: 8px; color: #ffffff; padding: 8px 12px; font-size: 0.9rem; outline: none; margin-bottom: 8px; box-sizing: border-box;">
                    <textarea class="journal-textarea" id="quickJournalContent" rows="2" placeholder="Write down your daily thoughts and reflections..." style="width: 100%; background: #0d0f12; border: 1px solid var(--mockup-border); border-radius: 8px; color: #ffffff; padding: 10px; font-size: 0.9rem; resize: none; outline: none; margin-bottom: 10px; box-sizing: border-box;"></textarea>
                    <button class="btn btn-primary" id="saveQuickJournalBtn" style="width: 100%; padding: 10px; border-radius: 6px; font-size: 0.85rem; font-weight: bold; background: var(--mockup-red); color: white; border: none; cursor: pointer;"><i class="fas fa-save" style="margin-right: 6px;"></i> Save Reflection</button>
                </div>
                
                <div class="quick-journal-preview" style="border-top: 1px solid var(--mockup-border); margin-top: 12px; padding-top: 12px;">
                    <div class="reflection-preview-title" id="recentJournalTitle" style="color: #ffffff; font-weight: 700; font-size: 0.9rem;">No recent entries</div>
                    <div class="reflection-preview-body" id="recentJournalContent" style="color: var(--mockup-gray); font-size: 0.8rem; margin-top: 4px; line-height: 1.4;">Reflections you log will show up here as a quick preview.</div>
                </div>
            </div>

            <!-- Column 2: Focus Timer -->
            <div class="mockup-card" style="display: flex; flex-direction: column; align-items: center; justify-content: space-between; min-height: 350px; box-sizing: border-box;">
                <div class="mockup-card-title" style="width: 100%;" id="focusTimerTitle">FOCUS TIMER - WORK SESSION</div>
                
                <div class="circular-timer-container" style="display: flex; flex-direction: column; align-items: center; justify-content: center; position: relative;">
                    <div class="timer-svg-wrapper" style="position: relative; width: 150px; height: 150px;">
                        <svg class="timer-svg" width="150" height="150" viewBox="0 0 180 180" style="transform: rotate(-90deg);">
                            <circle class="timer-svg-circle-bg" cx="90" cy="90" r="80" style="fill: none; stroke: rgba(255, 255, 255, 0.05); stroke-width: 8px;"></circle>
                            <circle class="timer-svg-circle-fg" id="timerSvgCircle" cx="90" cy="90" r="80" stroke-dasharray="502.6" stroke-dashoffset="0" style="fill: none; stroke: var(--mockup-red); stroke-width: 8px; stroke-linecap: round; transition: stroke-dashoffset 1s linear;"></circle>
                        </svg>
                        <div class="timer-center-text" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">
                            <div class="timer-countdown" id="timerDisplay" style="font-family: 'Outfit', monospace; font-size: 2.2rem; font-weight: 800; color: #ffffff;">25:00</div>
                            <div class="timer-countdown-lbl" style="font-size: 0.75rem; color: var(--mockup-gray); text-transform: uppercase; letter-spacing: 1px;">Remaining</div>
                        </div>
                    </div>
                </div>
                
                <div style="width: 100%; text-align: center;">
                    <div class="timer-status-text" id="timerStatusLabel" style="color: var(--mockup-gray); font-weight: 600; font-size: 0.9rem; margin-bottom: 12px;">Focus Session (Work 25:00)</div>
                    <div class="timer-controls" style="display: flex; justify-content: center; gap: 8px; width: 100%;">
                        <button class="btn btn-secondary" id="startTimer" style="background: transparent; border: 1px solid var(--mockup-border); color: #ffffff; padding: 8px 14px; border-radius: 6px; font-size: 0.8rem; font-weight: bold; cursor: pointer; transition: all 0.2s;">Start Focus</button>
                        <button class="btn btn-secondary" id="resetTimer" style="background: transparent; border: 1px solid var(--mockup-border); color: #ffffff; padding: 8px 14px; border-radius: 6px; font-size: 0.8rem; font-weight: bold; cursor: pointer; transition: all 0.2s;">Reset</button>
                        <button class="btn btn-primary" id="startShortBreakBtn" style="background: var(--mockup-red); border: none; color: #ffffff; padding: 8px 14px; border-radius: 6px; font-size: 0.8rem; font-weight: bold; cursor: pointer; transition: all 0.2s;">Short Break</button>
                    </div>
                </div>
            </div>

            <!-- Column 3: Achievements -->
            <div class="mockup-card" style="display: flex; flex-direction: column; justify-content: space-between; min-height: 350px; box-sizing: border-box;">
                <div class="mockup-card-title" id="achievementsTitle">LEVEL 1 ACHIEVEMENTS</div>
                
                <!-- XP progress bar -->
                <div style="margin-bottom: 10px; width: 100%;">
                    <div style="display: flex; justify-content: space-between; font-size: 0.8rem; font-weight: bold; margin-bottom: 5px; color: #ffffff;">
                        <span id="nextLevelTag">Level 2</span>
                        <span id="levelXPPercent">0%</span>
                    </div>
                    <div style="width: 100%; height: 8px; background: #1c2128; border-radius: 4px; overflow: hidden; position: relative;">
                        <div style="height: 100%; background: var(--mockup-red); width: 0%; transition: width 0.3s;" id="levelProgressFill"></div>
                    </div>
                    <div style="text-align: right; font-size: 0.75rem; color: var(--mockup-gray); margin-top: 5px;" id="levelXPRatio">
                        0 / 100 XP
                    </div>
                </div>

                <!-- Badges -->
                <div style="width: 100%;">
                    <div style="color: #ffffff; font-weight: bold; font-size: 0.95rem; margin-bottom: 10px; text-align: left;">Badges</div>
                    <div class="badges-grid" id="achievementsBadgesContainer" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 8px;">
                        <div class="achievement-badge-card locked" id="badgeStreak" style="background: #1c2128; border: 1px solid var(--mockup-border); border-radius: 8px; padding: 8px 4px; text-align: center; display: flex; flex-direction: column; align-items: center; transition: all 0.3s;">
                            <div class="achievement-badge-icon" style="font-size: 1.4rem; color: #ff4a5a; margin-bottom: 4px;"><i class="fas fa-fire"></i></div>
                            <div class="achievement-badge-name" style="font-size: 0.65rem; font-weight: 700; color: #ffffff; line-height: 1.2;">Consistency Champ</div>
                        </div>
                        <div class="achievement-badge-card locked" id="badgeNight" style="background: #1c2128; border: 1px solid var(--mockup-border); border-radius: 8px; padding: 8px 4px; text-align: center; display: flex; flex-direction: column; align-items: center; transition: all 0.3s;">
                            <div class="achievement-badge-icon" style="font-size: 1.4rem; color: #b55aff; margin-bottom: 4px;"><i class="fas fa-moon"></i></div>
                            <div class="achievement-badge-name" style="font-size: 0.65rem; font-weight: 700; color: #ffffff; line-height: 1.2;">Night Owl</div>
                        </div>
                        <div class="achievement-badge-card locked" id="badgeEarly" style="background: #1c2128; border: 1px solid var(--mockup-border); border-radius: 8px; padding: 8px 4px; text-align: center; display: flex; flex-direction: column; align-items: center; transition: all 0.3s;">
                            <div class="achievement-badge-icon" style="font-size: 1.4rem; color: #ffd25a; margin-bottom: 4px;"><i class="fas fa-sun"></i></div>
                            <div class="achievement-badge-name" style="font-size: 0.65rem; font-weight: 700; color: #ffffff; line-height: 1.2;">Early Riser</div>
                        </div>
                        <div class="achievement-badge-card locked" id="badgeTenStreak" style="background: #1c2128; border: 1px solid var(--mockup-border); border-radius: 8px; padding: 8px 4px; text-align: center; display: flex; flex-direction: column; align-items: center; transition: all 0.3s;">
                            <div class="achievement-badge-icon" style="font-size: 1.4rem; color: #ff8f5a; margin-bottom: 4px;"><i class="fas fa-trophy"></i></div>
                            <div class="achievement-badge-name" style="font-size: 0.65rem; font-weight: 700; color: #ffffff; line-height: 1.2;">10-Day Streak</div>
                        </div>
                    </div>
                </div>
            </div>
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
            <div class="profile-sidebar" style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                <div class="profile-avatar" id="profileAvatar">G</div>
                <h2 id="profileName" style="color: var(--netflix-white); margin-bottom: 10px;">Guest User</h2>
                <p style="color: var(--netflix-gray); margin-bottom: 20px;">Productivity Enthusiast</p>
                <div id="profileLevelTag" style="background: var(--netflix-red); color: white; padding: 8px 16px; border-radius: 20px; font-weight: bold; display: inline-block; margin-bottom: 15px;">
                    Level 1
                </div>
                <button class="btn btn-secondary" onclick="resetAllData()" style="width: 100%; padding: 10px; font-size: 0.85rem; border-color: #ff4a5a; color: #ff4a5a; font-weight: bold; border-radius: 6px; cursor: pointer; transition: all 0.2s;"><i class="fas fa-trash-alt" style="margin-right: 6px;"></i> Reset All Data</button>
            </div>
            
            <div class="profile-details">
                <div class="stat-card">
                    <div class="stat-title">Personal Information</div>
                    <div class="profile-detail">
                        <div class="detail-label">Full Name</div>
                        <input type="text" id="profileFullNameInput" placeholder="Enter your name" value="" style="background: rgba(255, 255, 255, 0.05); border: 1px solid var(--netflix-light-gray); color: var(--netflix-white); padding: 8px 12px; border-radius: 4px; font-size: 0.95rem; width: 100%; display: none; margin-top: 5px; box-sizing: border-box;">
                        <div class="detail-value" id="profileFullNameDetail">Guest User</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Email</div>
                        <input type="email" id="profileEmailInput" placeholder="Enter your email" value="" style="background: rgba(255, 255, 255, 0.05); border: 1px solid var(--netflix-light-gray); color: var(--netflix-white); padding: 8px 12px; border-radius: 4px; font-size: 0.95rem; width: 100%; display: none; margin-top: 5px; box-sizing: border-box;">
                        <div class="detail-value" id="profileEmailDetail">guest@example.com</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Member Since</div>
                        <div class="detail-value" id="profileMemberSince">January 2024</div>
                    </div>
                    <div style="margin-top: 15px; text-align: right;">
                        <button id="editProfileBtn" class="btn" style="background: var(--netflix-red); color: white; font-weight: bold; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; transition: background 0.2s;"><i class="fas fa-edit"></i> Edit Profile</button>
                        <button id="saveProfileBtn" class="btn" style="background: #2ecc71; color: white; font-weight: bold; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; display: none; transition: background 0.2s;"><i class="fas fa-save"></i> Save Changes</button>
                        <button id="cancelProfileBtn" class="btn" style="background: #7f8c8d; color: white; font-weight: bold; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; display: none; margin-left: 5px; transition: background 0.2s;"><i class="fas fa-times"></i> Cancel</button>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-title">Statistics</div>
                    <div class="profile-detail">
                        <div class="detail-label">Total XP Earned</div>
                        <div class="detail-value" id="profileTotalXP">0 XP</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Habits Completed</div>
                        <div class="detail-value" id="profileHabitsCompleted">0</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Diary Entries</div>
                        <div class="detail-value" id="profileDiaryEntriesCount">0</div>
                    </div>
                    <div class="profile-detail">
                        <div class="detail-label">Pomodoro Sessions</div>
                        <div class="detail-value" id="profilePomodorosCount">0</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-title">Achievements</div>
                    <div id="profileAchievements" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-top: 15px;">
                        <!-- Achievements will be dynamically loaded here by JavaScript -->
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
                <div class="stat-value" id="progressWeekXP">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Habits Completed</div>
                <div class="stat-value" id="progressTotalHabits">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Productivity Score</div>
                <div class="stat-value" id="progressProductivityScore">0%</div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Focus Time</div>
                <div class="stat-value" id="progressFocusTime">0h</div>
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
        // Application State with standard structures and date calculations
        const appState = {
            timer: {
                running: false,
                minutes: 25,
                seconds: 0,
                interval: null
            },
            user: {
                name: 'Guest User',
                email: 'guest@example.com',
                level: 1,
                xp: 0,
                currentStreak: 0,
                bestStreak: 0,
                lastActiveDate: null,
                pomodoros: 0,
                memberSince: 'January 2024'
            },
            habits: [
                { id: 1, name: 'Morning Exercise', xp: 25, description: 'Start your day with energy and focus', completed: false },
                { id: 2, name: 'Reading', xp: 30, description: 'Read for at least 30 minutes', completed: false },
                { id: 3, name: 'Meditation', xp: 20, description: '10 minutes of mindfulness practice', completed: false },
                { id: 4, name: 'Coding Practice', xp: 40, description: 'Work on coding projects', completed: false },
                { id: 5, name: 'Evening Walk', xp: 15, description: '30 minute walk after dinner', completed: false }
            ],
            diaryEntries: [],
            history: {}
        };
        // Inline tab switching logic
        function switchTabDirect(tabId) {
            document.querySelectorAll('.header-nav-tab').forEach(t => {
                if (t.getAttribute('data-tab') === tabId) {
                    t.classList.add('active');
                } else {
                    t.classList.remove('active');
                }
            });
            
            document.querySelectorAll('.tab-content').forEach(c => {
                if (c.getAttribute('id') === `${tabId}-tab`) {
                    c.classList.add('active');
                } else {
                    c.classList.remove('active');
                }
            });
            
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }


        // Helper date string mapping
        function getLocalDateString(date = new Date()) {
            const offset = date.getTimezoneOffset();
            const localDate = new Date(date.getTime() - (offset * 60 * 1000));
            return localDate.toISOString().split('T')[0];
        }

        function getLocalDateOffsetString(offsetDays) {
            const d = new Date();
            d.setDate(d.getDate() - offsetDays);
            const offset = d.getTimezoneOffset();
            const localDate = new Date(d.getTime() - (offset * 60 * 1000));
            return localDate.toISOString().split('T')[0];
        }

        // Initialize default mock history if not present
        function initializeDefaultHistory() {
            if (Object.keys(appState.history).length === 0) {
                appState.history = {};
            }
        }

        // Persistence Functions
        function saveState() {
            localStorage.setItem('streak7_app_state', JSON.stringify({
                user: appState.user,
                habits: appState.habits,
                diaryEntries: appState.diaryEntries,
                history: appState.history
            }));
        }

        function loadState() {
            const saved = localStorage.getItem('streak7_app_state');
            if (saved) {
                try {
                    const parsed = JSON.parse(saved);
                    appState.user = { ...appState.user, ...parsed.user };
                    appState.habits = parsed.habits || appState.habits;
                    appState.diaryEntries = parsed.diaryEntries || [];
                    appState.history = parsed.history || {};

                } catch (e) {
                    console.error("Error loading state", e);
                }
            }
            initializeDefaultHistory();
            checkDailyReset();
        }

        function checkDailyReset() {
            const today = getLocalDateString();
            const lastActive = appState.user.lastActiveDate;
            
            if (lastActive && lastActive !== today) {
                // Reset habit completion tags for the new day
                appState.habits.forEach(h => h.completed = false);
                
                // Verify if streak is broken
                const yesterdayObj = new Date();
                yesterdayObj.setDate(yesterdayObj.getDate() - 1);
                const yesterday = getLocalDateString(yesterdayObj);
                
                const yesterdayHistory = appState.history[yesterday];
                const completedYesterday = yesterdayHistory && yesterdayHistory.completedCount > 0;
                
                if (!completedYesterday && lastActive !== yesterday) {
                    appState.user.currentStreak = 0;
                }
            }
            appState.user.lastActiveDate = today;
            saveState();
        }

        function recordHistory(xpGained, isHabitCompletion = false) {
            const today = getLocalDateString();
            if (!appState.history[today]) {
                appState.history[today] = { xp: 0, completedCount: 0, totalCount: appState.habits.length };
            }
            appState.history[today].xp += xpGained;
            appState.history[today].totalCount = appState.habits.length;
            if (isHabitCompletion) {
                appState.history[today].completedCount++;
            }
            
            if (isHabitCompletion && appState.history[today].completedCount === 1) {
                updateStreak();
            }
            saveState();
        }

        function updateStreak() {
            const today = getLocalDateString();
            const yesterdayObj = new Date();
            yesterdayObj.setDate(yesterdayObj.getDate() - 1);
            const yesterday = getLocalDateString(yesterdayObj);
            
            const yesterdayHistory = appState.history[yesterday];
            const completedYesterday = yesterdayHistory && yesterdayHistory.completedCount > 0;
            
            if (completedYesterday || appState.user.currentStreak === 0) {
                appState.user.currentStreak++;
            } else {
                appState.user.currentStreak = 1;
            }
            
            if (appState.user.currentStreak > appState.user.bestStreak) {
                appState.user.bestStreak = appState.user.currentStreak;
            }
        }

        function handleHabitUncompletion(xpValue, habitId) {
            const today = getLocalDateString();
            const habit = appState.habits.find(h => h.id === habitId);
            if (habit && habit.completed) {
                habit.completed = false;
                appState.user.xp = Math.max(0, appState.user.xp - xpValue);
                
                if (appState.history[today]) {
                    appState.history[today].xp = Math.max(0, appState.history[today].xp - xpValue);
                    appState.history[today].completedCount = Math.max(0, appState.history[today].completedCount - 1);
                    if (appState.history[today].completedCount === 0) {
                        recalculateStreak();
                    }
                }
                
                appState.user.level = Math.floor(appState.user.xp / 100) + 1;
                
                saveState();
                updateUI();
                renderDashboardHabits();
                renderHabits();
                generateGraphs();
                generateHeatmap();
            }
        }

        function recalculateStreak() {
            let streak = 0;
            let checkDate = new Date();
            
            while (true) {
                const dateStr = getLocalDateString(checkDate);
                const dayHistory = appState.history[dateStr];
                if (dayHistory && dayHistory.completedCount > 0) {
                    streak++;
                    checkDate.setDate(checkDate.getDate() - 1);
                } else {
                    if (dateStr === getLocalDateString()) {
                        checkDate.setDate(checkDate.getDate() - 1);
                        continue;
                    }
                    break;
                }
            }
            appState.user.currentStreak = streak;
            if (streak > appState.user.bestStreak) {
                appState.user.bestStreak = streak;
            }
        }

        // Initialize Application
        document.addEventListener('DOMContentLoaded', function() {
            loadState();
            initializeApp();
            setupEventListeners();
            updateUI();
            renderDashboardHabits();
            renderHabits();
            renderDiaryEntries();
            generateHeatmap();
            generateGraphs();

            // Hide loading overlay with transition
            const loadingOverlay = document.getElementById('loadingOverlay');
            if (loadingOverlay) {
                setTimeout(() => {
                    loadingOverlay.style.opacity = '0';
                    setTimeout(() => {
                        loadingOverlay.style.display = 'none';
                    }, 500);
                }, 800);
            }
        });

        function initializeApp() {
            window.addEventListener('scroll', function() {
                const header = document.getElementById('mainHeader');
                if (window.scrollY > 100) {
                    header.classList.add('scrolled');
                } else {
                    header.classList.remove('scrolled');
                }
            });

            updateTimerDisplay();
        }

        function setupEventListeners() {
            document.getElementById('startTimer').addEventListener('click', toggleTimer);
            document.getElementById('resetTimer').addEventListener('click', resetTimer);
            
            document.querySelectorAll('.nav-tab').forEach(tab => {
                tab.addEventListener('click', handleTabNavigation);
            });
            
            document.getElementById('addHabitBtn').addEventListener('click', addNewHabit);
            document.getElementById('saveEntry').addEventListener('click', saveDiaryEntry);
            
            // Start Your Streak button listener
            const startStreakBtn = document.getElementById('startStreakBtn');
            if (startStreakBtn) {
                startStreakBtn.addEventListener('click', () => {
                    const timerCard = document.getElementById('focusTimerTitle');
                    if (timerCard) {
                        timerCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        if (!appState.timer.running) {
                            toggleTimer();
                        }
                    }
                });
            }

            // Edit Profile listeners
            const editProfileBtn = document.getElementById('editProfileBtn');
            const saveProfileBtn = document.getElementById('saveProfileBtn');
            const cancelProfileBtn = document.getElementById('cancelProfileBtn');
            const profileFullNameInput = document.getElementById('profileFullNameInput');
            const profileEmailInput = document.getElementById('profileEmailInput');
            const profileFullNameDetail = document.getElementById('profileFullNameDetail');
            const profileEmailDetail = document.getElementById('profileEmailDetail');

            if (editProfileBtn && saveProfileBtn && cancelProfileBtn && profileFullNameInput && profileEmailInput && profileFullNameDetail && profileEmailDetail) {
                editProfileBtn.addEventListener('click', () => {
                    profileFullNameInput.value = (appState.user.name && appState.user.name !== 'Guest User') ? appState.user.name : '';
                    profileEmailInput.value = (appState.user.email && appState.user.email !== 'guest@example.com') ? appState.user.email : '';
                    
                    profileFullNameInput.style.display = 'block';
                    profileEmailInput.style.display = 'block';
                    profileFullNameDetail.style.display = 'none';
                    profileEmailDetail.style.display = 'none';
                    
                    editProfileBtn.style.display = 'none';
                    saveProfileBtn.style.display = 'inline-block';
                    cancelProfileBtn.style.display = 'inline-block';
                });

                cancelProfileBtn.addEventListener('click', () => {
                    profileFullNameInput.style.display = 'none';
                    profileEmailInput.style.display = 'none';
                    profileFullNameDetail.style.display = 'block';
                    profileEmailDetail.style.display = 'block';
                    
                    editProfileBtn.style.display = 'inline-block';
                    saveProfileBtn.style.display = 'none';
                    cancelProfileBtn.style.display = 'none';
                });

                saveProfileBtn.addEventListener('click', () => {
                    const newName = profileFullNameInput.value.trim() || 'Guest User';
                    const newEmail = profileEmailInput.value.trim() || 'guest@example.com';
                    
                    appState.user.name = newName;
                    appState.user.email = newEmail;
                    
                    saveState();
                    updateUI();
                    
                    profileFullNameInput.style.display = 'none';
                    profileEmailInput.style.display = 'none';
                    profileFullNameDetail.style.display = 'block';
                    profileEmailDetail.style.display = 'block';
                    
                    editProfileBtn.style.display = 'inline-block';
                    saveProfileBtn.style.display = 'none';
                    cancelProfileBtn.style.display = 'none';
                    
                    showNotification('Profile updated successfully!');
                });
            }

            // Quick Journal button listener
            const saveQuickJournalBtn = document.getElementById('saveQuickJournalBtn');
            if (saveQuickJournalBtn) {
                saveQuickJournalBtn.addEventListener('click', saveQuickJournal);
            }

            // Short break button listener
            const startShortBreakBtn = document.getElementById('startShortBreakBtn');
            if (startShortBreakBtn) {
                startShortBreakBtn.addEventListener('click', startShortBreak);
            }
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
            appState.user.pomodoros = (appState.user.pomodoros || 0) + 1;
            saveState();
            
            awardXP(15);
        }

        function updateTimerDisplay() {
            const minutes = appState.timer.minutes;
            const seconds = appState.timer.seconds;
            document.getElementById('timerDisplay').textContent = 
                `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            
            // Circular SVG stroke-dashoffset update
            const circle = document.getElementById('timerSvgCircle');
            if (circle) {
                const isBreak = document.getElementById('timerStatusLabel').textContent.includes("Break");
                const totalSec = isBreak ? (5 * 60) : (25 * 60);
                const currentSec = (minutes * 60) + seconds;
                const progress = currentSec / totalSec;
                const offset = 502.6 * (1 - progress);
                circle.style.strokeDashoffset = offset;
            }
        }

        // Navigation Functions
        function handleTabNavigation(event) {
            const tab = event.target;
            const tabId = tab.getAttribute('data-tab');
            
            document.querySelectorAll('.nav-tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            
            tab.classList.add('active');
            document.getElementById(`${tabId}-tab`).classList.add('active');
        }

        // Habits Functions
        function renderDashboardHabits() {
            const container = document.getElementById('dashboardHabitsContainer');
            if (!container) return;
            container.innerHTML = '';
            
            if (appState.habits.length === 0) {
                container.innerHTML = `<p style="color: var(--mockup-gray); grid-column: 1/-1; text-align: center; padding: 20px;">No habits added yet. Go to the Habits tab to create one!</p>`;
                return;
            }
            
            appState.habits.forEach(habit => {
                const streakVal = habit.streak || 0;
                const progressPercent = Math.min(100, streakVal * 10);
                
                const card = document.createElement('div');
                card.className = 'habit-row';
                card.innerHTML = `
                    <div class="habit-left">
                        <input type="checkbox" class="custom-cb habit-checkbox" id="dash-habit-${habit.id}" data-xp="${habit.xp}" data-habit-id="${habit.id}" ${habit.completed ? 'checked' : ''}>
                        <span class="habit-title-text" style="${habit.completed ? 'text-decoration: line-through; opacity: 0.6;' : ''}">${habit.name}</span>
                    </div>
                    <div class="habit-streak-bar-container">
                        <span class="habit-streak-label">Streak: ${streakVal}</span>
                        <div class="habit-streak-bar">
                            <div class="habit-streak-fill" style="width: ${progressPercent}%;"></div>
                        </div>
                    </div>
                `;
                container.appendChild(card);
                
                const checkbox = card.querySelector('.habit-checkbox');
                checkbox.addEventListener('change', handleHabitCompletionToggle);
            });
        }

        function renderHabits() {
            const container = document.getElementById('habitsContainer');
            if (!container) return;
            container.innerHTML = '';
            
            if (appState.habits.length === 0) {
                container.innerHTML = `<p style="color: var(--netflix-gray); grid-column: 1/-1; text-align: center; padding: 20px;">No habits created yet. Use the form above to add one!</p>`;
                return;
            }
            
            appState.habits.forEach(habit => {
                const habitCard = document.createElement('div');
                habitCard.className = 'habit-card';
                habitCard.innerHTML = `
                    <div class="habit-header">
                        <div class="habit-name">${habit.name}</div>
                        <div class="habit-xp">+${habit.xp} XP</div>
                    </div>
                    <p style="color: var(--netflix-gray); margin-bottom: 15px;">${habit.description || ''}</p>
                    <input type="checkbox" class="habit-checkbox" id="habit-${habit.id}" data-xp="${habit.xp}" data-habit-id="${habit.id}" ${habit.completed ? 'checked' : ''} style="transform: scale(1.2);">
                    <label for="habit-${habit.id}" style="color: var(--netflix-white); margin-left: 10px;">${habit.completed ? 'Completed!' : 'Mark as completed'}</label>
                    <button class="btn btn-secondary" onclick="removeHabit(${habit.id})" style="margin-top: 15px; padding: 8px 16px; font-size: 0.8rem; border-color: var(--netflix-red); color: var(--netflix-red);">Remove Habit</button>
                `;
                container.appendChild(habitCard);
                
                const checkbox = habitCard.querySelector('.habit-checkbox');
                checkbox.addEventListener('change', handleHabitCompletionToggle);
            });
        }

        function handleHabitCompletionToggle(event) {
            const checkbox = event.target;
            const xpValue = parseInt(checkbox.getAttribute('data-xp'));
            const habitId = parseInt(checkbox.getAttribute('data-habit-id'));
            
            if (checkbox.checked) {
                const habit = appState.habits.find(h => h.id === habitId);
                if (habit && !habit.completed) {
                    habit.completed = true;
                    awardXP(xpValue, true);
                    showXPEarnedAnimation(checkbox, xpValue);
                    showNotification(`Completed: ${habit.name}! +${xpValue} XP earned`, 'success');
                    saveState();
                    renderDashboardHabits();
                    renderHabits();
                }
            } else {
                handleHabitUncompletion(xpValue, habitId);
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
                id: Date.now(),
                name: name,
                xp: xp,
                description: description,
                completed: false
            };
            
            appState.habits.push(newHabit);
            saveState();
            renderHabits();
            renderDashboardHabits();
            
            nameInput.value = '';
            xpInput.value = '';
            descInput.value = '';
            
            showNotification('New habit added successfully!', 'success');
        }

        function removeHabit(habitId) {
            appState.habits = appState.habits.filter(h => h.id !== habitId);
            saveState();
            renderHabits();
            renderDashboardHabits();
            showNotification('Habit removed', 'info');
        }

        // Diary Functions
        function renderDiaryEntries() {
            const container = document.getElementById('diaryEntries');
            if (!container) return;
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
            saveState();
            renderDiaryEntries();
            
            titleInput.value = '';
            contentInput.value = '';
            
            showNotification('Diary entry saved successfully!', 'success');
            awardXP(10);
        }

        function saveQuickJournal() {
            const titleInput = document.getElementById('quickJournalTitle');
            const contentInput = document.getElementById('quickJournalContent');
            
            const title = titleInput.value.trim();
            const content = contentInput.value.trim();
            
            if (content === '') {
                showNotification('Please write something in your reflection.', 'error');
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
            saveState();
            renderDiaryEntries();
            updateUI();
            
            titleInput.value = '';
            contentInput.value = '';
            
            showNotification('Reflection saved to your diary! 🎉', 'success');
            awardXP(10);
        }

        function startShortBreak() {
            pauseTimer();
            appState.timer.minutes = 5;
            appState.timer.seconds = 0;
            const statusLabel = document.getElementById('timerStatusLabel');
            if (statusLabel) statusLabel.textContent = "Focus Session (Break 5:00)";
            updateTimerDisplay();
            showNotification('Short break started! Relax for 5 minutes. ☕', 'info');
        }

        // Progress Visualization
        function generateHeatmap() {
            // Populate Progress tab heatmap
            const heatmap = document.getElementById('activityHeatmap');
            if (heatmap) {
                heatmap.innerHTML = '';
                renderCells(heatmap, false);
            }
            
            // Populate Dashboard tab mockup heatmap
            const dashHeatmap = document.getElementById('dashboardHeatmapCells');
            if (dashHeatmap) {
                dashHeatmap.innerHTML = '';
                renderCells(dashHeatmap, true);
            }
            
            // Update streak label in mockup heatmap
            const streakLabel = document.getElementById('heatmapStreakLabel');
            if (streakLabel) {
                streakLabel.textContent = `${appState.user.currentStreak} day${appState.user.currentStreak === 1 ? '' : 's'} current streak`;
            }
        }

        function renderCells(container, isMockup) {
            const days = [];
            for (let i = 27; i >= 0; i--) {
                const d = new Date();
                d.setDate(d.getDate() - i);
                days.push(d);
            }
            days.forEach(day => {
                const dateStr = getLocalDateString(day);
                const dayHistory = appState.history[dateStr];
                const completed = dayHistory ? dayHistory.completedCount : 0;
                
                const cell = document.createElement('div');
                cell.className = isMockup ? 'heatmap-cell' : 'heatmap-day';
                
                const options = { month: 'short', day: 'numeric' };
                const formattedDate = day.toLocaleDateString('en-US', options);
                const titleText = `${formattedDate}: ${completed} habit${completed === 1 ? '' : 's'} completed`;
                
                if (isMockup) {
                    let level = 0;
                    if (completed > 0) {
                        if (completed >= 4) level = 4;
                        else if (completed >= 2) level = 3;
                        else level = 2;
                    }
                    cell.style.backgroundColor = getHeatmapCellColor(level);
                    
                    const tooltip = document.createElement('span');
                    tooltip.className = 'heatmap-cell-tooltip';
                    tooltip.textContent = titleText;
                    cell.appendChild(tooltip);
                } else {
                    cell.title = titleText;
                    if (completed > 0) {
                        cell.classList.add('active');
                        if (completed >= 4) {
                            cell.classList.add('high');
                        } else if (completed >= 2) {
                            cell.classList.add('medium');
                        } else {
                            cell.classList.add('low');
                        }
                    }
                }
                container.appendChild(cell);
            });
        }

        function getHeatmapCellColor(level) {
            const colors = {
                0: '#1c2128',
                1: '#3c1618',
                2: '#6b1d22',
                3: '#a82730',
                4: '#ff4a5a'
            };
            return colors[level] || colors[0];
        }

        function generateGraphs() {
            generateXPGraph();
            generateHabitsGraph();
            generateMockupProgressChart();
        }

        function generateMockupProgressChart() {
            const barsContainer = document.getElementById('weeklyProgressBars');
            const labelsContainer = document.getElementById('weeklyProgressLabels');
            if (!barsContainer || !labelsContainer) return;
            
            barsContainer.innerHTML = '';
            labelsContainer.innerHTML = '';
            
            const days = [];
            for (let i = 6; i >= 0; i--) {
                const d = new Date();
                d.setDate(d.getDate() - i);
                days.push(d);
            }
            
            const xpData = days.map(day => {
                const dateStr = getLocalDateString(day);
                return appState.history[dateStr] ? appState.history[dateStr].xp : 0;
            });
            
            const maxXP = Math.max(...xpData, 10);
            
            const options = { month: 'short', day: 'numeric' };
            const firstDateStr = days[0].toLocaleDateString('en-US', options);
            const lastDateStr = days[6].toLocaleDateString('en-US', options);
            
            const titleElement = document.getElementById('progressOverviewTitle');
            if (titleElement) {
                titleElement.textContent = `PROGRESS OVERVIEW (${firstDateStr.toUpperCase()} - ${lastDateStr.toUpperCase()})`;
            }
            
            days.forEach((day, index) => {
                const xp = xpData[index];
                const heightPercent = (xp / maxXP) * 100;
                
                const col = document.createElement('div');
                col.className = 'progress-bar-col';
                
                const fill = document.createElement('div');
                fill.className = 'progress-bar-fill';
                fill.style.height = `${Math.max(5, heightPercent)}%`;
                fill.setAttribute('data-xp', `${xp} XP`);
                
                col.appendChild(fill);
                barsContainer.appendChild(col);
                
                const weekday = day.toLocaleDateString('en-US', { weekday: 'narrow' });
                const label = document.createElement('div');
                label.className = 'progress-chart-lbl';
                label.textContent = weekday;
                labelsContainer.appendChild(label);
            });
        }

        function generateXPGraph() {
            const graph = document.getElementById('xpGraph');
            if (!graph) return;
            graph.innerHTML = '';
            
            const days = [];
            for (let i = 6; i >= 0; i--) {
                const d = new Date();
                d.setDate(d.getDate() - i);
                days.push(d);
            }
            
            const xpData = days.map(day => {
                const dateStr = getLocalDateString(day);
                return appState.history[dateStr] ? appState.history[dateStr].xp : 0;
            });
            
            const maxXP = Math.max(...xpData, 10);
            
            days.forEach((day, index) => {
                const xp = xpData[index];
                const bar = document.createElement('div');
                bar.className = 'graph-bar';
                const width = (100 / days.length) * 0.8;
                const height = (xp / maxXP) * 100;
                const left = (index * (100 / days.length)) + (width * 0.1);
                
                bar.style.width = `${width}%`;
                bar.style.height = `${Math.max(5, height)}%`;
                bar.style.left = `${left}%`;
                bar.style.background = `linear-gradient(to top, var(--netflix-red), var(--accent))`;
                
                const weekday = day.toLocaleDateString('en-US', { weekday: 'short' });
                bar.title = `${weekday}: ${xp} XP`;
                
                // Add value text label inside or above the bar
                const label = document.createElement('span');
                label.style.position = 'absolute';
                label.style.top = '-20px';
                label.style.left = '50%';
                label.style.transform = 'translateX(-50%)';
                label.style.fontSize = '0.75rem';
                label.style.color = 'var(--netflix-gray)';
                label.textContent = xp > 0 ? xp : '';
                bar.appendChild(label);
                
                graph.appendChild(bar);
            });
        }

        function generateHabitsGraph() {
            const graph = document.getElementById('habitsGraph');
            if (!graph) return;
            graph.innerHTML = '';
            
            const days = [];
            for (let i = 6; i >= 0; i--) {
                const d = new Date();
                d.setDate(d.getDate() - i);
                days.push(d);
            }
            
            const rates = days.map(day => {
                const dateStr = getLocalDateString(day);
                const dayHistory = appState.history[dateStr];
                if (dayHistory && dayHistory.totalCount > 0) {
                    return (dayHistory.completedCount / dayHistory.totalCount) * 100;
                }
                return 0;
            });
            
            days.forEach((day, index) => {
                const rate = rates[index];
                const bar = document.createElement('div');
                bar.className = 'graph-bar';
                const width = (100 / days.length) * 0.8;
                const height = rate;
                const left = (index * (100 / days.length)) + (width * 0.1);
                
                bar.style.width = `${width}%`;
                bar.style.height = `${Math.max(5, height)}%`;
                bar.style.left = `${left}%`;
                bar.style.background = `linear-gradient(to top, var(--info), var(--success))`;
                
                const weekday = day.toLocaleDateString('en-US', { weekday: 'short' });
                bar.title = `${weekday}: ${Math.round(rate)}% Completion`;
                
                const label = document.createElement('span');
                label.style.position = 'absolute';
                label.style.top = '-20px';
                label.style.left = '50%';
                label.style.transform = 'translateX(-50%)';
                label.style.fontSize = '0.75rem';
                label.style.color = 'var(--netflix-gray)';
                label.textContent = rate > 0 ? `${Math.round(rate)}%` : '';
                bar.appendChild(label);
                
                graph.appendChild(bar);
            });
        }

        // Utility Functions
        function awardXP(amount, isHabit = false) {
            appState.user.xp += amount;
            
            const newLevel = Math.floor(appState.user.xp / 100) + 1;
            if (newLevel > appState.user.level) {
                appState.user.level = newLevel;
                showLevelUpAnimation();
                showNotification(`🎉 Congratulations! You reached Level ${newLevel}!`, 'success');
            }
            
            recordHistory(amount, isHabit);
            updateUI();
            generateGraphs();
            generateHeatmap();
        }

        function updateUI() {
            // Update Streaks & XP Summary
            document.getElementById('currentStreak').textContent = `${appState.user.currentStreak} day${appState.user.currentStreak === 1 ? '' : 's'}`;
            document.getElementById('totalXP').textContent = appState.user.xp.toLocaleString();
            
            const userLevelElement = document.getElementById('userLevel');
            if (userLevelElement) {
                userLevelElement.textContent = `Level ${appState.user.level}`;
                userLevelElement.style.display = 'inline-block';
            }
            
            document.getElementById('bestStreak').textContent = `${appState.user.bestStreak} day${appState.user.bestStreak === 1 ? '' : 's'}`;
            
            // Average completions/day
            const habitAvgCompletions = document.getElementById('habitAvgCompletions');
            if (habitAvgCompletions) {
                const daysWithHistory = Object.keys(appState.history).length;
                let totalCompleted = 0;
                Object.values(appState.history).forEach(h => {
                    totalCompleted += h.completedCount || 0;
                });
                const avg = daysWithHistory > 0 ? (totalCompleted / daysWithHistory).toFixed(1) : '0.0';
                habitAvgCompletions.textContent = avg;
            }

            const levelTag = document.getElementById('profileLevelTag');
            if (levelTag) levelTag.textContent = `Level ${appState.user.level}`;
            
            const profileXP = document.getElementById('profileTotalXP');
            if (profileXP) profileXP.textContent = `${appState.user.xp.toLocaleString()} XP`;
            
            const profileHabits = document.getElementById('profileHabitsCompleted');
            if (profileHabits) {
                let totalCompleted = 0;
                Object.values(appState.history).forEach(h => {
                    totalCompleted += h.completedCount || 0;
                });
                profileHabits.textContent = totalCompleted;
            }
            
            const profileDiary = document.getElementById('profileDiaryEntriesCount');
            if (profileDiary) profileDiary.textContent = appState.diaryEntries.length;
            
            const profilePomodoro = document.getElementById('profilePomodorosCount');
            if (profilePomodoro) profilePomodoro.textContent = appState.user.pomodoros || 0;
            
            const progressWeekXP = document.getElementById('progressWeekXP');
            if (progressWeekXP) {
                let weekXP = 0;
                for (let i = 0; i < 7; i++) {
                    const dateStr = getLocalDateOffsetString(i);
                    weekXP += appState.history[dateStr] ? appState.history[dateStr].xp : 0;
                }
                progressWeekXP.textContent = weekXP;
            }
            
            const progressTotalHabits = document.getElementById('progressTotalHabits');
            if (progressTotalHabits) {
                let totalCompleted = 0;
                Object.values(appState.history).forEach(h => {
                    totalCompleted += h.completedCount || 0;
                });
                progressTotalHabits.textContent = totalCompleted;
            }
            
            const progressProductivity = document.getElementById('progressProductivityScore');
            if (progressProductivity) {
                let totalRate = 0;
                let daysCount = 0;
                for (let i = 0; i < 7; i++) {
                    const dateStr = getLocalDateOffsetString(i);
                    const hist = appState.history[dateStr];
                    if (hist && hist.totalCount > 0) {
                        totalRate += (hist.completedCount / hist.totalCount);
                        daysCount++;
                    }
                }
                const score = daysCount > 0 ? Math.round((totalRate / daysCount) * 100) : 0;
                progressProductivity.textContent = `${score}%`;
            }
            
            const progressFocus = document.getElementById('progressFocusTime');
            if (progressFocus) {
                const pomodoros = appState.user.pomodoros || 0;
                const hours = ((pomodoros * 25) / 60).toFixed(1);
                progressFocus.textContent = `${hours}h`;
            }

            // User profile dynamic rendering
            const firstLetter = appState.user.name.charAt(0).toUpperCase();
            
            const headerAvatar = document.getElementById('headerAvatar');
            if (headerAvatar) headerAvatar.textContent = firstLetter;
            
            const welcomeTitle = document.getElementById('welcomeTitle');
            if (welcomeTitle) welcomeTitle.textContent = `WELCOME BACK, ${appState.user.name.toUpperCase()}!`;
            
            const profileAvatar = document.getElementById('profileAvatar');
            if (profileAvatar) profileAvatar.textContent = firstLetter;
            
            const profileName = document.getElementById('profileName');
            if (profileName) profileName.textContent = appState.user.name;
            
            const profileFullNameDetail = document.getElementById('profileFullNameDetail');
            if (profileFullNameDetail) profileFullNameDetail.textContent = appState.user.name;
            
const profileEmailDetail = document.getElementById('profileEmailDetail');
            if (profileEmailDetail) profileEmailDetail.textContent = appState.user.email;

            // Header dynamic details
            const headerUserName = document.getElementById('headerUserName');
            if (headerUserName) headerUserName.textContent = appState.user.name;
            const headerUserLevel = document.getElementById('headerUserLevel');
            if (headerUserLevel) headerUserLevel.textContent = `Level ${appState.user.level}`;

            const profileMemberSince = document.getElementById('profileMemberSince');
            if (profileMemberSince) profileMemberSince.textContent = appState.user.memberSince || 'January 2024';

            // Mockup Achievements and Level Tag updates
            const achievementsTitle = document.getElementById('achievementsTitle');
            if (achievementsTitle) {
                achievementsTitle.textContent = `LEVEL ${appState.user.level} ACHIEVEMENTS`;
            }
            
            const xpInLevel = appState.user.xp % 100;
            const nextLevelTag = document.getElementById('nextLevelTag');
            const levelXPPercent = document.getElementById('levelXPPercent');
            const levelProgressFill = document.getElementById('levelProgressFill');
            const levelXPRatio = document.getElementById('levelXPRatio');
            
            if (nextLevelTag) nextLevelTag.textContent = `Level ${appState.user.level + 1}`;
            if (levelXPPercent) levelXPPercent.textContent = `${xpInLevel}%`;
            if (levelProgressFill) levelProgressFill.style.width = `${xpInLevel}%`;
            if (levelXPRatio) levelXPRatio.textContent = `${xpInLevel} / 100 XP`;

            // Badges unlock checks
            const badgeStreak = document.getElementById('badgeStreak');
            const badgeNight = document.getElementById('badgeNight');
            const badgeEarly = document.getElementById('badgeEarly');
            const badgeTenStreak = document.getElementById('badgeTenStreak');
            
            let totalCompleted = 0;
            Object.values(appState.history).forEach(h => {
                totalCompleted += h.completedCount || 0;
            });
            
            if (badgeStreak) {
                if (appState.user.currentStreak >= 7 || appState.user.bestStreak >= 7) {
                    badgeStreak.classList.remove('locked');
                } else {
                    badgeStreak.classList.add('locked');
                }
            }
            if (badgeNight) {
                if (appState.user.pomodoros >= 1) {
                    badgeNight.classList.remove('locked');
                } else {
                    badgeNight.classList.add('locked');
                }
            }
            if (badgeEarly) {
                if (totalCompleted >= 5) {
                    badgeEarly.classList.remove('locked');
                } else {
                    badgeEarly.classList.add('locked');
                }
            }
            if (badgeTenStreak) {
                if (appState.user.bestStreak >= 10) {
                    badgeTenStreak.classList.remove('locked');
                } else {
                    badgeTenStreak.classList.add('locked');
                }
            }

            // Quick Journal recent entries preview
            const recentJournalTitle = document.getElementById('recentJournalTitle');
            const recentJournalContent = document.getElementById('recentJournalContent');
            if (recentJournalTitle && recentJournalContent) {
                if (appState.diaryEntries.length > 0) {
                    const latest = appState.diaryEntries[0];
                    recentJournalTitle.textContent = `${latest.title} (${latest.date.split(' at')[0]})`;
                    recentJournalContent.textContent = latest.content.substring(0, 85) + (latest.content.length > 85 ? '...' : '');
                } else {
                    recentJournalTitle.textContent = "No recent entries";
                    recentJournalContent.textContent = "Reflections you log will show up here as a quick preview.";
                }
            }

            // Update today's date in Habits Checklist header
            const dailyHabitsTitle = document.getElementById('dailyHabitsTitle');
            if (dailyHabitsTitle) {
                const now = new Date();
                const dayName = now.toLocaleDateString('en-US', { weekday: 'short' }).toUpperCase();
                const monthName = now.toLocaleDateString('en-US', { month: 'short' }).toUpperCase();
                const dateNum = now.getDate();
                dailyHabitsTitle.textContent = `DAILY HABITS - ${dayName}, ${monthName} ${dateNum}`;
            }

            // Profile Tab Achievements fallback (old UI achievements list)
            const achievementsContainer = document.getElementById('profileAchievements');
            if (achievementsContainer) {
                achievementsContainer.innerHTML = '';
                const achievements = [];
                
                if (appState.user.bestStreak >= 7) {
                    achievements.push({ icon: '🔥', label: `${appState.user.bestStreak}-Day Streak` });
                }
                if (totalCompleted >= 5) {
                    achievements.push({ icon: '📚', label: 'Consistency Master' });
                }
                if (appState.user.pomodoros >= 1) {
                    achievements.push({ icon: '⏰', label: 'Focus Champion' });
                }
                
                if (achievements.length === 0) {
                    achievementsContainer.innerHTML = '<div style="grid-column: 1/-1; text-align: center; color: var(--netflix-gray); padding: 15px; font-size: 0.9rem;">Complete habits and pomodoro sessions to unlock achievements!</div>';
                } else {
                    achievements.forEach(ach => {
                        const card = document.createElement('div');
                        card.style.cssText = "text-align: center; padding: 15px; background: var(--netflix-black); border-radius: 8px;";
                        card.innerHTML = `
                            <div style="font-size: 2rem; margin-bottom: 10px;">${ach.icon}</div>
                            <div style="font-size: 0.8rem; color: var(--netflix-white);">${ach.label}</div>
                        `;
                        achievementsContainer.appendChild(card);
                    });
                }
            }
        }

        function showXPEarnedAnimation(element, xp) {
            const rect = element.getBoundingClientRect();
            const xpElement = document.createElement('div');
            xpElement.className = 'xp-earned';
            xpElement.textContent = `+${xp} XP`;
            xpElement.style.left = `${rect.left + rect.width / 2}px`;
            xpElement.style.top = `${rect.top}px`;
            
            document.body.appendChild(xpElement);
            xpElement.style.animation = 'floatUp 1s ease-out forwards';
            
            setTimeout(() => {
                xpElement.remove();
            }, 1000);
        }

        function showLevelUpAnimation() {
            const levelElement = document.getElementById('profileLevelTag');
            if (levelElement) {
                levelElement.classList.add('level-up');
                setTimeout(() => {
                    levelElement.classList.remove('level-up');
                }, 1500);
            }
        }

        function showNotification(message, type = 'info') {
            const existingNotification = document.querySelector('.notification');
            if (existingNotification) {
                existingNotification.remove();
            }
            
            const notification = document.createElement('div');
            notification.className = `notification`;
            notification.textContent = message;
            
            const colors = {
                success: '#2ecc71',
                error: '#e74c3c',
                info: '#3498db',
                warning: '#f39c12'
            };
            
            notification.style.backgroundColor = colors[type] || colors.info;
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            }, 4000);
        }
    </script>
    <!-- Footer Section -->
    <footer style="text-align: center; padding: 40px; margin-top: 50px; border-top: 1px solid var(--netflix-light-gray); color: var(--netflix-gray); font-size: 0.95rem; background: var(--netflix-dark);">
        <p>© 2026 Streak7 Pro. All Rights Reserved. Built by Sarvesh. <a href="https://github.com/Sarvesh0508/Habit-Tracker" target="_blank" style="color: var(--netflix-red); text-decoration: none; font-weight: bold; margin-left: 10px;"><i class="fab fa-github"></i> View on GitHub</a></p>
    </footer>
</body>
</html>