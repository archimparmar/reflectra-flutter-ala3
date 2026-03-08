import 'package:flutter/material.dart';
import '../models/answer_model.dart';
import '../models/regret_model.dart';
import '../storage/local_storage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int totalReflections = 0;
  int totalRegrets = 0;
  int streak = 0;

  String mostCommonMood = "No data";
  String dominantCategory = "No data";

  @override
  void initState() {
    super.initState();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {

    List<AnswerModel> reflections = await LocalStorage.getAnswers();
    List<RegretModel> regrets = await LocalStorage.getRegrets();
    int s = await LocalStorage.getStreak();

    Map<String,int> moodMap = {};
    Map<String,int> categoryMap = {};

    // Count moods safely
    for (var r in reflections) {
      if (r.mood != null && r.mood.toString().isNotEmpty) {
        moodMap[r.mood] = (moodMap[r.mood] ?? 0) + 1;
      }
    }

    // Count regret categories safely
    for (var r in regrets) {
      if (r.category != null && r.category.toString().isNotEmpty) {
        categoryMap[r.category] =
            (categoryMap[r.category] ?? 0) + 1;
      }
    }

    String mood = "No data";
    String category = "No data";

    if (moodMap.isNotEmpty) {
      mood = moodMap.entries
          .reduce((a,b)=> a.value>b.value ? a : b)
          .key;
    }

    if (categoryMap.isNotEmpty) {
      category = categoryMap.entries
          .reduce((a,b)=> a.value>b.value ? a : b)
          .key;
    }

    if (!mounted) return;

    setState(() {
      totalReflections = reflections.length;
      totalRegrets = regrets.length;
      streak = s;
      mostCommonMood = mood;
      dominantCategory = category;
    });
  }

  String personalityInsight() {

    if (totalReflections > 10 && totalRegrets > 5) {
      return "You actively reflect and learn from your mistakes.";
    }

    if (dominantCategory == "Productivity") {
      return "You focus strongly on improving productivity.";
    }

    if (mostCommonMood.contains("Calm")) {
      return "You appear emotionally balanced.";
    }

    return "You are developing self-awareness through reflection.";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Personality Dashboard"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            Card(
              child: ListTile(
                leading: const Icon(Icons.local_fire_department),
                title: const Text("Reflection Streak"),
                subtitle: Text("$streak days"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.psychology),
                title: const Text("Total Reflections"),
                subtitle: Text("$totalReflections"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: const Text("Regrets Logged"),
                subtitle: Text("$totalRegrets"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.mood),
                title: const Text("Most Common Mood"),
                subtitle: Text(mostCommonMood.toString()),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.category),
                title: const Text("Dominant Category"),
                subtitle: Text(dominantCategory.toString()),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  personalityInsight(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}