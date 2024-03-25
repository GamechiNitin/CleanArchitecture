import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x1_news/core/utils/calculate_reading_time.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/view/features/news/domain/entities/news.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    super.key,
    required this.news,
  });
  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.share),
          )
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "By ${news.posterName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${news.updateAt?.toLocal().toString().split('.').first} | ${calculateReadingTime(news.content)} min read",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kBlueColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Image.network(
                  news.imageUrl,
                  height: 150,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                news.content * 50,
                style: const TextStyle(height: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
