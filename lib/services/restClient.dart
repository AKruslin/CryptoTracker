import 'package:crypto_tracker/common/coins.dart';
import 'package:dio/dio.dart';

class RestClient {
  static Future<Map<String, dynamic>> getCryptoHistory() async {
    Map<String, dynamic> history = {};
    for (var coin in cryptoCoins) {
      String url =
          'https://api.coincap.io/v2/assets/$coin/history?interval=h12';
      var response = await Dio().get(url);
      history[coin] = await response.data["data"];
    }
    return history;
  }

//api.coincap.io/v2/rates/bitcoin
  static Future<String> getCryptoUSDRate(String coin) async {
    var response = await Dio().get('https://api.coincap.io/v2/rates/$coin');
    return await response.data["data"]["rateUsd"];
  }
}
