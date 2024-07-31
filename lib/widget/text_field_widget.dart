import 'package:flutter/material.dart';

// final textInputProvider = StateProvider<String>((ref) {
//   return '';
// });

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final int maxLine;
  final TextEditingController controller;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.controller,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final FocusNode _focusNode = FocusNode();
  // late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = widget.controller;
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  void _unfocus() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        autofocus: false,
        controller: widget.controller,
        maxLines: widget.maxLine,
        onSubmitted: (_) => _unfocus,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
