part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = '',
    this.status = FormStatus.pure,
    this.statusMessage = "",
  });

  final String phoneNumber;
  final FormStatus status;
  final String statusMessage;

  LoginState copyWith({
    String? phoneNumber,
    String? statusMessage,
    FormStatus? status,
  }) =>
      LoginState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  @override
  String toString() {
    return '''
    UserAge:$phoneNumber
    Status:$status
    ''';
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    status,
    statusMessage,
  ];
}