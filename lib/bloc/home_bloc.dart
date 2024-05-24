import 'dart:async';
import 'package:bloc/bloc.dart';
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

    try {
      var response = await NewsService().fetchTopHeadlines();
      if (response != null) {
        articlesList.addAll(response);
        currentPage++;
        emit(HomeLoadedNewsListState(articlesList));
      } else {
        emit(HomeErrorState("Failed to fetch news"));
      }
    } catch (e) {
      emit(HomeErrorState("An error occurred while fetching news"));
    }
  }
}
