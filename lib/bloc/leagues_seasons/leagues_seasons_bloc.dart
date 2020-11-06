import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_standings/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:football_standings/service/api.dart';

part 'leagues_seasons_event.dart';
part 'leagues_seasons_state.dart';

class LeaguesSeasonsBloc
    extends Bloc<LeaguesSeasonsEvent, LeaguesSeasonsState> {
  LeaguesSeasonsBloc() : super(LeaguesSeasonsInitial());
  Repository _repository = ApiService();
  SeasonsLeagues seasonLeagues;

  @override
  Stream<LeaguesSeasonsState> mapEventToState(
    LeaguesSeasonsEvent event,
  ) async* {
    if (event is GetListLeaguesSeasonFromApi) {
      yield LeaguesSeasonsLoadInProgress();
      try {
        seasonLeagues = await _repository.getSeasonLeagues(
          idLeagues: event.idLeagues,
        );

        yield LeaguesSeasonsLoadSuccess(
          seasonLeagues: seasonLeagues,
        );
      } catch (e) {
        LeaguesSeasonsLoadError(
          message: "$e",
        );
      }
    }
  }
}
