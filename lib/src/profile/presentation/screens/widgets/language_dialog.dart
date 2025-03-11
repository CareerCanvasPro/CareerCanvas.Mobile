import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageAddDialog extends StatefulWidget {
  final List<String>? existingLanguages;
  final Function(List<String>) onSubmit;
  const LanguageAddDialog({
    super.key,
    this.existingLanguages,
    required this.onSubmit,
  });

  @override
  State<LanguageAddDialog> createState() => _LanguageAddDialogState();
}

class _LanguageAddDialogState extends State<LanguageAddDialog> {
  List<String> _languages = [];
  final TextEditingController languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingLanguages != null &&
        widget.existingLanguages!.isNotEmpty) {
      _languages.addAll(widget.existingLanguages!);
    }
  }

  // Method to add a new skills field
  void _addLanguageField(String skill) {
    setState(() {
      _languages.add(skill);
    });
  }

  // Method to remove the last skills field
  void _removeSkilssField(int index) {
    if (_languages.isNotEmpty && index < _languages.length) {
      setState(() {
        _languages.removeAt(index);
      });
    }
  }

  List<String> languageList = [
    "English",
    "Spanish",
    "French",
    "German",
    "Chinese",
    "Japanese",
    "Korean",
    "Hindi",
    "Bengali",
    "Portuguese",
    "Russian",
    "Arabic",
    "Italian",
    "Turkish",
    "Dutch",
    "Swedish",
    "Greek",
    "Hebrew",
    "Thai",
    "Vietnamese",
  ];
  List<String> searchLanguage(String input) {
    return languageList
        .where((element) => element.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }

  // Skills will be in a chieps style design with a x button to remove the skill
  Widget _buildSkilssCard(int index) {
    return Card(
      elevation: 3,
      // margin: const EdgeInsets.only(bottom: 16.0),
      color: scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_languages[index]),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _removeSkilssField(index),
              icon: Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Update Language",
          textAlign: TextAlign.center,
          style: getCTATextStyle(context, 24, color: Colors.black),
        ),
        const SizedBox(height: 20),
        if (_languages.isNotEmpty)
          Wrap(
            children: _languages
                .map((e) => _buildSkilssCard(_languages.indexOf(e)))
                .toList(),
          ),
        if (_languages.isNotEmpty) SizedBox(height: 30),
        FieldSuggestion<String>(
          search: (item, input) {
            if (languageController.text.isEmpty) return false;
            return item.toLowerCase().contains(input.toLowerCase());
          },
          inputDecoration: InputDecoration(
            hintText: 'Search Language',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
          boxStyle: BoxStyle(
            backgroundColor: scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          inputType: TextInputType.text,
          suggestions: languageList,
          textController: languageController,
          // boxController: boxController, // optional
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(
                  () => _addLanguageField(
                    languageList[index],
                  ),
                );
                languageController.clear();
              },
              child: Card(
                color: scaffoldBackgroundColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    languageList[index],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Submit",
                onPressed: () async {
                  Get.back();
                  widget.onSubmit(_languages);
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
