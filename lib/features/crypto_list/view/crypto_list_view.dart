import 'dart:async';

import 'package:bloc_crypto/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:bloc_crypto/features/crypto_list/widgets/widgets.dart';
import 'package:bloc_crypto/repositories/crypto_coins/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Crypto Wallet'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TalkerScreen(talker: GetIt.I<Talker>())));
                },
                icon: Icon(Icons.document_scanner_outlined))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white54,
                  ),
                  itemCount: state.coinsList.length,
                  itemBuilder: (context, index) =>
                      CryptoCoinTile(coin: state.coinsList[index]),
                );
              }
              if (state is CryptoListFailure) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'Somthing went wrong',
                        style: theme.textTheme.headlineMedium,
                      ),
                      Text(
                        'Please try aganing later',
                        style:
                            theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          _cryptoListBloc.add(LoadCryptoList());
                        },
                        child: const Text('Try againing'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
