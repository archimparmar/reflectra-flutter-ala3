import 'package:flutter/material.dart';
import '../models/answer_model.dart';
import '../storage/local_storage.dart';
import 'reflection_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<AnswerModel> answers = [];

  @override
  void initState() {
    super.initState();
    loadAnswers();
  }

  Future<void> loadAnswers() async {
    final data = await LocalStorage.getAnswers();

    setState(() {
      answers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Reflection History")),
      body: answers.isEmpty
          ? const Center(child: Text("No reflections yet"))
          : ListView.builder(
        itemCount: answers.length,
        itemBuilder: (context, index) {
          final item = answers[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(item.question),
              subtitle: Text(item.answer),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReflectionScreen(
                        question: item.question,
                        existingAnswer: item.answer,
                        index: index,
                      ),
                    ),
                  ).then((_) => loadAnswers());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}