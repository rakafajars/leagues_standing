part of 'model.dart';

DetailLeagues detailLeaguesFromJson(String str) =>
    DetailLeagues.fromJson(json.decode(str));

String detailLeaguesToJson(DetailLeagues data) => json.encode(data.toJson());

class DetailLeagues {
  DetailLeagues({
    this.status,
    this.data,
  });

  bool status;
  DetailLeaguesItem data;

  factory DetailLeagues.fromJson(Map<String, dynamic> json) => DetailLeagues(
        status: json["status"],
        data: DetailLeaguesItem.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class DetailLeaguesItem {
  DetailLeaguesItem({
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
  LogosDetailLeagues logos;

  factory DetailLeaguesItem.fromJson(Map<String, dynamic> json) =>
      DetailLeaguesItem(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        abbr: json["abbr"],
        logos: LogosDetailLeagues.fromJson(json["logos"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "abbr": abbr,
        "logos": logos.toJson(),
      };
}

class LogosDetailLeagues {
  LogosDetailLeagues({
    this.light,
    this.dark,
  });

  String light;
  String dark;

  factory LogosDetailLeagues.fromJson(Map<String, dynamic> json) =>
      LogosDetailLeagues(
        light: json["light"],
        dark: json["dark"],
      );

  Map<String, dynamic> toJson() => {
        "light": light,
        "dark": dark,
      };
}
