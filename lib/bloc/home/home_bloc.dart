import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/services/restClient.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is DownloadHistoryData) {
      try {
      Map<String, dynamic> historyData = await RestClient.getCryptoHistory();
      yield HistoryDownloaded(history: historyData);
        
      } catch (e) {
        yield ConnectionError();
      }
    }
  }
}
