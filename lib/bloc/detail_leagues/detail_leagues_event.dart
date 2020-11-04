part of 'detail_leagues_bloc.dart';

abstract class DetailLeaguesEvent extends Equatable {
  const DetailLeaguesEvent();
}

class GetDetailLeageusFromApi extends DetailLeaguesEvent {
  final String idLeagues;

  GetDetailLeageusFromApi({
    this.idLeagues,
  });

  @override
  List<Object> get props => [idLeagues];
}
