import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:football_standings/service/api.dart';
import 'package:football_standings/model/model.dart';

part 'list_leagues_event.dart';
part 'list_leagues_state.dart';

class ListLeaguesBloc extends Bloc<ListLeaguesEvent, ListLeaguesState> {
  Repository _repository = ApiService();
  ListLeagues listLeagues;

  ListLeaguesBloc() : super(ListLeaguesInitial());

  @override
  Stream<ListLeaguesState> mapEventToState(
    ListLeaguesEvent event,
  ) async* {
    if (event is GetListLeaguesFromApi) {
      yield ListLeaguesLoadInProgress();
      try {
        listLeagues = await _repository.getListLeagues();

        yield ListLeaguesLoadSuccess(
          listLeagues: listLeagues,
        );
      } catch (e) {
        yield ListLeaguesLoadError(
          message: "$e",
        );
      }
    }
  }
}
