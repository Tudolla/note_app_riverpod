import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNameProvider extends StateNotifier<String?> {
  // initial state is null . Then, _loadUserName() start
  UserNameProvider() : super(null) {
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString("nameAccount");

    state = name;
  }

  Future<bool> checkNameExists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('nameAccount');
  }
}
