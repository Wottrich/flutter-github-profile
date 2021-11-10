import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_github_profile/datasource/profile_services.dart';
import 'package:flutter_github_profile/models/profile.dart';

class HomeController implements BlocBase {

  final ProfileService profileService;

  HomeController(this.profileService);

  final StreamController<StateScreen<Profile>> _profileController = StreamController();
  Stream<StateScreen<Profile>> get outProfile => _profileController.stream;
  Sink<StateScreen<Profile>> get inProfile => _profileController.sink;

  void fetchProfile(String profileLogin) async {
    inProfile.add(StateScreen.initial(isLoading: true));
    Profile profile = await profileService.getGithubProfile(profileLogin);
    inProfile.add(StateScreen.success(profile));
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

class StateScreen<T> {
  StateScreen(this.data, this.error, this.isLoading);
  bool isLoading;
  Object? error;
  T? data;

  bool isInitialWithoutLoading() => !isLoading && error == null && data == null;

  bool hasError() => error != null;

  bool isSuccess() => data != null;

  T getDataNotNull() {
    if (data == null) {
      throw NullThrownError();
    }
    return data!;
  }

  static StateScreen<T> initial<T>({bool isLoading = true}) {
    return StateScreen<T>(null, null, isLoading);
  }

  static StateScreen<T> failure<T>(Object? error) {
    return StateScreen<T>(null, error, false);
  }

  static StateScreen<T> success<T>(T data) {
    return StateScreen<T>(data, null, false);
  }

}