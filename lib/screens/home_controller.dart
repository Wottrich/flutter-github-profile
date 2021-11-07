import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_github_profile/datasource/profile_services.dart';
import 'package:flutter_github_profile/models/profile.dart';

class HomeController implements BlocBase {

  final ProfileService profileService;

  Profile? _profile = null;

  HomeController(this.profileService);

  final StreamController<Profile> _profileController = StreamController();
  Stream<Profile> get outProfile => _profileController.stream;
  Sink<Profile> get inProfile => _profileController.sink;

  void loadProfile(String profileLogin) async {
    Profile profile = await profileService.getGithubProfile(profileLogin);
    _profile = profile;
    inProfile.add(profile);
  }

  @override
  void addListener(VoidCallback listener) {
    _profileController.onListen = listener;
  }

  @override
  void dispose() {
    _profileController.close();
  }

  @override
  bool get hasListeners => _profileController.hasListener;

  @override
  void removeListener(VoidCallback listener) {
    if (_profileController.hasListener) {
      _profileController.onCancel = listener;
    }
  }

  @override
  void notifyListeners() {}
}