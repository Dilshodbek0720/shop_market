part of 'client_order_bloc.dart';

@immutable
abstract class ClientOrderEvent {}

class GetClientOrderEvent extends ClientOrderEvent {}

class AddClientOrderEvent extends ClientOrderEvent {
  final ClientOrderModel clientOrderModel;

  AddClientOrderEvent({required this.clientOrderModel});
}

class UpdateClientOrderEvent extends ClientOrderEvent {
  final ClientOrderModel clientOrderModel;

  UpdateClientOrderEvent({required this.clientOrderModel});
}

class DeleteClientOrderEvent extends ClientOrderEvent {
  final int clientOrderId;

  DeleteClientOrderEvent({required this.clientOrderId});
}
class GetClientOrderByIdEvent extends ClientOrderEvent {
  final int clientOrderId;

  GetClientOrderByIdEvent({required this.clientOrderId});
}