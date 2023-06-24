import 'package:cryptonotifier/bloc/crypto_bloc.dart';
import 'package:cryptonotifier/bloc/crypto_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CryptoNotifier"),
      ),
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          if (state is CryptosLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CryptosLoadedState) {
            return ListView.builder(
              itemCount: state.cryptos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.network(state.cryptos[index].img, height: 48,),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text(state.cryptos[index].symbol),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text(state.cryptos[index].price),
                          ],
                        ),
                      ),
                  ),
                );
              },
            );
          } else if (state is CryptoLoadingError) {
            return Center(
              child: Text(
                state.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
