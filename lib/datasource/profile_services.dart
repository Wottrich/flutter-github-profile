import 'dart:convert';

import 'package:flutter_github_profile/datasource/network_config.dart';
import 'package:flutter_github_profile/models/profile.dart';
import 'package:http/http.dart';

class ProfileService {
  Future<Profile> getGithubProfile(String profileLogin) async {
    final Response response = await NetworkConfig.client.get(
      Uri.parse("${NetworkConfig.baseUrl}/users/$profileLogin")
    );
    return toProfile(response);
  }

  Profile toProfile(Response response) {
    final dynamic decodedJson = jsonDecode(response.body);
    return Profile.fromJson(decodedJson);
  }
}