import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_riverpod/common/show_modal.dart';
import 'package:note_app_riverpod/model/note_model.dart';
import 'package:note_app_riverpod/provider/name_user_provider.dart';
import 'package:note_app_riverpod/provider/note_provider.dart';
import 'package:note_app_riverpod/provider/time_now_provider.dart';
import 'package:note_app_riverpod/screens/splash_screen.dart';
import 'package:note_app_riverpod/widget/note_card_widget.dart';
import 'package:note_app_riverpod/widget/note_card_widget_search.dart';

final dateTimeProvider = StateNotifierProvider<DateTimeNotifier, DateTime>(
  (ref) => DateTimeNotifier(DateTime.now()),
);

final userNameProvider = StateNotifierProvider<UserNameProvider, String?>(
  (ref) => UserNameProvider(),
);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _findNote = TextEditingController();
  final _focusNode = FocusNode();

  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    Timer.periodic(
      const Duration(hours: 1),
      (timer) => ref.read(dateTimeProvider.notifier).updateDateTime(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _findNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int titleSearchLength = _titleController.text.length;

    var size = MediaQuery.of(context).size;

    // usercase: get username from SharePreference
    final name = ref.watch(userNameProvider);

    // usecase: get note list
    final noteDataProvider = ref.watch(fetchNoteProvider);

    // usecase: search note by title
    final searchProvider = ref.watch(searchNoteProvider(_titleController.text));

    // usecase: date time controller
    final dateTime = ref.watch(dateTimeProvider);
    String getDateTime = DateFormat('dd-MM-yyyy').format(dateTime);

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: _customAppBar(name, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task of: $name",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: "fontText",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Today: $getDateTime",
                      style: TextStyle(
                        color: Colors.pink[300],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.greenAccent.withOpacity(.5),
                    elevation: 2,
                  ),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const AddNewTaskModal(),
                  ),
                  child: const Text(
                    "+Add Task",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            titleSearchLength == 0
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: noteDataProvider.value?.length ?? 0,
                      itemBuilder: (context, index) => CardNoteWidget(
                        getIndex: index,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchProvider.value?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CardNoteWidgetSearch(
                          getIndex: index,
                          title: _titleController.text,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _logout(context);
        },
        tooltip: "Signout",
        backgroundColor: Colors.blueGrey.shade300,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.logout),
      ),
    );
  }

  AppBar _customAppBar(String? name, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.greenAccent.shade200,
          radius: 20,
          child: Image.asset("assets/images/avatar.png"),
        ),
        title: const Text(
          "Hello,",
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          name ?? "",
          style: const TextStyle(
            fontSize: 15,
            fontFamily: "fontText",
            color: Colors.purpleAccent,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.3,
            height: 40,
            child: TextFormField(
              controller: _titleController,
              autofocus: false,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'find by title',
              ),
              onEditingComplete: () => _focusNode.unfocus(),
            ),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) async {
    // await removeName();
    // Hiển thị dialog xác nhận
    bool? confirmLogout = await showDialog<bool>(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure, logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Signout'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }
  }
}
