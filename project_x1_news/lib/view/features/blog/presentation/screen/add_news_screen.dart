import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x1_news/core/utils/pick_image.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/utils/dimens.dart';
import 'package:project_x1_news/view/widget/button_widget.dart';
import 'package:project_x1_news/view/widget/news_field_widget.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  List<String> generList = ["Tech", "Auto", "Entertainment", "Sports"];
  List<String> selectedGenersList = [];
  TextEditingController contentController = TextEditingController();

  TextEditingController headlineController = TextEditingController();
  FocusNode headlineFn = FocusNode();
  FocusNode contentFn = FocusNode();

  String? headlineErrorText;
  String? contentErrorText;
  File? seletedImage;

  void selectImage() async {
    seletedImage = await GetImage.pickImage();
    _notify();
  }

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool obscureText = true;

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    contentFn.unfocus();
    contentController.clear();
    headlineController.clear();
    headlineFn.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.check_mark),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                selectImage();
              },
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: seletedImage != null
                    ? Image.file(
                        seletedImage!,
                        fit: BoxFit.cover,
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.camera,
                            size: 50,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "Select your image",
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  generList.length,
                  (index) {
                    bool isSelected = false;
                    if (selectedGenersList.contains(generList[index])) {
                      isSelected = true;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedGenersList.remove(generList[index]);
                          } else {
                            selectedGenersList.add(generList[index]);
                          }
                          _notify();
                        },
                        child: Chip(
                          label: Text(
                            generList[index],
                            style: TextStyle(
                                color: isSelected ? kWhiteColor : null),
                          ),
                          padding: const EdgeInsets.all(8),
                          color: isSelected
                              ? const MaterialStatePropertyAll(Colors.pink)
                              : null,
                          side: isSelected
                              ? BorderSide.none
                              : const BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    );
                  },
                )..toList(),
              ),
            ),
            const SizedBox(height: 20),
            NewsFieldWidget(
              maxLines: 2,
              minLines: 2,
              textInputAction: TextInputAction.next,
              controller: headlineController,
              focusNode: headlineFn,
              label: 'Headline ',
              hint: 'Enter Headline',
              errorText: headlineErrorText,
              onEditingComplete: () {
                if (headlineController.text.isEmpty) {
                  headlineErrorText = 'Enter the Headline';
                } else {
                  headlineErrorText = null;
                }
                _notify();
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  headlineErrorText = 'Enter the Email Id';
                  return headlineErrorText;
                } else {
                  headlineErrorText = null;
                  return headlineErrorText;
                }
              },
              onChanged: (val) {
                if (val.isEmpty) {
                  headlineErrorText = 'Enter the Headline';
                } else {
                  headlineErrorText = null;
                }
                _notify();
              },
            ),
            const SizedBox(height: 20),
            NewsFieldWidget(
              minLines: 4,
              maxLines: 10,
              textInputAction: TextInputAction.next,
              controller: contentController,
              focusNode: contentFn,
              label: 'Content ',
              hint: 'Enter content',
              errorText: contentErrorText,
              onEditingComplete: () {
                if (contentController.text.isEmpty) {
                  contentErrorText = 'Enter the content';
                } else {
                  contentErrorText = null;
                }
                _notify();
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  contentErrorText = 'Enter the Email Id';
                  return contentErrorText;
                } else {
                  contentErrorText = null;
                  return contentErrorText;
                }
              },
              onChanged: (val) {
                if (val.isEmpty) {
                  contentErrorText = 'Enter the content';
                } else {
                  contentErrorText = null;
                }
                _notify();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonWidget(
        margin: const EdgeInsets.all(textFieldPadding),
        text: 'Submit',
        onTap: () {
          // passwordFn.unfocus();
          _formKey.currentState?.validate();
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            // context.read<AuthBloc>().add(
            //       AuthSignInEvent(
            //         email: emailIdController.text.trim(),
            //         password: passwordController.text.trim(),
            //       ),
            //     );
          }
        },
      ),
    );
  }
}
