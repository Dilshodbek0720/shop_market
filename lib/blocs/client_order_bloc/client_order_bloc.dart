import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/data/local/local_database.dart';
import '../../data/models/orders/client_order_model.dart';
import '../../data/models/status/form_status.dart';
import '../../data/models/universal_data.dart';

part 'client_order_state.dart';
part 'client_order_event.dart';

class ClientOrderBloc extends Bloc<ClientOrderEvent, ClientOrderStates> {

  ClientOrderBloc()
      : super(
    ClientOrderStates(
      clientOrders: const [],
      clientOrderModel: ClientOrderModel(
        productId: 0,
        count: 0,
        image: '',
        title: '',
        price: '',
        description: '',
      ),
      status: FormStatus.pure,
    ),
  ) {
    on<AddClientOrderEvent>(addClientOrder);
    on<GetClientOrderEvent>(getClientOrders);
    on<DeleteClientOrderEvent>(deleteClientOrder);
  }

  Future<void> addClientOrder(AddClientOrderEvent event, Emitter<ClientOrderStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = UniversalData(data: await LocalDatabase.insertOrders(event.clientOrderModel));
    if (data.error.isEmpty) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }

  Future<void> deleteClientOrder(
      DeleteClientOrderEvent event, Emitter<ClientOrderStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = UniversalData(data: await LocalDatabase.deleteOrder(event.clientOrderId));
    if (data.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }

  Future<void> getClientOrders(
      GetClientOrderEvent event, Emitter<ClientOrderStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = UniversalData(data: await LocalDatabase.getAllOrders());
    if (data.error.isEmpty) {
      emit(
        state.copyWith(
          clientOrders: data.data,
          status: FormStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }


}