import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rhythmify1/addfav.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/models/playlistmodel.dart';
import 'package:rhythmify1/models/songsmodel.dart';

import 'functions/addplaylist.dart';

showPlaylistOptions(BuildContext context, int songindex) {
  final box = PlaylistSongsbox.getInstance();
  final songbox = SongBox.getInstance();
  double vwidth = MediaQuery.of(context).size.width;
  double aheight = MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: colord,
          alignment: Alignment.bottomCenter,
          content: Container(
            height: aheight * 0.3,
            width: vwidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<Box<PlaylistSongs>>(
                      valueListenable: box.listenable(),
                      builder:
                          (context, Box<PlaylistSongs> playlistsongs, child) {
                        List<PlaylistSongs> playlistsong =
                            playlistsongs.values.toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: playlistsong.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                PlaylistSongs? playsongs =
                                    playlistsongs.getAt(index);
                                List<Songs> playsongdb =
                                    playsongs!.playlistssongs!;
                                List<Songs> songdb = songbox.values.toList();
                                bool isAlreadyAdded = playsongdb.any(
                                    (element) =>
                                        element.id == songdb[songindex].id);
                                if (!isAlreadyAdded) {
                                  playsongdb.add(
                                    Songs(
                                      songname: songdb[songindex].songname,
                                      artist: songdb[songindex].artist,
                                      duration: songdb[songindex].duration,
                                      songurl: songdb[songindex].songurl,
                                      id: songdb[songindex].id,
                                    ),
                                  );
                                }
                                playlistsongs.putAt(
                                    index,
                                    PlaylistSongs(
                                        playlistname:
                                            playlistsong[index].playlistname,
                                        playlistssongs: playsongdb));
                                // ignore: avoid_print
                                print(
                                    'song added to${playlistsong[index].playlistname}');
                                Navigator.pop(context);
                              },
                              title: Text(
                                playlistsong[index].playlistname!,
                                style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

showOptions(BuildContext context, int index) {
  double vwidth = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: colord,
          alignment: Alignment.bottomCenter,
          content: Container(
            height: 150,
            width: vwidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        showPlaylistOptionsadd(context);
                      },
                      icon: const Icon(
                        Icons.playlist_add_sharp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Create new playlist',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        showPlaylistOptions(context, index);
                      },
                      icon: const Icon(
                        Icons.playlist_add_sharp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Add to Playlist',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        if (checkFavour(index, BuildContext)) {
                          addfavour(index);
                        } else if (!checkFavour(index, BuildContext)) {
                          removefavour(index);
                        }
                        setState(() {});
                      },
                      icon: checkFavour(index, BuildContext)
                          ? const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                      label: checkFavour(index, BuildContext)
                          ? const Text(
                              'Add to favourites',
                              style: TextStyle(color: Colors.white),
                            )
                          : const Text(
                              'Removes from favourites ',
                              style: TextStyle(color: Colors.white),
                            )),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

showOptionsplayscreen(BuildContext context, int index) {
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: colord,
          alignment: Alignment.bottomCenter,
          content: Container(
            height: 150,
            width: vwidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        showPlaylistOptionsadd(context);
                      },
                      icon: const Icon(
                        Icons.playlist_add_sharp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Create new playlist',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        showPlaylistOptions(context, index);
                      },
                      icon: const Icon(
                        Icons.playlist_add_sharp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Add to Playlist',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

showPlaylistOptionsadd(BuildContext context) {
  final myController = TextEditingController();
  double vwidth = MediaQuery.of(context).size.width;
  double hheight = MediaQuery.of(context).size.height;
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplaylist = playlistbox.values.toList();
  List<String?> playlistNames = dbplaylist.map((e) => e.playlistname).toList();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: colord,
      alignment: Alignment.bottomCenter,
      content: SizedBox(
        height: hheight * 0.3,
        width: vwidth,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'New Playlist',
                    style: GoogleFonts.kadwa(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: vwidth * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextFormField(
                          controller: myController,
                          decoration: InputDecoration(
                            hintText: 'Enter Playlist Name',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            
                            
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: vwidth * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: Text(
                          'Cancel',
                          style: GoogleFonts.kadwa(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: vwidth * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          String playlistName = myController.text;
                          if (playlistName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.white,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.symmetric(
                                  vertical: 215,
                                ),
                                content: Text(
                                  'Please enter a playlist name.',
                                  style: TextStyle(color: Colors.red),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (playlistNames.contains(playlistName)) {
                            // Check if playlist name already exists
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.white,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.symmetric(
                                  vertical: 215,
                                ),
                                content: Text(
                                  'Playlist name already exists.',
                                  style: TextStyle(color: Colors.red),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            newplaylist(playlistName);
                            Navigator.pop(context);
                          }
                        },
                        label: Text(
                          'Done',
                          style: GoogleFonts.kadwa(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Padding titleslib({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
    child: Row(
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(letterSpacing: .5, fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

Widget about() {
  return const  Text(
    'We are a team of passionate music enthusiats who have come together to create a platform that allows music lovers to discover and enjoy new music easily,our app is desighned to be use friendly and intuitive,making it easy for you to explore and listen to your favourite artists and genres.whether youre .thank you for choosing our music app ,and we hope you enjoy the journey with us ! ',
    style:  TextStyle(color: Colors.white, fontSize: 16),
  );
}
