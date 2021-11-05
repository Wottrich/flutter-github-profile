import 'package:flutter/material.dart';
import 'package:flutter_github_profile/github_profile_colors.dart';
import 'package:flutter_github_profile/ui/search_component.dart';

void main() {
  runApp(MainContentScreen());
}

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  SearchState searchState = SearchState.initialState;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
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
          ),
        ),
      ),
    );
  }
}
