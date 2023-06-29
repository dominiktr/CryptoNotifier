import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors.dart';
import '../../models/crypto.dart';
import 'crypto_bloc.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoView extends StatelessWidget {
  final _colorScheme = ColorSchemeDark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorScheme.bg1,
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SafeArea(
          child: Column(
            children: <Widget>[
             Text(
                'CryptoNotifier',
                style: TextStyle(
                  color: _colorScheme.font,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Card(
                  color: _colorScheme.bg2,
                  child: BlocBuilder<CryptoBloc, CryptoState>(
                    builder: (context, state) {
                      if (state is CryptosLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CryptosLoadedState) {
                        return RefreshIndicator(
                          onRefresh: () async =>
                              BlocProvider.of<CryptoBloc>(context)
                                  .add(LoadCryptoEvent()),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: DataTable2(
                                columnSpacing: 10,
                                horizontalMargin: 10,
                                minWidth: 298,
                                columns: [
                                  DataColumn2(
                                    label: Text(
                                      "#",
                                      style: TextStyle(
                                        color: _colorScheme.font,
                                      ),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      "Name",
                                      style: TextStyle(
                                        color: _colorScheme.font,
                                      ),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      "Price (USD)",
                                      style: TextStyle(
                                        color: _colorScheme.font,
                                      ),
                                    ),
                                    size: ColumnSize.L,
                                    numeric: true,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      "Alert",
                                      style: TextStyle(
                                        color: _colorScheme.font,
                                      ),
                                    ),
                                    size: ColumnSize.S,
                                    numeric: true,
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    state.cryptos.length,
                                    (index) => DataRow(
                                            onLongPress: () => _showEditAlarm(
                                                context, state.cryptos[index]),
                                            cells: [
                                              DataCell(Text(
                                                (index + 1).toString(),
                                                style: TextStyle(
                                                  color: _colorScheme.font,
                                                ),
                                              )),
                                              DataCell(
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      state.cryptos[index].img,
                                                      height: 32,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(3)),
                                                    Text(state
                                                        .cryptos[index].symbol, style: TextStyle(
                  color: _colorScheme.font,),),
                                                  ],
                                                ),
                                              ),
                                              DataCell(Text(
                                                state.cryptos[index].price,
                                                style: TextStyle(
                                                  color: _colorScheme.font,
                                                ),
                                              )),
                                              DataCell(
                                                Icon(state.cryptos[index].alarms
                                                        .isEmpty
                                                    ? Icons.alarm_off
                                                    : Icons.alarm_on, color: _colorScheme.font),
                                                onTap: () => _showEditAlarm(
                                                    context,
                                                    state.cryptos[index]),
                                              ),
                                            ]))),
                          ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditAlarm(BuildContext context, Crypto crypto) {}
}
