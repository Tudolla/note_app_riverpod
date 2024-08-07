import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateProvider.autoDispose<String>((ref) {
  return 'dd/mm/yy';
});

final timeProvider = StateProvider.autoDispose<String>((ref) {
  return "hh : mm";
});
