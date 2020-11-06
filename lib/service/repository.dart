part of 'api.dart';

abstract class Repository {
  Future<ListLeagues> getListLeagues();

  Future<DetailLeagues> getDetailLeagues({
    String idLeagues,
  });

  Future<SeasonsLeagues> getSeasonLeagues({
    String idLeagues,
  });
}
