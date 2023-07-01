import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_bloc.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_event.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_state.dart';
import 'package:cryptonotifier/bloc/navigation/nav_cubit.dart';
import 'package:cryptonotifier/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../colors.dart';

final _colorScheme = ColorSchemeDark();

class AlarmView extends StatelessWidget {
  const AlarmView({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: _AlarmViewStateful());
  }
}

class _AlarmViewStateful extends StatefulWidget {
  const _AlarmViewStateful();

  @override
  State<StatefulWidget> createState() {
    return _AlarmViewState();
  }
}

class _AlarmViewState extends State<_AlarmViewStateful> {
  List<Alarm> alarms = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAlarmBloc, AlarmState>(
      builder: (context, state) {
        if (state is AlarmSavingState) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          );
        } else if (state is AlarmSavingErrorState) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("An error occurred, while saving your settings."),
                Text(state.error)
              ],
            ),
          );
        } else if (state is AlarmEditView) {
          alarms = state.crypto.alarms;
          return Scaffold(
            backgroundColor: _colorScheme.bg1,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: _colorScheme.font,
                          ),
                          onTap: () {
                            BlocProvider.of<NavCubit>(context)
                                .popToCryptoView();
                          },
                        ),
                      ],
                    ),
                    Text(
                      state.crypto.symbol,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _colorScheme.font,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      state.crypto.price,
                      style: TextStyle(
                        fontSize: 16,
                        color: _colorScheme.font,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Alarms:",
                            style: TextStyle(
                              fontSize: 18,
                              color: _colorScheme.font,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: alarms.length,
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Card(
                                  color: _colorScheme.bg2,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              alarms[index].high
                                                  ? Icons.arrow_upward
                                                  : Icons.arrow_downward,
                                              color: _colorScheme.font,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${alarms[index].price_target}\$",
                                              style: TextStyle(
                                                color: _colorScheme.font,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Switch(
                                          value: alarms[index].active,
                                          onChanged: (value) {
                                            setState(() {
                                              alarms[index].active = value;
                                            });
                                            saveToSharedPreferences();
                                          },
                                        )
                                      ],
                                    ),
                                    onTap: () => _expandCard(
                                        context,
                                        index,
                                        alarms[index].price_target,
                                        alarms[index].high,
                                        alarms[index].active),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addCard(state.crypto.symbol);
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }

        return Container();
      },
    );
  }

  void _addCard(String symbol) {
    setState(() {
      alarms.add(Alarm(
          crypto_symbol: symbol, price_target: 0, high: true, active: false));
    });
    _expandCard(context, alarms.length - 1, 0, true, false);
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  void _expandCard(BuildContext context, int index, double target_price,
      bool high, bool active) {
    String price = target_price.toString();
    TextEditingController _textFieldController =
        TextEditingController(text: price);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: _colorScheme.bg2,
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "The price that triggers the notification:",
                      style: TextStyle(
                        color: _colorScheme.font,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: _colorScheme.font,
                        ),
                        decoration: const InputDecoration(
                          hintText: "0.00",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$')),
                        ],
                        controller: _textFieldController,
                        onChanged: (value) => price = value,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'High/Low: ',
                          style: TextStyle(
                            color: _colorScheme.font,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(
                              value: high,
                              onChanged: (bool value) {
                                setState(() {
                                  high = value;
                                });
                              },
                            ),
                            GestureDetector(
                              child: Icon(
                                high
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: _colorScheme.font,
                              ),
                              onTap: () {
                                setState(() {
                                  high = !high;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Active: ',
                          style: TextStyle(
                            color: _colorScheme.font,
                          ),
                        ),
                        Row(
                          children: [
                            Switch(
                              value: active,
                              onChanged: (bool value) {
                                setState(() {
                                  active = value;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: _colorScheme.font,
                    ),
                  ),
                  onPressed: () {
                    alarms[index].price_target = double.parse(price);
                    alarms[index].high = high;
                    alarms[index].active = active;
                    saveToSharedPreferences();
                    refreshView();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: _colorScheme.font,
                    ),
                  ),
                  onPressed: () {
                    alarms.removeAt(index);
                    saveToSharedPreferences();
                    refreshView();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: _colorScheme.font,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      refreshView();
    });
  }

  void refreshView() {
    setState(() {});
  }

  void saveToSharedPreferences() {
    BlocProvider.of<EditAlarmBloc>(context).add(SaveAlarmEvent());
  }
}
