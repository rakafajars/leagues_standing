part of 'model.dart';

ListLeagues listLeaguesFromJson(String str) =>
    ListLeagues.fromJson(json.decode(str));

String listLeaguesToJson(ListLeagues data) => json.encode(data.toJson());

class ListLeagues {
  ListLeagues({
    this.status,
    this.data,
  });

  bool status;
  List<ListLeaguesItem> data;

  factory ListLeagues.fromJson(Map<String, dynamic> json) => ListLeagues(
        status: json["status"],
        data: List<ListLeaguesItem>.from(
            json["data"].map((x) => ListLeaguesItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ListLeaguesItem {
  ListLeaguesItem({
    this.id,
    this.name,
    this.slug,
    this.abbr,
    this.logos,
  });

  String id;
  String name;
  String slug;
  String abbr;
  Logos logos;

  factory ListLeaguesItem.fromJson(Map<String, dynamic> json) =>
      ListLeaguesItem(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        abbr: json["abbr"],
        logos: Logos.fromJson(json["logos"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "abbr": abbr,
        "logos": logos.toJson(),
      };
}

class Logos {
  Logos({
    this.light,
    this.dark,
  });

  String light;
  String dark;

  factory Logos.fromJson(Map<String, dynamic> json) => Logos(
        light: json["light"],
        dark: json["dark"],
      );

  Map<String, dynamic> toJson() => {
        "light": light,
        "dark": dark,
      };
}
