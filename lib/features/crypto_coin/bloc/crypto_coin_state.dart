part of 'crypto_coin_bloc.dart';

class CryptoCoinDetailState extends Equatable {
  const CryptoCoinDetailState();

  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailInitial extends CryptoCoinDetailState {
  const CryptoCoinDetailInitial();

  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoading extends CryptoCoinDetailState {
  const CryptoCoinDetailLoading();

  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoaded extends CryptoCoinDetailState {
  const CryptoCoinDetailLoaded({required this.coinsDetail});

  final CryptoCoinDetail coinsDetail;
}

class CryptoCoinDetailFailure extends CryptoCoinDetailState {
  const CryptoCoinDetailFailure({this.exception});
  final Object? exception;
}
