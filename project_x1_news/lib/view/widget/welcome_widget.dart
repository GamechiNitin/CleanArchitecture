import 'package:flutter/material.dart';
import 'package:project_x1_news/utils/app_assets.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/utils/app_decoration.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: DashDecoration.kNueShadowDecoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: Image.asset(
              DashAssets.logo,
              height: MediaQuery.of(context).size.width / 3.8,
              width: MediaQuery.of(context).size.width / 3.8,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: kPrimaryColor,
          highlightColor: kBlueColor,
          child: Text(
            "Welcome to Flutter News!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: kBlueColor,
                  fontSize: 25,
                ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
