import 'package:crypto_tracker/database/cryptoUnitEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CryptoWalletDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCryptoUnit(CryptoUnit cryptoUnit);

  @Query('SELECT * FROM CryptoUnit')
  Future<List<CryptoUnit?>> getCryptoWallet();

}
