import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_profile/models/profile.dart';
import 'package:flutter_github_profile/screens/home_controller.dart';
import 'package:flutter_github_profile/ui/github_profile_colors.dart';
import 'package:flutter_github_profile/ui/search_component.dart';

class HomeContentScreen extends StatefulWidget {
  @override
  _HomeContentScreenState createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  late HomeController homeController;
  SearchState searchState = SearchState.initialState;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    homeController = BlocProvider.getBloc();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GithubProfile',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GithubProfileColors.colorPrimary,
          title: SearchToolbar(
            textController: _textController,
            searchState: searchState,
            onChangeSearchState: (nextState) {
              setState(() {
                searchState = nextState;
              });
            },
            onClearText: () {
              _textController.text = "";
            },
            onSearch: (query) {
              homeController.fetchProfile(query);
            },
          ),
        ),
        body: Column(
          children: [_profileStreamComponentBuilder(homeController)],
        ),
      ),
    );
  }

  Widget _profileStreamComponentBuilder(HomeController homeController) {
    return StreamBuilder(
        initialData: StateScreen.initial<Profile>(isLoading: false),
        stream: homeController.outProfile,
        builder: (context, snapshot) {
          StateScreen<Profile> stateProfile = snapshot.data as StateScreen<Profile>;
          if (stateProfile.isLoading) {
            return const CircularProgressIndicator();
          }

          if (stateProfile.hasError()) {
            return const Text("with error");
          }

          if (stateProfile.isSuccess()) {
            Profile profile = stateProfile.getDataNotNull();
            return Text(profile.name);
          }

          return const Text("Search your profile");
        });
  }
}
