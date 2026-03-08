import 'package:flutter/material.dart';
import 'reflection_screen.dart';
import 'history_screen.dart';
import 'dashboard_screen.dart';
import 'add_regret_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflectra"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Write Reflection"),
                subtitle: const Text("Answer today's reflection question"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReflectionScreen(
                        question:
                        "How does your mindset influence today's decisions?",
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Reflection History"),
                subtitle: const Text("View and search past reflections"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HistoryScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: const Text("Add Regret"),
                subtitle: const Text("Log a regret and lesson learned"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddRegretScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text("Personality Dashboard"),
                subtitle: const Text("View reflection analytics"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}