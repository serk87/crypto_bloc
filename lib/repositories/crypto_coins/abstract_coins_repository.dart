import 'package:bloc_crypto/repositories/crypto_coins/models/models.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoins();
  Future<CryptoCoinDetail> getDetail({required String currencyCode});
}
