import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/common/widget/loader.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/view/features/news/presentation/bloc/news_bloc.dart';
import 'package:project_x1_news/view/features/news/presentation/widget/news_card_widget.dart';
import 'add_news_screen.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(GetNewsListEvent());
  }

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
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          switch (state) {
            case LoadingNews():
              return const LoadingWidget();
            case NewsListDataState():
              if (state.data.isEmpty) {
                return const Center(child: Text('No Data'));
              } else {
                return ListView.separated(
                  itemCount: state.data.length,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) => GestureDetector(
                    child: NewsCardWidget(
                      content: state.data[index].content,
                      topic: state.data[index].topic,
                      title: state.data[index].title,
                      color: kSecondaryColor,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            news: state.data[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
