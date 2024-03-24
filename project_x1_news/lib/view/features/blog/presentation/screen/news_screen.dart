import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x1_news/view/features/blog/presentation/widget/news_card_widget.dart';

import 'add_news_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddNewsScreen(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => const NewsCardWidget(),
      ),
    );
  }
}
