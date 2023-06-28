import 'package:cryptonotifier/bloc/crypto_bloc.dart';
import 'package:cryptonotifier/bloc/crypto_state.dart';
import 'package:data_table_2/data_table_2.dart';
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
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: DataTable2(
                  columnSpacing: 10,
                  horizontalMargin: 10,
                  minWidth: 298,
                  columns: const [
                    DataColumn2(
                      label: Text("#"),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text("Name"),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text("Price (USD)"),
                      size: ColumnSize.L,
                      numeric: true,
                    ),
                    DataColumn2(
                      label: Text("Alert"),
                      size: ColumnSize.S,
                      numeric: true,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                      state.cryptos.length,
                      (index) => DataRow(cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    state.cryptos[index].img,
                                    height: 32,
                                  ),
                                  const Padding(padding: EdgeInsets.all(3)),
                                  Text(state.cryptos[index].symbol),
                                ],
                              ),
                            ),
                            DataCell(Text(state.cryptos[index].price)),
                            DataCell(Icon(state.cryptos[index].alarms.isEmpty ? Icons.alarm_off : Icons.alarm_on)),
                          ]))),
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
