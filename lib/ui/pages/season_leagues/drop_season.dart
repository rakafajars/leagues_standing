part of '../pages.dart';

class InitialDropDownSeasonsLeagus extends StatelessWidget {
  final String idLeagues;

  const InitialDropDownSeasonsLeagus({
    Key key,
    this.idLeagues,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaguesSeasonsBloc>(
      create: (context) => LeaguesSeasonsBloc()
        ..add(
          GetListLeaguesSeasonFromApi(idLeagues: idLeagues),
        ),
      child: DropDownSeasonsLeagues(),
    );
  }
}

class DropDownSeasonsLeagues extends StatefulWidget {
  @override
  _DropDownSeasonsLeaguesState createState() => _DropDownSeasonsLeaguesState();
}

class _DropDownSeasonsLeaguesState extends State<DropDownSeasonsLeagues> {
  String currentItem;

  // Bloc
  LeaguesSeasonsBloc _leaguesSeasonsBloc;

  // Selected
  Season selectedSeasons;

  @override
  void initState() {
    super.initState();

    _leaguesSeasonsBloc = BlocProvider.of<LeaguesSeasonsBloc>(context);
  }

  List<DropdownMenuItem<Season>> buildDropDownMenuItems(List listSeasons) {
    List<DropdownMenuItem<Season>> items = List();
    for (Season listSeasons in listSeasons) {
      items.add(
        DropdownMenuItem(
          child: Text(
            listSeasons.year.toString(),
          ),
          value: listSeasons,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaguesSeasonsBloc, LeaguesSeasonsState>(
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
              hint: Text('Pilih Season'),
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
    );
  }
}
