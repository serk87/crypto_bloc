import 'package:bloc_crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:bloc_crypto/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:bloc_crypto/repositories/crypto_coins/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinDetailBloc
    extends Bloc<CryptoCoinDetailEvent, CryptoCoinDetailState> {
  CryptoCoinDetailBloc(this.coinsRepository)
      : super(const CryptoCoinDetailInitial()) {
    on<LoadCryptoCoinDetail>(_load);
  }

  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(
      LoadCryptoCoinDetail event, Emitter<CryptoCoinDetailState> state) async {
    try {
      if (state is! CryptoCoinDetailLoading) {
        emit(const CryptoCoinDetailLoading());
      }
      final coinDetails =
          await coinsRepository.getDetail(currencyCode: event.currencyCode);
      emit(CryptoCoinDetailLoaded(coinsDetail: coinDetails));
    } catch (e, st) {
      emit(CryptoCoinDetailFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
