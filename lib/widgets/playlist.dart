import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/cmmon.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/playscreen.dart';
import 'package:rhythmify1/models/playlistmodel.dart';
import 'package:rhythmify1/models/songsmodel.dart';
import 'package:rhythmify1/widgets/bootomnavigation.dart';

class PlaylistUnique extends StatefulWidget {
  PlaylistUnique({super.key, required this.index, required this.playlistname});
  int? index;
  String? playlistname;

  @override
  State<PlaylistUnique> createState() => _PlaylistUniqueState();
}

class _PlaylistUniqueState extends State<PlaylistUnique> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> converted = [];
  @override
  void initState() {
    final playlistbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playlistbox.values.toList();
    for (var i in playlistsong[widget.index!].playlistssongs!) {
      converted.add(Audio.file(i.songurl!,
          metas: Metas(
            title: i.songname,
            artist: i.artist,
            id: i.id.toString(),
          )));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // final double screenWidth = size.width;
    // final double screenHeight = size.height;
    final playlistbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playlistbox.values.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: colord, // appbar icon color
        ),
        title: Text(
          'PLAYLIST',
          style: GoogleFonts.kadwa(color: colord),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          titleslib(title: playlistsong[widget.index!].playlistname!),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: playlistbox.listenable(),
              builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                List<PlaylistSongs> playlistsong =
                    playlistsongs.values.toList();
                List<Songs>? playsong =
                    playlistsong[widget.index!].playlistssongs;
                return playsong!.isNotEmpty
                    ? ListView.builder(
                        itemCount: playsong.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              audioPlayer.open(
                             Playlist(audios: converted, startIndex: index)
                                  ,
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplug,
                                  loopMode: LoopMode.playlist);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Playscreen(cuindex: index),
                                  ));
                            },
                            title: Text(
                              playsong[index].songname!,
                              style: GoogleFonts.kadwa(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              playsong[index].songurl!,
                              style: GoogleFonts.kadwa(
                                  fontSize: 12, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              child: QueryArtworkWidget(
                                id: playsong[index].id!,
                                type: ArtworkType.AUDIO,
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('assets/p2.jpg'),
                                  // backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                            // leading: Image(image: AssetImage('assets/s6.jpg')),
                            trailing: PopupMenuButton<int>(
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text('Remove'),
                                  ),
                                ];
                              },
                              onSelected: (int value) {
                                if (value == 1) {
                                  // removing the song
                                  playsong.removeAt(index);
                                  playlistbox.putAt(
                                    widget.index!,
                                    PlaylistSongs(
                                      playlistname: widget.playlistname,
                                      playlistssongs: playsong,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Song removed'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'NO SONGS',
                          style: TextStyle(color: Colors.white38),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
