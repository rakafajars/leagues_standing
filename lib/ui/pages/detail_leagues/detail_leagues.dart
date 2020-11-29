part of '../pages.dart';

class InitialDetailLeagues extends StatelessWidget {
  final String idLeagues;

  const InitialDetailLeagues({Key key, this.idLeagues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailLeaguesBloc>(
          create: (context) => DetailLeaguesBloc()
            ..add(
              GetDetailLeageusFromApi(
                idLeagues: idLeagues,
              ),
            ),
        ),
        BlocProvider<LeaguesSeasonsBloc>(
          create: (context) => LeaguesSeasonsBloc()
            ..add(
              GetListLeaguesSeasonFromApi(
                idLeagues: idLeagues,
              ),
            ),
        ),
        BlocProvider<StandingLeaguesBloc>(
          create: (context) => StandingLeaguesBloc(),
        ),
      ],
      child: DetailLeagues(
        idLeagues: idLeagues,
      ),
    );
  }
}

class DetailLeagues extends StatefulWidget {
  final String idLeagues;

  const DetailLeagues({Key key, this.idLeagues}) : super(key: key);

  @override
  _DetailLeaguesState createState() => _DetailLeaguesState();
}

class _DetailLeaguesState extends State<DetailLeagues> {
  String seasons;
  String currentItem;

  // Refresh
  Completer<void> _refreshCompleter;

  // Bloc
  DetailLeaguesBloc detailLeaguesBloc;
  LeaguesSeasonsBloc _leaguesSeasonsBloc;
  StandingLeaguesBloc _standingLeaguesBloc;

  // Selected
  Season selectedSeasons;

  @override
  void initState() {
    super.initState();
    detailLeaguesBloc = BlocProvider.of<DetailLeaguesBloc>(context);
    _leaguesSeasonsBloc = BlocProvider.of<LeaguesSeasonsBloc>(context);
    _standingLeaguesBloc = BlocProvider.of<StandingLeaguesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Leagues'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DetailLeaguesBloc, DetailLeaguesState>(
            listener: (context, state) {
              if (state is DetailLeaguesLoadInProgress) {}
            },
          ),
          // BlocListener<SubjectBloc, SubjectState>(
          //   listener: (context, state) {
          //   },
          // ),
        ],
        child: BlocBuilder<DetailLeaguesBloc, DetailLeaguesState>(
          builder: (context, state) {
            if (state is DetailLeaguesLoadInProgress) {
              return Container(
                margin: EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      width: 200,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: Card(
                          elevation: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is DetailLeaguesLoadSuccess) {
              return RefreshIndicator(
                onRefresh: () {
                  detailLeaguesBloc
                    ..add(
                      GetDetailLeageusFromApi(
                        idLeagues: widget.idLeagues,
                      ),
                    );

                  return _refreshCompleter.future;
                },
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 200,
                            child: CachedNetworkImage(
                              imageUrl: state.detailLeagues.data.logos.light,
                              errorWidget: (context, url, error) =>
                                  ErrorImage(),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            state.detailLeagues.data.name,
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<LeaguesSeasonsBloc, LeaguesSeasonsState>(
                      builder: (context, state) {
                        if (state is LeaguesSeasonsLoadInProgress) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            child: DropdownButton(
                              hint: Text('Loading..'),
                              isExpanded: true,
                              items: [],
                              onChanged: (val) {},
                            ),
                          );
                        }
                        if (state is LeaguesSeasonsLoadSuccess) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            child: DropdownButton(
                              hint: Text('Pilih Seasons'),
                              isExpanded: true,
                              value: selectedSeasons,
                              items: state.seasonLeagues.data.seasons
                                  .map(
                                    (itemSeasons) => DropdownMenuItem(
                                      child: Text(
                                        itemSeasons.year.toString(),
                                      ),
                                      value: itemSeasons,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedSeasons = value;
                                  _standingLeaguesBloc.add(
                                    GetLeaguesStandingFromApi(
                                      idLeagues: widget.idLeagues,
                                      season: selectedSeasons.year.toString(),
                                    ),
                                  );
                                });
                              },
                            ),
                          );
                        }
                        if (state is LeaguesSeasonsLoadError) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: 24,
                              right: 24,
                            ),
                            child: DropdownButton(
                              hint: Text(state.message),
                              isExpanded: true,
                              items: [],
                              onChanged: (val) {},
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Padding(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text('Pos'),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    'Team',
                                  ),
                                  flex: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'M',
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    'W',
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    'L',
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    'D',
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    'P',
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          BlocBuilder<StandingLeaguesBloc,
                              StandingLeaguesState>(
                            builder: (context, state) {
                              if (state is StandingLeaguesLoadInProgress) {
                                return Text('Loading..');
                              }
                              if (state is StandingLeaguesLoadSuccess) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state
                                      .leaguesStanding.data.standings.length,
                                  itemBuilder: (context, int index) {
                                    return dataLeagues(
                                      standings: state.leaguesStanding.data
                                          .standings[index],
                                      rank: state.leaguesStanding.data
                                          .standings[index].stats[8],
                                      match: state.leaguesStanding.data
                                          .standings[index].stats[3],
                                      win: state.leaguesStanding.data
                                          .standings[index].stats[0],
                                      lose: state.leaguesStanding.data
                                          .standings[index].stats[1],
                                      draw: state.leaguesStanding.data
                                          .standings[index].stats[2],
                                      point: state.leaguesStanding.data
                                          .standings[index].stats[5],
                                    );
                                  },
                                );
                              }
                              if (state is StandingLeaguesLoadError) {
                                return Text(
                                  state.message,
                                );
                              }
                              return ListView(
                                shrinkWrap: true,
                                children: [],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is DetailLeaguesLoadError) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget dataLeagues({
    Standings standings,
    Stats rank,
    Stats match,
    Stats win,
    Stats lose,
    Stats draw,
    Stats point,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              rank.value.toString(),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            standings.team.name,
          ),
          flex: 4,
        ),
        Expanded(
          child: Text(
            match.value.toString(),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            win.value.toString(),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            lose.value.toString(),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            draw.value.toString(),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            point.value.toString(),
          ),
          flex: 1,
        ),
      ],
    );
  }
}
