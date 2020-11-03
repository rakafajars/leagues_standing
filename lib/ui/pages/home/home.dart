part of '../pages.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Refresh
  Completer<void> _refreshCompleter;

  // Bloc
  ListLeaguesBloc leaguesBloc;

  @override
  void initState() {
    super.initState();
    leaguesBloc = BlocProvider.of<ListLeaguesBloc>(context);
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Leagues Available',
        ),
      ),
      body: BlocListener<ListLeaguesBloc, ListLeaguesState>(
        listener: (context, state) {
          if (state is ListLeaguesLoadInProgress) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        child: BlocBuilder<ListLeaguesBloc, ListLeaguesState>(
          builder: (context, state) {
            if (state is ListLeaguesLoadInProgress) {
              return GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                    child: Card(
                      elevation: 1.5,
                    ),
                  );
                },
              );
            }
            if (state is ListLeaguesLoadSuccess) {
              return RefreshIndicator(
                onRefresh: () {
                  leaguesBloc
                    ..add(
                      GetListLeaguesFromApi(),
                    );
                  return _refreshCompleter.future;
                },
                child: GridView.builder(
                  itemCount: state.listLeagues.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          CachedNetworkImage(
                            imageUrl: state.listLeagues.data[index].logos.light,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => ErrorImage(),
                            height: 130,
                            width: 100,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            if (state is ListLeaguesLoadError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
