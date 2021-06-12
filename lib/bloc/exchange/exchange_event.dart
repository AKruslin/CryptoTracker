part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeEvent {}

class CalculateQuantity extends ExchangeEvent {
  final String from;
  final String to;
  final String quantity;

  CalculateQuantity(
    this.from,
    this.to,
    this.quantity,
  );
}
