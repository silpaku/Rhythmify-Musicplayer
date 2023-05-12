import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:rhythmify1/models/recentlymodel.dart';
import '../models/favouritemodel.dart';
import '../models/mostplayed.dart';

late Box<RecentlyplayedModel> RecentlyPlayedBox;
late Box<favourites> favouritedb;
openfavourite() async {
  favouritedb = await Hive.openBox<favourites>(favourbox);
}

openrecentlyplayeddb() async {
  RecentlyPlayedBox = await Hive.openBox("recentlyplayed");
}

late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async {
  mostplayedsongs = await Hive.openBox("Mostplayed");
}

addRecently(RecentlyplayedModel value) {
  List<RecentlyplayedModel> list = RecentlyPlayedBox.values.toList();
  bool isNot =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isNot == true) {
    RecentlyPlayedBox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    RecentlyPlayedBox.deleteAt(index);
    RecentlyPlayedBox.delete(value);
    RecentlyPlayedBox.add(value);
  }
  log('$RecentlyPlayedBox');
}

addMostplayed(MostPlayed value) {
  value.count++;
}






















// updateMostPlayed(MostPlayed value) {
//   final box = MostPlayedBox.getInstance();
//   List<MostPlayed> list = box.values.toList();
//   bool isNot = list.where((element) => element.id == value.id).isNotEmpty;
//   if (isNot) {
//     int mostIndex = list.indexWhere((element) => element.id == value.id);
//     list[mostIndex].count++;
//     log('mostly');
//   }
// }
