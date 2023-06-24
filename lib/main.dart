import 'package:cryptonotifier/bloc/crypto_bloc.dart';
import 'package:cryptonotifier/bloc/crypto_event.dart';
import 'package:cryptonotifier/bloc/crypto_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BlocProvider(create: (context) => CryptoBloc()..add(LoadCryptoEvent()), child: CryptoView(),),);
  }
}