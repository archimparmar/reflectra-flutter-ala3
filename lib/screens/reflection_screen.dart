import 'package:flutter/material.dart';
import '../models/answer_model.dart';
import '../storage/local_storage.dart';

class ReflectionScreen extends StatefulWidget {

  final String question;
  final String? existingAnswer;
  final int? index;

  const ReflectionScreen({
    super.key,
    required this.question,
    this.existingAnswer,
    this.index,
  });

  @override
  State<ReflectionScreen> createState() =>
      _ReflectionScreenState();
}

class _ReflectionScreenState
    extends State<ReflectionScreen> {

  final TextEditingController controller =
  TextEditingController();

  String selectedMood = "🙂 Happy";

  @override
  void initState() {
    super.initState();

    if (widget.existingAnswer != null) {
      controller.text = widget.existingAnswer!;
    }
  }

  void saveAnswer() async {

    final answer = AnswerModel(
      question: widget.question,
      answer: controller.text,
      mood: selectedMood,
      date: DateTime.now().toString(),
    );

    if (widget.index != null) {
      await LocalStorage.updateAnswer(
          widget.index!, answer);
    } else {
      await LocalStorage.saveAnswer(answer);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Reflection"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              widget.question,
              style: const TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write your reflection...",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedMood,
              items: const [
                DropdownMenuItem(
                    value: "🙂 Happy",
                    child: Text("🙂 Happy")),
                DropdownMenuItem(
                    value: "😐 Neutral",
                    child: Text("😐 Neutral")),
                DropdownMenuItem(
                    value: "😔 Sad",
                    child: Text("😔 Sad")),
                DropdownMenuItem(
                    value: "😡 Frustrated",
                    child: Text("😡 Frustrated")),
                DropdownMenuItem(
                    value: "😌 Calm",
                    child: Text("😌 Calm")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedMood = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveAnswer,
              child: const Text("Save Reflection"),
            ),
          ],
        ),
      ),
    );
  }
}