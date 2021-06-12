part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeState {}

class ExchangeInitial extends ExchangeState {}

class NewQuantity extends ExchangeState {
  final String quantity;

  NewQuantity(this.quantity);
}
