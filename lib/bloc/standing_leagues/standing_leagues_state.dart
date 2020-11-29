part of 'standing_leagues_bloc.dart';

abstract class StandingLeaguesState extends Equatable {
  const StandingLeaguesState();
}

class StandingLeaguesInitial extends StandingLeaguesState {
  @override
  List<Object> get props => [];
}

class StandingLeaguesLoadInProgress extends StandingLeaguesState {
  @override
  List<Object> get props => [];
}

class StandingLeaguesLoadSuccess extends StandingLeaguesState {
  final LeaguesStanding leaguesStanding;

  StandingLeaguesLoadSuccess({this.leaguesStanding});

  @override
  List<Object> get props => [leaguesStanding];
}

class StandingLeaguesLoadError extends StandingLeaguesState {
  final String message;

  StandingLeaguesLoadError({this.message});

  @override
  List<Object> get props => [
        message,
      ];
}
