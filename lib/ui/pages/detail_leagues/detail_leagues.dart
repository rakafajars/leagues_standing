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
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
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
  // Refresh
  Completer<void> _refreshCompleter;

  // Bloc
  DetailLeaguesBloc detailLeaguesBloc;

  @override
  void initState() {
    super.initState();
    detailLeaguesBloc = BlocProvider.of<DetailLeaguesBloc>(context);
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
              return Center(
                child: Text('Loading..'),
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
}
