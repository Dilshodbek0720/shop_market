import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/services/api_service.dart';
import 'package:shop_market/utils/constants/storage_keys.dart';

class LoginRepository{
  final ApiService apiService;
  LoginRepository({required this.apiService});

  Future<UniversalData> loginUser({required String username, required String password}) async{
    UniversalData universalData = await apiService.loginUser(username: username, password: password);
    if(universalData.error.isEmpty){
      await StorageRepository.putString(StorageKeys.userToken, universalData.data as String);
      return UniversalData(data: true);
    }
    return UniversalData(data: false);
  }
}
