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

  List<AnswerModel> reflections = [];
  List<AnswerModel> filteredReflections = [];

  @override
  void initState() {
    super.initState();
    loadReflections();
  }

  Future<void> loadReflections() async {
    final data = await LocalStorage.getAnswers();

    setState(() {
      reflections = data;
      filteredReflections = data;
    });
  }

  void searchReflection(String query) {
    final results = reflections.where((item) {
      return item.answer
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          item.question
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredReflections = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflection History"),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search reflections...",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: searchReflection,
            ),
          ),

          Expanded(
            child: filteredReflections.isEmpty
                ? const Center(
                child: Text("No reflections yet"))
                : ListView.builder(
              itemCount: filteredReflections.length,
              itemBuilder: (context, index) {

                final item =
                filteredReflections[index];

                return Card(
                  margin:
                  const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(item.question),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(item.answer),
                        const SizedBox(height: 4),
                        Text(
                          "Mood: ${item.mood}",
                          style: const TextStyle(
                              fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ReflectionScreen(
                                  question:
                                  item.question,
                                  existingAnswer:
                                  item.answer,
                                  index: index,
                                ),
                          ),
                        ).then((_) =>
                            loadReflections());
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}