import 'package:mobile/Data_Layer/Data_Providers/user_profile_api.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class AllUsersRepository {
  ApiProvider provider = ApiProvider();
  NonAuthenticatedApiProvider nonauthprovider = NonAuthenticatedApiProvider();

  Future<List<ProfileRepresentation>> getAllProfiles(User user) async {
    List<ProfileRepresentation> profileList = [];

    final profiles =
        await provider.getUserAuthenticatedData('api/findusers', user.key!);
    for (var profile in profiles) {
      profileList.add(ProfileRepresentation.fromJson(profile));
    }
    return profileList;
  }

  Future<Profile> getProfileById(User user, Profile otheruserprofile) async {
    final profile = await provider.getUserAuthenticatedData(
        'api/userprofiles/${otheruserprofile.user}', user.key!);
    return profile;
  }
}
