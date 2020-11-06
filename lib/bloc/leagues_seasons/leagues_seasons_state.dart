part of 'leagues_seasons_bloc.dart';

abstract class LeaguesSeasonsState extends Equatable {
  const LeaguesSeasonsState();
}

class LeaguesSeasonsInitial extends LeaguesSeasonsState {
  @override
  List<Object> get props => [];
}

class LeaguesSeasonsLoadInProgress extends LeaguesSeasonsState {
  @override
  List<Object> get props => [];
}

class LeaguesSeasonsLoadSuccess extends LeaguesSeasonsState {
  final SeasonsLeagues seasonLeagues;

  LeaguesSeasonsLoadSuccess({this.seasonLeagues});
  @override
  List<Object> get props => [];
}

class LeaguesSeasonsLoadError extends LeaguesSeasonsState {
  final String message;

  LeaguesSeasonsLoadError({this.message});
  @override
  List<Object> get props => [message];
}
