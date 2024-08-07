import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimeNotifier extends StateNotifier<DateTime> {
  DateTimeNotifier(super.state);

  void updateDateTime() {
    state = DateTime.now();
  }
}
