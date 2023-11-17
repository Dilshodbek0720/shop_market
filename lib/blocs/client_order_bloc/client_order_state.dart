part of 'client_order_bloc.dart';

class ClientOrderStates extends Equatable {
  final List<ClientOrderModel> clientOrders;
  final ClientOrderModel clientOrderModel;
  final FormStatus status;

  const ClientOrderStates({
    required this.clientOrders,
    required this.clientOrderModel,
    required this.status,
  });

  @override
  List<Object?> get props => [
    clientOrderModel,
    status,
    clientOrders
  ];

  ClientOrderStates copyWith({
    ClientOrderModel? clientOrderModel,
    FormStatus? status,
    List<ClientOrderModel>? clientOrders,
  }) {
    return ClientOrderStates(
      clientOrderModel: clientOrderModel ?? this.clientOrderModel,
      status: status ?? this.status,
      clientOrders: clientOrders ?? this.clientOrders,
    );
  }
}