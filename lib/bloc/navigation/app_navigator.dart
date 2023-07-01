import 'package:cryptonotifier/bloc/cryptos/crypto_view.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_bloc.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_view.dart';
import 'package:cryptonotifier/bloc/navigation/nav_cubit.dart';
import 'package:cryptonotifier/models/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, Crypto?>(
      builder: (context, state) {
        return Navigator(
          pages: [
            MaterialPage(child: CryptoView()),
            if (state != null) MaterialPage(child: BlocProvider<EditAlarmBloc>(create: (context) => EditAlarmBloc(crypto: state), child: AlarmView())),
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToCryptoView();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
