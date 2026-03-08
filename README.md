# Reflectra – Self Reflection App

Reflectra is a Flutter based self-reflection application designed to help users improve self-awareness and personal growth.  
The application asks reflective questions, allows users to record thoughts, log regrets with lessons learned, and analyze emotional patterns through a personality dashboard.

This project was developed as part of **ALA-3: Persistent Data Management** in the **Frameworks of Android Development** course.

---

## Features

### 1. Daily Reflection
Users can answer thoughtful questions that encourage personal reflection and self-analysis.

### 2. Mood Tracker
Each reflection allows the user to record their emotional state such as:
- Happy
- Neutral
- Sad
- Frustrated
- Calm

### 3. Reflection History
All reflections are stored locally and can be viewed later using a searchable history list.

### 4. Manual Regret Logging
Users can manually log:
- Regret
- Lesson learned
- Category (Productivity, Relationships, Health, etc.)

This helps users learn from mistakes and track personal improvement.

### 5. Personality Dashboard
The dashboard analyzes stored data and displays insights such as:

- Total reflections written
- Total regrets logged
- Reflection streak
- Most common mood
- Dominant life category

Based on the data, the application generates simple personality insights.

### 6. Reflection Streak
Tracks how consistently a user records reflections.

---

## Technologies Used

- Flutter
- Dart
- SharedPreferences (Local Storage)
- Material UI

---

## Persistent Data Management

The application uses **SharedPreferences** to store and retrieve data locally.

Stored data includes:

- Reflection answers
- Mood selections
- Regret logs
- Lessons learned
- Reflection streak data

Data is saved in JSON format and retrieved whenever the app is opened.

---

## Application Workflow

1. The user opens the app and selects **Write Reflection**.
2. The app displays a reflective question.
3. The user writes their thoughts and selects a mood.
4. The reflection is stored locally using SharedPreferences.
5. The user can view past reflections in the **History screen**.
6. The **Regret Logging** feature allows users to record mistakes and lessons learned.
7. The **Dashboard** analyzes stored reflections and regrets to generate personality insights.

---

## Project Structure
lib/
├── models
│ ├── answer_model.dart
│ ├── regret_model.dart
│
├── screens
│ ├── home_screen.dart
│ ├── reflection_screen.dart
│ ├── history_screen.dart
│ ├── dashboard_screen.dart
│ ├── add_regret_screen.dart
│
├── storage
│ └── local_storage.dart
│
└── main.dart


---

## Learning Outcome

Through this project, the following concepts were implemented:

- Flutter application structure
- Local persistent storage using SharedPreferences
- JSON data handling
- State management in Flutter
- User interface design using Material widgets
- Basic data analytics for personal insights

---

## GitHub Repository

Project Repository:

https://github.com/archimparmar/reflectra-flutter-ala3

---

## Author

Archi Parmar  
20230905040030
Class B 
CE
Sem 6
Computer Engineering  
Gyanmanjari Innovative University