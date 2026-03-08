import 'package:flutter/material.dart';
import '../models/regret_model.dart';
import '../storage/local_storage.dart';

class AddRegretScreen extends StatefulWidget {
  const AddRegretScreen({super.key});

  @override
  State<AddRegretScreen> createState() => _AddRegretScreenState();
}

class _AddRegretScreenState extends State<AddRegretScreen> {

  final regretController = TextEditingController();
  final lessonController = TextEditingController();

  String category = "Productivity";

  void saveRegret() async {

    final regret = RegretModel(
      regret: regretController.text,
      lesson: lessonController.text,
      category: category,
      date: DateTime.now().toString(),
    );

    await LocalStorage.saveRegret(regret);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Add Regret")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: regretController,
              decoration: const InputDecoration(
                labelText: "Your Regret",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: lessonController,
              decoration: const InputDecoration(
                labelText: "Lesson Learned",
              ),
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(
              value: category,
              items: [
                "Productivity",
                "Relationships",
                "Career",
                "Health"
              ]
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveRegret,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}