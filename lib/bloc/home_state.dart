import 'package:equatable/equatable.dart';
import '../models/model.dart';
import '../servives/http_service.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedNewsListState extends HomeState {
  final List<Article> articles;

  const HomeLoadedNewsListState(this.articles);

  @override
  List<Object> get props => [articles];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
