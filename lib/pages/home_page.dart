import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../models/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("exam Bloc"),
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(LoadNewsListEvent()),
        child: NewsList(),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedNewsListState) {
          return viewOfNewsList(false, state.articles);
        } else if (state is HomeErrorState) {
          return Center(child: Text(state.message));
        } else {
          return viewOfNewsList(false, []);
        }
      },
    );
  }

  Widget itemForNews(Article article, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article.title!,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          // Author
          Text(
            article.author! ?? 'Unknown Author',
            style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16.0),
          // Image and Content Row
          if (article.urlToImage != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.urlToImage!,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16.0),
                // Content
                Expanded(
                  child: Text(article.content ?? 'No content available'),
                ),
              ],
            ),
          const SizedBox(height: 16.0),
          // URL
          Text(
            article.url ?? '',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewOfNewsList(bool isLoading, List<Article> articles) {
    return
        ListView.builder(
          itemCount: articles.length,
          itemBuilder: (ctx, index) => itemForNews(articles[index], index));


  }
}
