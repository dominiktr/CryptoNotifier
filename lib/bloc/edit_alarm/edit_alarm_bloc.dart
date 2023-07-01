import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_event.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/crypto.dart';

class EditAlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final Crypto crypto;

  EditAlarmBloc({required this.crypto}) : super(AlarmEditView(crypto: crypto)) {
    on<SaveAlarmEvent>((event, emit) {
      //todo
    });
  }
}
