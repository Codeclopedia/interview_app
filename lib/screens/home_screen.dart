import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/changes_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../network/auth_services.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              ref.read(userProvider.notifier).state = null;
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer(builder: (context, ref, child) {
            final double fontSize = ref.watch(fontSizeProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                        ),
                      ]),
                  child: Image.network(user?.photoURL ?? ''),
                ),
                const SizedBox(height: 10),
                Text(
                  'Name: ${user?.displayName}',
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  'TimeZone: ${user?.metadata.creationTime?.timeZoneName}',
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  'Email: ${user?.email}',
                  style: TextStyle(fontSize: fontSize),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()),
                    );
                  },
                  child: const Text('Go to Settings'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
