import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:note_app_riverpod/constants/app_style.dart';
import 'package:note_app_riverpod/model/note_model.dart';
import 'package:note_app_riverpod/provider/date_time_provider.dart';
import 'package:note_app_riverpod/provider/note_provider.dart';
import 'package:note_app_riverpod/provider/radio_provider.dart';
import 'package:note_app_riverpod/widget/date_time_widget.dart';
import 'package:note_app_riverpod/widget/radio_widget.dart';
import 'package:note_app_riverpod/widget/text_field_widget.dart';

class AddNewTaskModal extends ConsumerStatefulWidget {
  const AddNewTaskModal({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewTaskModalState();
}

class _AddNewTaskModalState extends ConsumerState<AddNewTaskModal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void didUpdateWidget(covariant AddNewTaskModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    ref.read(timeProvider.notifier).update((state) => "hh : mm");

    ref.read(dateProvider.notifier).update((state) => "dd/mm/yy");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);

    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Add new task, today",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "fontText",
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.withOpacity(.5),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Title task",
              style: AppStyle.headingOne,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              hintText: "Add task name",
              maxLine: 1,
              controller: _titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Description",
              style: AppStyle.headingOne,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              hintText: "Add description notes",
              maxLine: 6,
              controller: _descriptionController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Type note",
              style: AppStyle.headingOne,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: RadioWidget(
                    titleRadio: "read",
                    color: Colors.greenAccent,
                    valueInput: 1,
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: "play",
                    color: Colors.purple,
                    valueInput: 2,
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: "work",
                    color: Colors.blueAccent,
                    valueInput: 3,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  icon: Icons.calendar_month_outlined,
                  type: "Date",
                  text: dateProv,
                  onTapDatePicker: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2025),
                      initialDate: DateTime.now(),
                    );
                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  },
                ),
                const SizedBox(width: 20),
                DateTimeWidget(
                  icon: Icons.lock_clock,
                  type: "Time",
                  text: ref.watch(timeProvider),
                  onTapDatePicker: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      foregroundColor: Colors.blue.shade400,
                      elevation: 3,
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade500,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final getRadioValue = ref.read(radioProvider);

                      String category = '';
                      switch (getRadioValue) {
                        case 1:
                          category = 'Learning';
                          break;

                        case 2:
                          category = 'Working';
                          break;

                        case 3:
                          category = 'Play';
                          break;
                      }
                      ref.read(noteProvider).addNewNote(
                            NoteModel(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              category: category,
                              dateTask: ref.read(dateProvider),
                              timeTask: ref.read(timeProvider),
                              idDone: false,
                            ),
                          );

                      Navigator.of(context).pop();
                    },
                    child: const Text("Create"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
