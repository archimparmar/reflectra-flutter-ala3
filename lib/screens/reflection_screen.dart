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

class _ReflectionScreenState extends State<ReflectionScreen> {
  final TextEditingController controller =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingAnswer != null) {
      controller.text = widget.existingAnswer!;
    }
  }

  void saveAnswer() async {
    if (controller.text.isEmpty) return;

    final answer = AnswerModel(
      question: widget.question,
      answer: controller.text,
      date: DateTime.now().toString(),
    );

    if (widget.index != null) {
      await LocalStorage.updateAnswer(
          widget.index!, answer);
    } else {
      await LocalStorage.saveAnswer(answer);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Your Reflection")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Write your reflection",
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveAnswer,
                child: const Text("Save Reflection"),
              ),
            )
          ],
        ),
      ),
    );
  }
}