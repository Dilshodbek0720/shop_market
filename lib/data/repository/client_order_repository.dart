import '../../services/api_service.dart';
import '../models/universal_data.dart';

class OrderRepository {
  final ApiService apiService;

  OrderRepository({required this.apiService});

  Future<UniversalData> getAllAdminOrders() async =>
      await apiService.getAllAdminOrders();

}