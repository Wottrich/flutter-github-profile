import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_profile/datasource/profile_services.dart';
import 'package:flutter_github_profile/screens/home_content_screen.dart';
import 'package:flutter_github_profile/screens/home_controller.dart';

void main() {
  runApp(const InitialScreen());
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Bloc> blocs = [];
    final Bloc<HomeController> lessonsBloc = Bloc<HomeController>((value) {
      return HomeController(ProfileService());
    });
    blocs.add(lessonsBloc);
    return BlocProvider(
      dependencies: [EmptyDependency()],
        blocs: blocs,
        child: HomeContentScreen()
    );
  }
}
