part of 'detail_leagues_bloc.dart';

abstract class DetailLeaguesState extends Equatable {
  const DetailLeaguesState();
}

class DetailLeaguesInitial extends DetailLeaguesState {
  @override
  List<Object> get props => [];
}

class DetailLeaguesLoadInProgress extends DetailLeaguesState {
  @override
  List<Object> get props => [];
}

class DetailLeaguesLoadSuccess extends DetailLeaguesState {
  final DetailLeagues detailLeagues;

  DetailLeaguesLoadSuccess({
    this.detailLeagues,
  });

  @override
  List<Object> get props => [
        detailLeagues,
      ];
}

class DetailLeaguesLoadError extends DetailLeaguesState {
  final String message;

  DetailLeaguesLoadError({this.message});

  @override
  List<Object> get props => [];
}
