import 'package:flutter/material.dart';
import 'package:mad/controller/firebase_firestore_db_controller.dart';
import 'package:mad/model/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading = true;
  List<News> newsItemsList = [];

  @override
  void initState() {
    super.initState();
    _loadNewsList();
  }

  Future<void> _loadNewsList() async {
    final firestoreController = FirebaseFirestoreDBController();
    final newsList = await firestoreController.getData(
      FirebaseFirestoreDBController.newsCollectionPath,
    );
    print("News List : ${newsList}");
    List<News> newsLists = newsList.map((i) => News.fromMap(i)).toList();
    setState(() {
      _isLoading = false;
      newsItemsList = newsLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("News", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (s) {
                  print("Query : $s");
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(newsItemsList.length, (
                    int index,
                  ) {
                    final news = newsItemsList[index];
                    return ListTile(
                      title: Text("${news.title}"),
                      onTap: () {
                        setState(() {
                          controller.closeView(news.title);
                        });
                      },
                    );
                  });
                },
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : newsItemsList.length == 0
              ? Center(child: Text("No Data"))
              : Expanded(
                  child: ListView.separated(
                    itemCount: newsItemsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final news = newsItemsList[index];
                      return ListTile(
                        leading: Icon(Icons.newspaper),
                        trailing: Icon(Icons.navigate_next),
                        title: Text(
                          "${news.title!.length >= 50 ? news.title!.substring(0, 50) + "..." : news.title}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${news.content!.length >= 100 ? news.content!.substring(0, 100) + "..." : news.content}",
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
