import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app_riverpod/provider/note_provider.dart';

class CardNoteWidget extends ConsumerWidget {
  final int getIndex;
  const CardNoteWidget({
    super.key,
    required this.getIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteData = ref.watch(fetchNoteProvider);
    return noteData.when(
      data: (noteData) {
        Color categoryColor = Colors.white;

        final getCategory = noteData[getIndex].category;
        switch (getCategory) {
          case "Learning":
            categoryColor = Colors.pink.shade200;
            break;
          case "Working":
            categoryColor = Colors.blue.shade200;
            break;
          case "Play":
            categoryColor = Colors.green.shade300;
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => ref
                              .read(noteProvider)
                              .deleteTask(noteData[getIndex].docID),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          noteData[getIndex].title,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: noteData[getIndex].idDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          noteData[getIndex].description,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: noteData[getIndex].idDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            activeColor: Colors.greenAccent.shade400,
                            value: noteData[getIndex].idDone,
                            onChanged: (value) => ref
                                .read(noteProvider)
                                .upDateTask(noteData[getIndex].docID, value),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade400,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Today',
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(noteData[getIndex].timeTask),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
