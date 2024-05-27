import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/model.dart';
import '../servives/http_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Article> articlesList = [];
  int currentPage = 1;

  HomeBloc() : super(HomeInitialState()) {
    on<LoadNewsListEvent>(_onLoadNewsListEvent);
  }

  Future<void> _onLoadNewsListEvent(
      LoadNewsListEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoadingState());
    var response = await Network.GET(Network.API_GET_INFOS, Network.paramsArticle());
    if (response != null) {
      articlesList= Network.parseArticles(response);

      emit(HomeLoadedNewsListState(articlesList));
    } else {
      emit(HomeErrorState("Failed to fetch news"));
    }

    // try {
    //   var response = await Network.GET(Network.API_GET_INFOS, Network.paramsArticle());
    //   if (response != null && response.isNotEmpty) {
    //     var users = Network.parseArticles(response);
    //     currentPage++;
    //     articlesList.addAll(users);
    //     print(articlesList.length);
    //     emit(HomeLoadedNewsListState(articlesList));
    //   } else {
    //     emit(HomeErrorState("Failed to fetch news"));
    //   }
    // } catch (e) {
    //   emit(HomeErrorState("An error occurred while fetching news: $e"));
    // }
  }
}
