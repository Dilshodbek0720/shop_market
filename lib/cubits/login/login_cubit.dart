import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_market/data/repository/login_repository.dart';
import '../../data/models/status/form_status.dart';
import '../../data/models/universal_data.dart';
import '../../utils/ui_utils/loading_dialog.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepository) : super(const LoginState());

  final LoginRepository loginRepository;


  // Future<void> logOutUser() async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //   UniversalData data = await authRepository.logOutUser();
  //   if (data.error.isEmpty) {
  //     emit(state.copyWith(status: FormStatus.unauthenticated));
  //   } else {
  //     emit(
  //       state.copyWith(
  //         status: FormStatus.failure,
  //         statusMessage: data.error,
  //       ),
  //     );
  //   }
  // }

  // Future<void> signUp(context) async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //   showLoading(context: context);
  //   UniversalData data = await authRepository.signUpUser(
  //       email: "${state.phoneNumber}@gmail.com",
  //       password: "123456"
  //   );
  //   hideLoading(context: context);
  //   if (data.error.isEmpty) {
  //     emit(state.copyWith(status: FormStatus.authenticated));
  //   } else {
  //     emit(
  //       state.copyWith(
  //         status: FormStatus.failure,
  //         statusMessage: data.error,
  //       ),
  //     );
  //   }
  //   emit(state.copyWith(status: FormStatus.pure));
  // }

  Future<void> logIn({required BuildContext context, required String username, required String password}) async {
    emit(state.copyWith(status: FormStatus.loading));
    showLoading(context: context);
    UniversalData data = await loginRepository.loginUser(
        username: username,
        password: password,
    );
    if(context.mounted){
      hideLoading(context: context);
    }
    if (data.data) {
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }
}