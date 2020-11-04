import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_standings/model/model.dart';
import 'package:football_standings/service/api.dart';
import 'package:equatable/equatable.dart';

part 'detail_leagues_event.dart';
part 'detail_leagues_state.dart';

class DetailLeaguesBloc extends Bloc<DetailLeaguesEvent, DetailLeaguesState> {
  DetailLeaguesBloc() : super(DetailLeaguesInitial());
  Repository _repository = ApiService();
  DetailLeagues detailLeagues;
  @override
  Stream<DetailLeaguesState> mapEventToState(
    DetailLeaguesEvent event,
  ) async* {
    if (event is GetDetailLeageusFromApi) {
      yield DetailLeaguesLoadInProgress();
      try {
        detailLeagues = await _repository.getDetailLeagues(
          idLeagues: event.idLeagues,
        );

        yield DetailLeaguesLoadSuccess(
          detailLeagues: detailLeagues,
        );
      } catch (e) {
        yield DetailLeaguesLoadError(
          message: "$e",
        );
      }
    }
  }
}
