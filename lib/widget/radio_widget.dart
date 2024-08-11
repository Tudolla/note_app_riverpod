import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app_riverpod/provider/radio_provider.dart';

class RadioWidget extends ConsumerStatefulWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.color,
    required this.valueInput,
    // required this.onChangeRadioValue,
  });

  final String titleRadio;
  final Color color;
  final int valueInput;
  // final VoidCallback onChangeRadioValue;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends ConsumerState<RadioWidget> {
  @override
  Widget build(BuildContext context) {
    final radio = ref.watch(radioProvider);

    return Material(
      child: RadioListTile(
        activeColor: widget.color,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: const Offset(-22, 0),
          child: Text(
            widget.titleRadio,
            style: TextStyle(
              color: widget.color,
              fontFamily: "fontText",
            ),
          ),
        ),
        value: widget.valueInput,
        groupValue: radio,
        onChanged: (value) {
          ref.read(radioProvider.notifier).state = value!;
        },
      ),
    );
  }
}
