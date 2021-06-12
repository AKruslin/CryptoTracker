// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptoWalletDB.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CryptoWalletDao? _cryptoWalletDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CryptoUnit` (`id` TEXT NOT NULL, `value` REAL NOT NULL, `quantity` REAL NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CryptoWalletDao get cryptoWalletDao {
    return _cryptoWalletDaoInstance ??=
        _$CryptoWalletDao(database, changeListener);
  }
}

class _$CryptoWalletDao extends CryptoWalletDao {
  _$CryptoWalletDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _cryptoUnitInsertionAdapter = InsertionAdapter(
            database,
            'CryptoUnit',
            (CryptoUnit item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'quantity': item.quantity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CryptoUnit> _cryptoUnitInsertionAdapter;

  @override
  Future<List<CryptoUnit?>> getCryptoWallet() async {
    return _queryAdapter.queryList('SELECT * FROM CryptoUnit',
        mapper: (Map<String, Object?> row) => CryptoUnit(
            id: row['id'] as String,
            value: row['value'] as double,
            quantity: row['quantity'] as double));
  }

  @override
  Future<void> insertCryptoUnit(CryptoUnit cryptoUnit) async {
    await _cryptoUnitInsertionAdapter.insert(
        cryptoUnit, OnConflictStrategy.replace);
  }
}
