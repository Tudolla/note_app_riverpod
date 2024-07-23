import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app_riverpod/constants/app_style.dart';
import 'package:note_app_riverpod/widget/date_time_widget.dart';
import 'package:note_app_riverpod/widget/radio_widget.dart';
import 'package:note_app_riverpod/widget/text_field_widget.dart';

class AddNewTaskModal extends StatelessWidget {
  const AddNewTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
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
            TextFieldWidget(hintText: "Add description notes", maxLine: 6),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Type note",
              style: AppStyle.headingOne,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: RadioWidget(
                        titleRadio: "read", color: Colors.greenAccent)),
                Expanded(
                    child:
                        RadioWidget(titleRadio: "play", color: Colors.purple)),
                Expanded(
                    child: RadioWidget(
                        titleRadio: "work", color: Colors.blueAccent)),
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
                  text: "dd/mm/yyyy",
                ),
                const SizedBox(width: 20),
                DateTimeWidget(
                  icon: Icons.lock_clock,
                  type: "Hour",
                  text: "hh:mm",
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
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
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
                    onPressed: () {},
                    child: const Text("Add Task"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
