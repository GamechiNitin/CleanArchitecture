import 'package:flutter/cupertino.dart';
import 'package:project_x1_news/utils/app_colors.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: kPrimaryColor),
      ),
      child: const Column(
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
    );
  }
}
