import 'package:crypto_tracker/bloc/home/home_bloc.dart';
import 'package:crypto_tracker/common/coins.dart';
import 'package:crypto_tracker/widgets/coinChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(DownloadHistoryData());
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HistoryDownloaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: cryptoCoins.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 10),
                  child: MyChartWidget(
                    data: state.history[cryptoCoins[index]],
                    coin: cryptoCoins[index],
                  ),
                ),
              ),
            );
          }
          if (state is ConnectionError) {
            return Expanded(
              child: Center(
                child: Text("Please check your internet connection."),
              ),
            );
          }
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        })
      ],
    );
  }
}
