import 'package:bloc/bloc.dart';
import 'package:mdtestapp/model/response/response_success.dart';
import 'package:mdtestapp/network/account_api.dart';
import 'package:mdtestapp/utils/general_function.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountProvider _connect;

  RegisterBloc({AccountProvider? connect})
    : _connect = connect ?? AccountProvider(),
      super(RegisterInitial()) {
    on<RegisterSubmit>(_onRegister);
  }

  Future<void> _onRegister(
    RegisterSubmit event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final ResponseSuccess data = await _connect.register(
        event.apiToken,
        request: event.request,
      );
      emit(RegisterSuccess(responseData: data));
    } catch (ex) {
      emit(RegisterError(errorMessage: replaceException(ex.toString())));
    }
  }
}
