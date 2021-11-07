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
              homeController.loadProfile(query);
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
        initialData: null,
        stream: homeController.outProfile,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("Search profile");
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              final Profile profile = snapshot.data as Profile;
              return Text(profile.name);
          }
        });
  }
}
