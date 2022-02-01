import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:mobile/Data_Layer/Data_Providers/user_profile_api.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:http/http.dart' as http;

class CompanyRepository {
  ApiProvider provider = ApiProvider();
  NonAuthenticatedApiProvider nonauthprov = NonAuthenticatedApiProvider();

  Future<List<ForProfitCompany>> getCompanyList({required User user}) async {
    List<ForProfitCompany> companies = [];
    final response =
        await provider.getUserAuthenticatedData('api/companies', user.key!);
    for (var responses in response) {
      companies.add(ForProfitCompany.fromJson(responses));
    }
    return companies;
  }

  Future<List<ForProfitCompany>> getCompanyListByCategory(
      {required Category category, required User user}) async {
    List<ForProfitCompany> companies = [];
    final response = await provider.getUserAuthenticatedData(
        'api/companies/$category', user.key!);
    for (var responses in response) {
      companies.add(ForProfitCompany.fromJson(responses));
    }
    return companies;
  }

  Future<ForProfitCompany> fetchCompany(ForProfitCompany company) async {
    final response = await nonauthprov.get('api/companies/${company.id}');
    company = ForProfitCompany.fromJson(response);
    return company;
  }

  Future<List<ForProfitCompany>> fetchFeaturedCompanies() async {
    List<ForProfitCompany> companyList = [];
    final response = await nonauthprov.get('api/companies/featured');
    for (var company in response) {
      companyList.add(ForProfitCompany.fromJson(company));
    }
    return companyList;
  }

  // Future<bool> createCompany(
  //     {User? user, required CompanyCompletion completedCompany}) async {
  //   var postUri = Uri.parse('http://localhost:8000/api/companies/');
  //   var request = new http.MultipartRequest('post', postUri);
  //   request.headers['Authorization'] = 'Token ${user!.key}';

  //   var response = await request.send();
  //   print(response.stream);
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     throw Exception(
  //         'Something Went Wrong When Creating Your Company Profile');
  //   }
  // }

  Future<bool> newCompany(
      {required CompanyCompletion company, User? user}) async {
    String url = 'http://localhost:8000/api/registerCompany/';

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Token ${user!.key}",
        },
        body: json.encode(company));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Did not update');
    }
  }

  Future<void> addCompanyContributors(
      ForProfitCompany company, User user, Profile profile) async {
    try {
      await provider.patchAuthenticatedData(
          'api/companies/${company.id}/manageUserFollowers',
          user.key!,
          user.altid!,
          profile);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> editCompanyDetails(
      User user, ForProfitCompany company, Profile profile) async {
    var postUri =
        Uri.parse('http://localhost:8000/api/companies/${company.id}/');
    var request = new http.MultipartRequest('patch', postUri);
    request.headers['Authorization'] = 'Token ${user.key}';
    request.fields['owner'] = profile.username.toString();
    request.fields['name'] = company.name.toString();
    request.fields['year_started'] = company.yearStarted.toString();
    request.fields['logo'] = company.logo.toString();
    request.fields['mission'] = company.mission.toString();
    request.fields['description'] = company.description.toString();
    request.fields['website_address'] = company.websiteAddress.toString();
    var response = await request.send();
    print(response.stream);
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      print(res.body);
    } else {
      throw Exception('Profile Picture Not Updated');
    }
  }
}

class FollowingAction {
  final Profile profile;
  final String action;

  FollowingAction(this.profile, this.action);
}
