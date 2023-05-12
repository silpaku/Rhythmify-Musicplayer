import 'package:flutter/material.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/models/playlistmodel.dart';
import 'package:rhythmify1/models/songsmodel.dart';

// to add new playlist
newplaylist(String title) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplaylist = playlistbox.values.toList();
  bool isAlready =
      dbplaylist.where((element) => element.playlistname == title).isEmpty;
  if (isAlready) {
    List<Songs> playlistsongs = [];
    playlistbox.add(
      PlaylistSongs(playlistname: title, playlistssongs: playlistsongs),
    );
  }
}

//to add to playlist
addtoplaylist(Songs song, int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplaylist = playlistbox.values.toList();
  print(dbplaylist);
}

//to delete playlist
deleteplaylist(int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  playlistbox.deleteAt(index);
}

//to delete songs from playlist
deletefromplaylist(int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  playlistbox.delete(index);
}

//===========================playlist edit=======================================

editPlaylist(String name, index) async {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> playlistsong = playlistbox.values.toList();
  final box1 = PlaylistSongsbox.getInstance();

  box1.putAt(
      index,
      PlaylistSongs(
          playlistname: name,
          playlistssongs: playlistsong[index].playlistssongs));
}

showPlaylistEditOption(BuildContext context, int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> playlistsong = playlistbox.values.toList();
  final textEditmyController =
      TextEditingController(text: playlistsong[index].playlistname);
  double vwidth = MediaQuery.of(context).size.width;
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
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Edit Playlist',
                    style: TextStyle(fontSize: 25, color: Colors.white),
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
                      child: TextFormField(
                        controller: textEditmyController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white10,
                          label: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Enter Playlist Name:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
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
                        borderRadius: BorderRadius.circular(15),
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
                        label: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.black),
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
                          String newPlaylistName =
                              textEditmyController.text.trim();
                          bool nameAlreadyExists = playlistsong.any(
                              (playlist) =>
                                  playlist.playlistname == newPlaylistName);
                          if (newPlaylistName.isEmpty) {
                            // Show an error message for empty name
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Name is required'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (nameAlreadyExists) {
                            // Show an error message for duplicate name
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'A playlist with this name already exists'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            // Update the playlist name and close the dialog
                            editPlaylist(newPlaylistName, index);
                            Navigator.pop(context);
                          }
                        },
                        label: const Text(
                          'Done',
                          style: TextStyle(fontSize: 16, color: Colors.black),
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

//==========================playlist edit==================================

showPlaylistDeleteConfirmation(BuildContext context, int index) {
  double vwidth = MediaQuery.of(context).size.width;
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
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      'Are You Sure?',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: vwidth * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextButton.icon(
                          icon: const Icon(
                            Icons.done,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            deleteplaylist(index);
                            Navigator.pop(context);
                          },
                          label: const Text(
                            'Yes',
                            style: TextStyle(fontSize: 20, color: Colors.black),
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
    ),
  );
}
