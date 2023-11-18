import '../../services/api_service.dart';
import '../models/universal_data.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<UniversalData> getAllUsers() async =>
      await apiService.getAllUsers();
}