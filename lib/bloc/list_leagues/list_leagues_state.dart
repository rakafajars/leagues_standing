part of 'list_leagues_bloc.dart';

abstract class ListLeaguesState extends Equatable {
  const ListLeaguesState();
}

class ListLeaguesInitial extends ListLeaguesState {
  @override
  List<Object> get props => [];
}

class ListLeaguesLoadInProgress extends ListLeaguesState {
  @override
  List<Object> get props => [];
}

class ListLeaguesLoadSuccess extends ListLeaguesState {
  final ListLeagues listLeagues;

  ListLeaguesLoadSuccess({this.listLeagues});

  @override
  List<Object> get props => [listLeagues];
}

class ListLeaguesLoadError extends ListLeaguesState {
  final String message;

  ListLeaguesLoadError({
    this.message,
  });
  @override
  List<Object> get props => [message];
}
