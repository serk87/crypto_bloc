part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinDetailEvent extends Equatable {
  const CryptoCoinDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadCryptoCoinDetail extends CryptoCoinDetailEvent {
  const LoadCryptoCoinDetail({
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  List<Object> get props => super.props..add(currencyCode);
}
