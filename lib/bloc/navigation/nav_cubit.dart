import 'package:cryptonotifier/models/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavCubit extends Cubit<Crypto?> {
  NavCubit() : super(null);

  void showAlarmEditView(Crypto crypto) => emit(crypto);

  void popToCryptoView() => emit(null);
}