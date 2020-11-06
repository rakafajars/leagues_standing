part of 'model.dart';

SeasonsLeagues seasonsLeaguesFromJson(String str) =>
    SeasonsLeagues.fromJson(json.decode(str));

String seasonsLeaguesToJson(SeasonsLeagues data) => json.encode(data.toJson());

class SeasonsLeagues {
  SeasonsLeagues({
    this.status,
    this.data,
  });

  bool status;
  DataSeasons data;

  factory SeasonsLeagues.fromJson(Map<String, dynamic> json) => SeasonsLeagues(
        status: json["status"],
        data: DataSeasons.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class DataSeasons {
  DataSeasons({
    this.name,
    this.desc,
    this.abbreviation,
    this.seasons,
  });

  String name;
  String desc;
  String abbreviation;
  List<Season> seasons;

  factory DataSeasons.fromJson(Map<String, dynamic> json) => DataSeasons(
        name: json["name"],
        desc: json["desc"],
        abbreviation: json["abbreviation"],
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "abbreviation": abbreviation,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };
}

class Season {
  Season({
    this.year,
    this.startDate,
    this.endDate,
    this.types,
  });

  int year;
  String startDate;
  String endDate;
  List<Type> types;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        year: json["year"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "startDate": startDate,
        "endDate": endDate,
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}

class Type {
  Type({
    this.id,
    this.name,
    this.abbreviation,
    this.startDate,
    this.endDate,
    this.hasStandings,
  });

  String id;
  String name;
  String abbreviation;
  String startDate;
  String endDate;
  bool hasStandings;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        abbreviation: json["abbreviation"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        hasStandings: json["hasStandings"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbreviation": abbreviation,
        "startDate": startDate,
        "endDate": endDate,
        "hasStandings": hasStandings,
      };
}
