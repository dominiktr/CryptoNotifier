import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cryptos/crypto_bloc.dart';
import 'bloc/cryptos/crypto_event.dart';
import 'bloc/cryptos/crypto_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      theme: Theme.of(context).copyWith(colorScheme: theme.colorScheme.copyWith(primary: Colors.black54, secondary: Colors.black87)),
      home: BlocProvider(
        create: (context) => CryptoBloc()..add(LoadCryptoEvent()),
        child: CryptoView(),
      ),
    );
  }
}
