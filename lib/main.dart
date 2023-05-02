import 'dart:async';

import 'package:bloc_crypto/crypto_coins_list_app.dart';
import 'package:bloc_crypto/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'repositories/crypto_coins/crypto_coin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseHeaders: true,
        printRequestHeaders: true,
        printResponseMessage: true,
        printResponseData: false,
      ),
    ),
  );
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(dio: dio));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
  );

  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    GetIt.I<Talker>().handle(exception, stackTrace);
    return true;
  };

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
  runZonedGuarded(() => runApp(const CryptoCoinsListApp()), (error, stack) {
    GetIt.I<Talker>().handle(error, stack);
  });
}
