part of 'client_order_bloc.dart';

class ClientOrderStates extends Equatable {
  final List<ClientOrderModel> clientOrders;
  final List<AdminOrderModel> adminOrders;
  final ClientOrderModel clientOrderModel;
  final FormStatus status;

  const ClientOrderStates({
    required this.clientOrders,
    required this.adminOrders,
    required this.clientOrderModel,
    required this.status,
  });

  @override
  List<Object?> get props => [
    clientOrderModel,
    status,
    clientOrders,
    adminOrders,
  ];

  ClientOrderStates copyWith({
    ClientOrderModel? clientOrderModel,
    FormStatus? status,
    List<ClientOrderModel>? clientOrders,
    List<AdminOrderModel>? adminOrders,
  }) {
    return ClientOrderStates(
      clientOrderModel: clientOrderModel ?? this.clientOrderModel,
      status: status ?? this.status,
      clientOrders: clientOrders ?? this.clientOrders,
      adminOrders: adminOrders ?? this.adminOrders,
    );
  }
}