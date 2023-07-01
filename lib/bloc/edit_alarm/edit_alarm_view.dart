import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_bloc.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_state.dart';
import 'package:cryptonotifier/bloc/navigation/nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../colors.dart';

final _colorScheme = ColorSchemeDark();

class AlarmView extends StatelessWidget {
  const AlarmView({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: _AlarmViewStateful());
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAlarmBloc, AlarmState>(
      builder: (context, state) {
        if (state is AlarmEditView) {
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
                          itemCount: state.crypto.alarms.length,
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
                                              state.crypto.alarms[index].high
                                                  ? Icons.arrow_upward
                                                  : Icons.arrow_downward,
                                              color: _colorScheme.font,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${state.crypto.alarms[index].price_target}\$",
                                              style: TextStyle(
                                                color: _colorScheme.font,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Switch(
                                          value:
                                              state.crypto.alarms[index].active,
                                          onChanged: (value) {
                                            setState(() {
                                              state.crypto.alarms[index]
                                                  .active = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
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
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }

        return Container();
      },
    );
  }
}
