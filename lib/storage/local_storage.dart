import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/answer_model.dart';
import '../models/regret_model.dart';

class LocalStorage {

  // Save reflection
  static Future<void> saveAnswer(AnswerModel answer) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('answers') ?? [];

    data.add(jsonEncode(answer.toJson()));

    await prefs.setStringList('answers', data);

    await updateStreak();
  }

  // Get all reflections
  static Future<List<AnswerModel>> getAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('answers') ?? [];

    return data
        .map((e) => AnswerModel.fromJson(jsonDecode(e)))
        .toList();
  }

  // Update reflection
  static Future<void> updateAnswer(int index, AnswerModel updated) async {

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('answers') ?? [];

    if (index >= 0 && index < data.length) {
      data[index] = jsonEncode(updated.toJson());
      await prefs.setStringList('answers', data);
    }
  }

  // Save regret
  static Future<void> saveRegret(RegretModel regret) async {

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('regrets') ?? [];

    data.add(jsonEncode(regret.toJson()));

    await prefs.setStringList('regrets', data);
  }

  // Get regrets
  static Future<List<RegretModel>> getRegrets() async {

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('regrets') ?? [];

    return data
        .map((e) => RegretModel.fromJson(jsonDecode(e)))
        .toList();
  }

  // Update reflection streak
  static Future<int> updateStreak() async {

    final prefs = await SharedPreferences.getInstance();

    final lastDate = prefs.getString('last_date');

    int streak = prefs.getInt('streak') ?? 0;

    final today = DateTime.now().toString().substring(0,10);

    if (lastDate != today) {
      streak++;
    }

    await prefs.setString('last_date', today);
    await prefs.setInt('streak', streak);

    return streak;
  }

  // Get streak
  static Future<int> getStreak() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt('streak') ?? 0;
  }
}