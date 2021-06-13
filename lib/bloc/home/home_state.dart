part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HistoryDownloaded extends HomeState {
  final Map<String, dynamic> history;
  HistoryDownloaded({required this.history});
}

class ConnectionError extends HomeState {}
