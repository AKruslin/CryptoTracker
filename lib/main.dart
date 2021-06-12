import 'package:crypto_tracker/bloc/exchange/exchange_bloc.dart';
import 'package:crypto_tracker/bloc/home/home_bloc.dart';
import 'package:crypto_tracker/bloc/wallet/wallet_bloc.dart';
import 'package:crypto_tracker/common/appColors.dart';
import 'package:crypto_tracker/database/cryptoWalletDB.dart';
import 'package:crypto_tracker/database/cryptoWalletDao.dart';
import 'package:crypto_tracker/screens/exchange.dart';
import 'package:crypto_tracker/screens/home.dart';
import 'package:crypto_tracker/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('cryptotracker.db').build();
  final dao = database.cryptoWalletDao;
  runApp(CryptoTracker(walletDao: dao));
}

class CryptoTracker extends StatefulWidget {
  final CryptoWalletDao walletDao;

  const CryptoTracker({Key? key, required this.walletDao}) : super(key: key);
  @override
  _CryptoTrackerState createState() => _CryptoTrackerState();
}

class _CryptoTrackerState extends State<CryptoTracker> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WalletScreen(),
    ExchangeScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider<WalletBloc>(
          create: (BuildContext context) =>
              WalletBloc(databaseDao: widget.walletDao),
        ),
        BlocProvider<ExchangeBloc>(
          create: (BuildContext context) => ExchangeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'CryptoTracker',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
        ),
        home: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text("CryptoTracker"),
            centerTitle: true,
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: "Wallet",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sync_alt),
                label: "Exchange",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
