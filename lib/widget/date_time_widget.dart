import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app_riverpod/constants/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.type,
    required this.icon,
    required this.text,
    required this.onTapDatePicker,
  });
  final String type;
  final IconData icon;
  final String text;
  final VoidCallback onTapDatePicker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: AppStyle.headingOne,
          ),
          Ink(
            child: InkWell(
              onTap: onTapDatePicker,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(icon),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(text),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
