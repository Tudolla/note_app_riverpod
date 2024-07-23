import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({super.key, required this.titleRadio, required this.color});

  final String titleRadio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: color,
        ),
        child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Transform.translate(
              offset: Offset(-22, 0),
              child: Text(
                titleRadio,
                style: TextStyle(
                  color: color,
                  fontFamily: "fontText",
                ),
              ),
            ),
            value: 1,
            groupValue: 0,
            onChanged: (value) {
              // print("Kieu Van live");
            }),
      ),
    );
  }
}
