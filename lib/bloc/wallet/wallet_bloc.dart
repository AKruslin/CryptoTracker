import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/database/cryptoUnitEntity.dart';
import 'package:crypto_tracker/database/cryptoWalletDao.dart';
import 'package:crypto_tracker/services/restClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final CryptoWalletDao databaseDao;
  List<CryptoUnit?> wallet = [];
  WalletBloc({required this.databaseDao}) : super(WalletInitial());

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is CheckWallet) {
      try {
        final walletData = await databaseDao.getCryptoWallet();
        wallet = walletData;
        for (CryptoUnit? ownedCoin in wallet) {
          String usdRate = await RestClient.getCryptoUSDRate(ownedCoin!.id);
          ownedCoin.value = double.parse(usdRate);
        }
      } catch (e) {
        print(e.toString());
      }
      yield (WalletDataFetched(wallet: wallet.reversed.toList()));
    }
    if (event is AddCrypto) {
      String usdRate = await RestClient.getCryptoUSDRate(event.coin);
      double value = double.parse(usdRate);

      databaseDao.insertCryptoUnit(
          CryptoUnit(id: event.coin, value: value, quantity: event.quantity));
      try {
        final walletData = await databaseDao.getCryptoWallet();
        wallet = walletData;
        for (CryptoUnit? ownedCoin in wallet) {
          String usdRate = await RestClient.getCryptoUSDRate(ownedCoin!.id);
          ownedCoin.value = double.parse(usdRate);
        }
      } catch (e) {
        print(e.toString());
      }
      yield (WalletDataFetched(wallet: wallet.reversed.toList()));
    }
  }
}
