import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/answer_model.dart';

class LocalStorage {
  static Future<void> saveQuestion(String question) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('question', question);
    await prefs.setInt(
        'timestamp',
        DateTime.now().millisecondsSinceEpoch);
  }

  static Future<Map<String, dynamic>> getSavedQuestion() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "question": prefs.getString('question'),
      "timestamp": prefs.getInt('timestamp'),
    };
  }

  static Future<void> saveAnswer(AnswerModel answer) async {
    final prefs = await SharedPreferences.getInstance();

    final existing = prefs.getStringList('answers') ?? [];

    existing.add(jsonEncode(answer.toJson()));

    await prefs.setStringList('answers', existing);
  }

  static Future<List<AnswerModel>> getAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('answers') ?? [];

    return data
        .map((e) =>
        AnswerModel.fromJson(jsonDecode(e)))
        .toList();
  }

  // UPDATE reflection
  static Future<void> updateAnswer(
      int index, AnswerModel updated) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('answers') ?? [];

    if (index >= 0 && index < data.length) {
      data[index] = jsonEncode(updated.toJson());
      await prefs.setStringList('answers', data);
    }
  }
}