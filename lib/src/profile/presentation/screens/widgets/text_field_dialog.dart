import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldDialog extends StatefulWidget {
  final Function(String) onSubmit;
  final String title;
  final String? Function(String?)? validator;
  final String? existingText;
  final String? subTitle;
  const TextFieldDialog({
    super.key,
    required this.onSubmit,
    this.title = "Text",
    this.validator,
    this.existingText,
    this.subTitle,
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
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryBlue,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.subTitle != null)
                  Text(
                    widget.subTitle!,
                    textAlign: TextAlign.left,
                    style: getCTATextStyle(
                      context,
                      12,
                      color: Colors.white,
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
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
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
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
                        textStyle:
                            getCTATextStyle(context, 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        title: "Cancel",
                        onPressed: () => Get.back(),
                        color: primaryBlue,
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
