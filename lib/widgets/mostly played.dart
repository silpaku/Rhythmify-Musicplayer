import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/playscreen.dart';
import 'package:rhythmify1/models/mostplayed.dart';

import '../cmmon.dart';

class Mostly extends StatefulWidget {
  const Mostly({Key? key});

  @override
  State<Mostly> createState() => _MostlyState();
}

class _MostlyState extends State<Mostly> {
  final box = MostPlayedBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];

  @override
  void initState() {
    List<MostPlayed> mostsong = box.values.toList();
    int i = 0;
    for (var element in mostsong) {
      if (element.count > 3) {
        mostplayedsongs.insert(i, element);
        i++;
      }
    }
    for (var items in mostplayedsongs) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    super.initState();
  }

  List<MostPlayed> mostplayedsongs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: colord, // Set the color of the back button icon
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Mostly Played',
          style: GoogleFonts.kadwa(
            color: colord,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<MostPlayed>>(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                return mostplayedsongs.isNotEmpty
                    ? ListView.builder(
                      
                        itemCount: mostplayedsongs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              audioPlayer.open(Playlist(audios:songs,startIndex: index ),
                              showNotification: true,
                              headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                              loopMode: LoopMode.playlist
                              );
                              Navigator.push(context, MaterialPageRoute(builder: ((context) =>Playscreen(cuindex: index) )));
                            },
                            title: Text(
                              mostplayedsongs[index].songname,
                              style: GoogleFonts.kadwa(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              mostplayedsongs[index].artist,
                              style: GoogleFonts.kadwa(
                                  fontSize: 12, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                             leading: CircleAvatar(
                          radius: 27,
                          child: QueryArtworkWidget(
                            id: mostplayedsongs[index].id,
                            artworkWidth:
                                MediaQuery.of(context).size.width * 0.30,
                            artworkHeight:
                                MediaQuery.of(context).size.height * 0.30,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.contain,
                            nullArtworkWidget: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/p5.jpg'),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: (() {
                              showOptions(context, index);
                            }),
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ))
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'your most played songs will appear here !',
                          style: GoogleFonts.kadwa(color: Colors.white),
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
