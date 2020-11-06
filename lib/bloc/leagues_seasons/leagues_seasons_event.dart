part of 'leagues_seasons_bloc.dart';

abstract class LeaguesSeasonsEvent extends Equatable {
  const LeaguesSeasonsEvent();
}

class GetListLeaguesSeasonFromApi extends LeaguesSeasonsEvent {
  final String idLeagues;

  GetListLeaguesSeasonFromApi({this.idLeagues});

  @override
  List<Object> get props => [idLeagues];
}
