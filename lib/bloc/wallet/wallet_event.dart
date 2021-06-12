part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class CheckWallet extends WalletEvent{}

class AddCrypto extends WalletEvent{
  final String coin;
  final double quantity;

  AddCrypto(this.coin, this.quantity);
}