import 'package:hooks_riverpod/hooks_riverpod.dart';

final fontSizeProvider = StateProvider<double>((ref) => 0);

final isNightThemeProvider = StateProvider<bool>((ref) => false);
