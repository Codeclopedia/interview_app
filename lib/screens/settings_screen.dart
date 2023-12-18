import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/changes_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          final double fontSize = ref.watch(fontSizeProvider);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Change Font Size and Theme Here',
                    style: TextStyle(fontSize: fontSize)),
                ElevatedButton(
                  onPressed: () {
                    double customFontSize = fontSize;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Change font size',
                            style: TextStyle(fontSize: 15),
                          ),
                          content: TextFormField(
                            onChanged: (value) {
                              customFontSize =
                                  double.parse(value.isEmpty ? '0.0' : value);
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('CANCEL'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(fontSizeProvider.notifier).state =
                                    customFontSize;
                                Navigator.pop(context);
                              },
                              child: const Text('ACCEPT'),
                            ),
                          ],
                        );
                      },
                    );

                    ref.read(fontSizeProvider.notifier).state = 10;
                  },
                  child: const Text('Change Font Size'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(isNightThemeProvider.notifier).state =
                        !ref.read(isNightThemeProvider);
                  },
                  child: const Text('Change Theme'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
