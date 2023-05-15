import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:rhythmify1/functions/dbfunctions.dart';
import 'package:rhythmify1/models/favouritemodel.dart';
import 'package:rhythmify1/models/songsmodel.dart';


addfavour(int index) async {
  final box = SongBox.getInstance();
  List<Songs> allsongs = box.values.toList();
  List<favourites> likedsongs = [];
  likedsongs = favouritedb.values.toList();

  bool isalready = likedsongs
      .where((element) => element.songname == allsongs[index].songname)
      .isEmpty;
  if (isalready) {
    favouritedb.add(
      favourites(
          id: allsongs[index].id,
          songname: allsongs[index].songname,
          artist: allsongs[index].artist,
          duration: allsongs[index].duration,
          songurl: allsongs[index].songurl),
    );
  } else {
    likedsongs
        .where((element) => element.songname == allsongs[index].songname)
        .isEmpty;
    int currentidx =
        likedsongs.indexWhere((element) => element.id == allsongs[index].id);
    await favouritedb.deleteAt(currentidx);
    await favouritedb.deleteAt(index);
  }
  log(likedsongs[index].songname!);
  log('added to favorites...');
}

removefavour(int index) async {
  final box = SongBox.getInstance();
  final box2 = FavouriteBox.getInstance();
  List<favourites> favourite = box2.values.toList();
  List<Songs> dbsongs = box.values.toList();
  int currentindex =
      favourite.indexWhere((element) => element.id == dbsongs[index].id);
  await favouritedb.deleteAt(currentindex);
  log('removed to favorites...');
}

bool checkFavour(int index, BuildContext) {
  final box = SongBox.getInstance();
  List<Songs> allsongs = box.values.toList();
  List<favourites> favouritesongs = [];
  favourites value = favourites(
      id: allsongs[index].id,
      songname: allsongs[index].songname,
      artist: allsongs[index].artist,
      duration: allsongs[index].duration,
      songurl: allsongs[index].songurl);
  favouritesongs = favouritedb.values.toList();
  bool isAlready = favouritesongs
      .where((element) => element.songname == value.songname)
      .isEmpty;
  log('bfjb');
  return isAlready ? true : false;
}

//delete fav
deletefav(int index, BuildContext context) async {
  await favouritedb.deleteAt(favouritedb.length - index - 1);
}





















// Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //         pageBuilder: (context, animation, secondaryAnimation) =>const Favorite(),
  //         transitionDuration: Duration.zero,
  //         reverseTransitionDuration: Duration.zero));