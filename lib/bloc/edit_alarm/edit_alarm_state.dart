import '../../models/crypto.dart';

abstract class AlarmState {}

class AlarmEditView extends AlarmState {
  final Crypto crypto;

  AlarmEditView({required this.crypto});
  
}

class AlarmSavingState extends AlarmState {}

class AlarmSavingErrorState extends AlarmState {
  final String error;

  AlarmSavingErrorState({required this.error});
}