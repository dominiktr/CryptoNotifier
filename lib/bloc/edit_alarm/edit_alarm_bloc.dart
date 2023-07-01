import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_event.dart';
import 'package:cryptonotifier/bloc/edit_alarm/edit_alarm_state.dart';
import 'package:cryptonotifier/repos/preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/crypto.dart';

class EditAlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final Crypto crypto;
  final preferencesService = PreferencesService();

  EditAlarmBloc({required this.crypto}) : super(AlarmEditView(crypto: crypto)) {
    on<SaveAlarmEvent>((event, emit) {
      try {
        emit(AlarmSavingState());
        preferencesService.save(crypto.alarms);
        emit(AlarmEditView(crypto: crypto));
      } catch (e) {
        emit(AlarmSavingErrorState(error: e.toString()));
      }
    });
  }
}
