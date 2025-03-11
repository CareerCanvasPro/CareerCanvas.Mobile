import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldDialog extends StatefulWidget {
  final Function(String) onSubmit;
  final String title;
  final String? Function(String?)? validator;
  final String? existingText;
  const TextFieldDialog({
    super.key,
    required this.onSubmit,
    this.title = "Text",
    this.validator,
    this.existingText,
  });

  @override
  State<TextFieldDialog> createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.existingText != null && widget.existingText!.isNotEmpty) {
      controller.text = widget.existingText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: getCTATextStyle(context, 24, color: Colors.black),
        ),
        const SizedBox(height: 20),
        Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            validator: widget.validator,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade500),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Submit",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Get.back();
                    widget.onSubmit(controller.text);
                  }
                },
                backgroundColor: primaryBlue,
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Cancel",
                onPressed: () => Get.back(),
                backgroundColor: primaryBlue.withOpacity(0.8),
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
