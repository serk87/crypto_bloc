import 'dart:async';

import 'package:bloc_crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:bloc_crypto/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }
        Future.delayed(const Duration(milliseconds: 100));
        final coinsList = await coinsRepository.getCoins();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e, st) {
        emit(CryptoListFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
    @override
    void onError(Object error, StackTrace stackTrace) {
      super.onError(error, stackTrace);
      GetIt.I<Talker>().handle(error, stackTrace);
    }
  }

  final AbstractCoinsRepository coinsRepository;
}
