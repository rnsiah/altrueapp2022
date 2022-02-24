import 'package:mobile/Data_Layer/Data_Providers/user_profile_api.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

class NonProfitProjectRepoisitory {
  ApiProvider apiProvider = ApiProvider();
  UserRepository userRepository = UserRepository();

  Future<dynamic> submit(NonProfitProject npProject) async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    final response = apiProvider.postAuthenticatedData(
        '/createProject', user!.key!, user.altid!, npProject);
    return response;
  }
}
