import 'package:bloc/bloc.dart';
import 'package:mdtestapp/model/response/response_success.dart';
import 'package:mdtestapp/network/account_api.dart';
import 'package:mdtestapp/utils/general_function.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AccountProvider connect = AccountProvider();

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmit>(_onForgotPassword);
  }

  Future<void> _onForgotPassword(
    ForgotPasswordSubmit event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      ResponseSuccess data = await connect.forgotPassword(
        event.apiToken,
        email: event.email,
      );

      emit(ForgotPasswordSuccess(responseData: data));
    } catch (ex) {
      emit(ForgotPasswordError(errorMessage: replaceException(ex.toString())));
    }
  }
}
