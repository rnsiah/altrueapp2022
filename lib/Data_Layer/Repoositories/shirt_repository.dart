import 'package:mobile/Data_Layer/Data_Providers/user_profile_api.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_variation_model.dart';

class ShirtRepository {
  NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();

  Future<List<Shirt>> fetchShirtList() async {
    List<Shirt> shirts = [];

    final response = await _provider.get('api/shirts');
    for (var responses in response) {
      shirts.add(Shirt.fromJson(responses));
    }
    return shirts;
  }

  Future<List<Shirt>> fetchRefugeeShirts() async {
    List<Shirt> shirts = [];

    final response = await _provider.get('api/refugeeshirts');
    for (var responses in response) {
      shirts.add(Shirt.fromJson(responses));
    }
    return shirts;
  }

  Future<Shirt> fetchShirt(int id) async {
    final response = await _provider.get('api/shirts/$id');
    return Shirt.fromJson(response);
  }

  Future<List<Shirt>> featuredShirts() async {
    List<Shirt> shirts = [];
    final response = await _provider.get('api/featuredshirts');
    for (var responses in response) {
      shirts.add(Shirt.fromJson(responses));
    }
    return shirts;
  }

  Future<List<Shirt>> fetchShirtByCategory(Category category) async {
    List<Shirt> shirts = [];
    if (category.name == 'All Causes') {
      shirts = await fetchShirtList();
      return shirts;
    }
    final shirtList = await _provider
        .get('api/${category.name.replaceAll(' ', '').toLowerCase()}shirts');

    for (var shirt in shirtList) {
      shirts.add(Shirt.fromJson(shirt));
    }
    return shirts;
  }

  // Future<String> getShirtColor(ShirtVariation variation)async{

  // }
}
