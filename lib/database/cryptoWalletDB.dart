
import 'dart:async';

import 'package:crypto_tracker/database/cryptoUnitEntity.dart';
import 'package:crypto_tracker/database/cryptoWalletDao.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'cryptoWalletDB.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CryptoUnit])
abstract class AppDatabase extends FloorDatabase {
  CryptoWalletDao get cryptoWalletDao;
}