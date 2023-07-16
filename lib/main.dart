import 'package:cryptonotifier/bloc/navigation/app_navigator.dart';
import 'package:cryptonotifier/bloc/navigation/nav_cubit.dart';
import 'package:cryptonotifier/repos/background_service.dart';
import 'package:cryptonotifier/repos/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cryptos/crypto_bloc.dart';
import 'bloc/cryptos/crypto_event.dart';

void main() {
  runApp(const MyApp());
  NotificationService().initNotifications(channelKey: 'CryptoPriceCK', channelName: 'CryptoPriceAlert', channelDescription: 'CryptoPriceAlert');
  registerBackgroundTask();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.black54, secondary: Colors.black87)),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavCubit()),
          BlocProvider(
            create: (context) => CryptoBloc()..add(LoadCryptoEvent()),
          ),
        ],
        child: AppNavigator(),
      ),
    );
  }
}
