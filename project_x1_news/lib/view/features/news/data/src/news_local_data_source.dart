import 'package:project_x1_news/view/features/news/data/model/news_model.dart';
import 'package:hive/hive.dart';

abstract interface class NewsLocalDataSource {
  void saveNews(List<NewsModel> newsModel);

  List<NewsModel> getNewsListDataLocal();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final Box box;

  NewsLocalDataSourceImpl(this.box);
  @override
  List<NewsModel> getNewsListDataLocal() {
    List<NewsModel> data = [];
    box.read(() {
      for (var i = 0; i < box.length; i++) {
        data.add(NewsModel.fromJson(box.get('$i')));
      }
    });
    return data;
  }

  @override
  void saveNews(List<NewsModel> newsModel) {
    box.clear();
    box.write(() {
      for (var i = 0; i < newsModel.length; i++) {
        box.put("$i", newsModel[i]);
      }
    });
  }
}
