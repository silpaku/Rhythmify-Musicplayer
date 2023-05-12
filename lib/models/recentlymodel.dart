import 'package:hive/hive.dart';
part 'recentlymodel.g.dart';
@HiveType(typeId:2)
class RecentlyplayedModel {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  @HiveField(5)
  int? index;

  RecentlyplayedModel(
    {this.songname,
    this.artist,
    this.duration,
    this.songurl,
    this.id,
    this.index
    });
}

  String recentbox='RecentlyPlayed';
class RecentlyPlayedBox{
  static Box<RecentlyplayedModel>? _box;
  static Box<RecentlyplayedModel> getInstance(){
    return _box ??=Hive.box(recentbox);
  }
}