import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/services/restClient.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial());
  double oldQuantity = 0;
  String fromCoin = "bitcoin";
  String toCoin = "ethereum";

  @override
  Stream<ExchangeState> mapEventToState(
    ExchangeEvent event,
  ) async* {
    if (event is CalculateQuantity) {
      var from = await RestClient.getCryptoUSDRate(event.from);
      var to = await RestClient.getCryptoUSDRate(event.to);
      oldQuantity = double.parse(event.quantity);
      double newQuantity =
          (double.parse(from) * oldQuantity) / double.parse(to);
      yield NewQuantity(newQuantity.toStringAsFixed(5));
    }
  }
}
