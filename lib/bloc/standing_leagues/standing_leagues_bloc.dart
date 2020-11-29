import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_standings/model/model.dart';
import 'package:football_standings/service/api.dart';
import 'package:equatable/equatable.dart';

part 'standing_leagues_event.dart';
part 'standing_leagues_state.dart';

class StandingLeaguesBloc
    extends Bloc<StandingLeaguesEvent, StandingLeaguesState> {
  StandingLeaguesBloc() : super(StandingLeaguesInitial());
  Repository _repository = ApiService();
  LeaguesStanding standingLeagues;

  @override
  Stream<StandingLeaguesState> mapEventToState(
    StandingLeaguesEvent event,
  ) async* {
    if (event is GetLeaguesStandingFromApi) {
      yield StandingLeaguesLoadInProgress();
      try {
        standingLeagues = await _repository.getLeaguesStanding(
          idLeagues: event.idLeagues,
          season: event.season,
          sort: event.sort,
        );

        yield StandingLeaguesLoadSuccess(
          leaguesStanding: standingLeagues,
        );
      } catch (e) {
        yield StandingLeaguesLoadError(
          message: "$e",
        );
      }
    }
  }
}
