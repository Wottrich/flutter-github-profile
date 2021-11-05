import 'package:flutter/material.dart';
import 'package:flutter_github_profile/github_profile_colors.dart';

enum SearchState { initialState, searchingState }

class SearchToolbar extends StatelessWidget {
  SearchToolbar(
      {required this.searchState,
      required this.textController,
      required this.onChangeSearchState,
      required this.onClearText});
  
  final TextEditingController textController;
  final SearchState searchState;
  final Function(SearchState nextState) onChangeSearchState;
  final Function onClearText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getSearchContent(searchState, textController),
        _getRightIconButton(searchState, textController, (searchState) => onChangeSearchState(searchState), onClearText),
      ],
    );
  }
}

Widget _getSearchContent(SearchState searchState, TextEditingController textController) {
  FocusNode focusNode = FocusNode();
  switch (searchState) {
    case SearchState.initialState:
      return const Text("GithubProfile");
    case SearchState.searchingState:
      Widget textFieldWidget = Expanded(
        child: TextField(
          focusNode: focusNode,
          controller: textController,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: GithubProfileColors.onPrimary),
        ),
      );
      focusNode.requestFocus();
      return textFieldWidget;
  }
}

Widget _getRightIconButton(
    SearchState searchState, TextEditingController textController, Function(SearchState searchState) onChangeSearchState, Function onClearText) {
  switch (searchState) {
    case SearchState.searchingState:
      return IconButton(
        onPressed: () {
          if (textController.text.isEmpty) {
            onChangeSearchState(SearchState.initialState);
          }
          onClearText();
        },
        icon: const Icon(
          Icons.close,
          color: GithubProfileColors.onPrimary,
        ),
      );
    case SearchState.initialState:
      return IconButton(
        onPressed: () {
          onChangeSearchState(SearchState.searchingState);
        },
        icon: const Icon(
          Icons.search,
          color: GithubProfileColors.onPrimary,
        ),
      );
  }
}
