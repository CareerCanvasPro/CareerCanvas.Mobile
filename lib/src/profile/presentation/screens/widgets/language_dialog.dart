import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageAddDialog extends StatefulWidget {
  final List<KeyVal>? existingLanguages;
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
      _languages.addAll(widget.existingLanguages!.map((e) => e.name).toList());
    }
  }

  // Method to add a new skills field
  void _addLanguageField(String languge) {
    if (_languages.contains(languge)) {
      return;
    }
    setState(() {
      _languages.add(languge);
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
  Widget _buildSkilssCard(
    int index, {
    bool isSuggested = false,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isSuggested
            ? _addLanguageField(languageList[index])
            : _removeSkilssField(index);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 50,
        ),
        decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSuggested ? Colors.black : primaryBlue,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isSuggested ? languageList[index] : _languages[index],
              style: getCTATextStyle(
                context,
                12,
                color: isSuggested ? Colors.black : primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
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
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryBlue,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Languages",
                        style: getCTATextStyle(
                          context,
                          16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Update your languages",
                  textAlign: TextAlign.left,
                  style: getCTATextStyle(
                    context,
                    12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // if (_languages.isNotEmpty)
          //   Wrap(
          //     children: _languages
          //         .map((e) => _buildSkilssCard(_languages.indexOf(e)))
          //         .toList(),
          //   ),
          // if (_languages.isNotEmpty) SizedBox(height: 30),
          // FieldSuggestion<String>(
          //   search: (item, input) {
          //     if (languageController.text.isEmpty) return false;
          //     return item.toLowerCase().contains(input.toLowerCase());
          //   },
          //   inputDecoration: InputDecoration(
          //     hintText: 'Search Language',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(32.0),
          //       borderSide: BorderSide(color: Colors.grey.shade300),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(32.0),
          //       borderSide: BorderSide(color: Colors.grey.shade500),
          //     ),
          //     contentPadding: const EdgeInsets.symmetric(
          //       horizontal: 24,
          //       vertical: 12,
          //     ),
          //   ),
          //   boxStyle: BoxStyle(
          //     backgroundColor: scaffoldBackgroundColor,
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   inputType: TextInputType.text,
          //   suggestions: languageList,
          //   textController: languageController,
          //   // boxController: boxController, // optional
          //   itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: () {
          //         setState(
          //           () => _addLanguageField(
          //             languageList[index],
          //           ),
          //         );
          //         languageController.clear();
          //       },
          //       child: Card(
          //         color: scaffoldBackgroundColor,
          //         elevation: 2,
          //         child: Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: Text(
          //             languageList[index],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: FieldSuggestion<String>(
                          search: (item, input) {
                            if (languageController.text.isEmpty) return false;
                            return item
                                .toLowerCase()
                                .contains(input.toLowerCase());
                          },
                          inputDecoration: InputDecoration(
                            hintText: 'Language (ex: English)',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFfb0102),
                              ),
                            ),
                            errorMaxLines: 1,
                            // errorText: '',
                            errorStyle: TextStyle(
                              fontSize: 0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
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
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 50,
                                ),
                                decoration: BoxDecoration(
                                  color: scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      languageList[index],
                                      style: getCTATextStyle(
                                        context,
                                        12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (_languages.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Languages",
                                style: getCTATextStyle(
                                  context,
                                  14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _languages
                                    .map((e) =>
                                        _buildSkilssCard(_languages.indexOf(e)))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suggested Languages",
                              style: getCTATextStyle(
                                context,
                                14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: languageList
                                          .where((skill) =>
                                              _languages.isEmpty ||
                                              !_languages.contains(skill))
                                          .length >
                                      5
                                  ? languageList
                                      .where((skill) =>
                                          _languages.isEmpty ||
                                          !_languages.contains(skill))
                                      .take(5)
                                      .toList()
                                      .map(
                                        (e) => _buildSkilssCard(
                                          languageList.indexOf(e),
                                          isSuggested: true,
                                        ),
                                      )
                                      .toList()
                                  : languageList
                                      .where((skill) =>
                                          _languages.isEmpty ||
                                          !_languages.contains(skill))
                                      .map(
                                        (e) => _buildSkilssCard(
                                          languageList.indexOf(e),
                                          isSuggested: true,
                                        ),
                                      )
                                      .toList(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
                          Get.back();
                          widget.onSubmit(_languages);
                        },
                        backgroundColor: primaryBlue,
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
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
