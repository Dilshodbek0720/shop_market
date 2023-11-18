import 'package:shop_market/data/models/orders/client_order_model.dart';

double totalPrice(List<ClientOrderModel> orders){
  double sum = 0;
  for (ClientOrderModel order in orders) {
    sum += (double.parse(order.price)*order.count);
  }
  return sum;
}