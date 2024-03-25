import 'package:flutter/material.dart';
import 'package:project_x1_news/core/utils/calculate_reading_time.dart';
import 'package:project_x1_news/utils/app_colors.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    super.key,
    this.content,
    this.color,
    this.topic,
    this.title,
  });
  final String? content;
  final String? title;
  final List<String>? topic;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: kG1Color,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (topic != null && topic!.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        topic!.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Chip(
                                label: Text(
                                  topic![index],
                                  style: const TextStyle(color: kWhiteColor),
                                ),
                                padding: const EdgeInsets.all(8),
                                color: const MaterialStatePropertyAll(
                                    Colors.black),
                                side: BorderSide.none,
                              ),
                            ),
                          );
                        },
                      )..toList(),
                    ),
                  ),
                Text(
                  title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: kWhiteColor,
                  ),
                ),
                Text(
                  content ?? "",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (content != null)
            Text(
              "${calculateReadingTime(content!)} min",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
