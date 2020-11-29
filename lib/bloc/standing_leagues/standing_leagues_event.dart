part of 'standing_leagues_bloc.dart';

abstract class StandingLeaguesEvent extends Equatable {
  const StandingLeaguesEvent();
}

class GetLeaguesStandingFromApi extends StandingLeaguesEvent {
  final String idLeagues;
  final String season;
  final String sort;

  GetLeaguesStandingFromApi({
    this.idLeagues,
    this.season,
    this.sort,
  });
  @override
  List<Object> get props => throw UnimplementedError();
}
