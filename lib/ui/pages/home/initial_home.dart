part of '../pages.dart';

class InitialHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListLeaguesBloc>(
          create: (context) => ListLeaguesBloc()
            ..add(
              GetListLeaguesFromApi(),
            ),
        )
      ],
      child: MyHomePage(),
    );
  }
}
