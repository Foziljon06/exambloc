import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../servives/http_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News App with BLoC"),
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(LoadNewsListEvent()),
        child: NewsList(),
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: MaterialButton(
          onPressed: () {
            // Ikinchi sahifaga o'tish kodi bu yerda bo'ladi
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Icon(Icons.add, color: Colors.white),
          color: Colors.orange,
        ),
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
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedNewsListState) {
          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (ctx, index) {
              return itemForNews(state.articles[index]);
            },
          );
        } else if (state is HomeErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No articles found'));
        }
      },
    );
  }

  Widget itemForNews(Article article) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              article.urlToImage != null
                  ? Image.network(
                article.urlToImage,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              )
                  : Container(width: 100, height: 100, color: Colors.grey),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  article.description ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              // Bunday yerda yangiliklar sahifasiga o'tish uchun kod bo'lishi mumkin
            },
            child: Text(
              article.url,
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

