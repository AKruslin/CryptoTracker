part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class FetchWalletData extends WalletState {}

class WalletDataFetched extends WalletState {
  final List<CryptoUnit?> wallet;
  WalletDataFetched({required this.wallet});
}
