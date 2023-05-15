import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/cmmon.dart';
import 'package:rhythmify1/functions/dbfunctions.dart';
import 'package:rhythmify1/models/mostplayed.dart';
import 'package:rhythmify1/models/songsmodel.dart';
import 'package:rhythmify1/playscreen.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/settings/settings.dart';


import '../models/recentlymodel.dart';

class Home1 extends StatefulWidget {
  Home1({Key? key});

  static int? index = 0;
  ValueNotifier homePageNotifier = ValueNotifier<int>(index!);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final audioPlayer = AssetsAudioPlayer.withId('0');
  // final box = SongBox.getInstance();
  final mostbox = MostPlayedBox.getInstance();
  final box = SongBox.getInstance();
  List<Audio> convertedSongs = [];
  bool isadded = true;
  @override
  void initState() {
    List<Songs> songDatabase = box.values.toList();

    for (var i in songDatabase) {
      convertedSongs.add(Audio.file(i.songurl!,
          metas: Metas(
            title: i.songname,
            artist: i.artist,
            id: i.id.toString(),
          )));
    }
    audioPlayer.open(
        Playlist(
          audios: convertedSongs,
        ),
        showNotification: true,
        autoStart: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'DISCOVER',
          style: GoogleFonts.kadwa(color: colord, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: colord,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ));
            },
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                
                children: [
                  const Padding(padding: EdgeInsets.only(top: 14)),
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Songs',
                            style: GoogleFonts.kadwa(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colord)),
                         SizedBox(
                          width: screenWidth*0.7,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ValueListenableBuilder<Box<Songs>>(
                        valueListenable: box.listenable(),
                        builder: ((context, Box<Songs> allsongs, child) {
                          List<Songs> songListDb = allsongs.values.toList();
                          RecentlyplayedModel? recent;
                          List<MostPlayed> mostsong = MostPlayedBox.getInstance().values.toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: songListDb.length,
                            itemBuilder: (context, int index) => ListTile(
                                title: Text(
                                  songListDb[index].songname != "<unknown>"
                                      ? songListDb[index].songname!
                                      : "Songname not found",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  // songListDb[index].artist != null &&
                                  songListDb[index].artist != "<unknown>"
                                      ? songListDb[index].artist!
                                      : "No Artist",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: QueryArtworkWidget(
                                    id: songListDb[index].id!,
                                    artworkWidth:
                                        MediaQuery.of(context).size.width *
                                            0.35,
                                    artworkHeight:
                                        MediaQuery.of(context).size.height *
                                            0.35,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.contain,
                                    nullArtworkWidget: const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('assets/p5.jpg'),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  audioPlayer.open(
                                    Playlist(
                                        audios: convertedSongs,
                                        startIndex: index),
                                    headPhoneStrategy: HeadPhoneStrategy
                                        .pauseOnUnplugPlayOnPlug,
                                    showNotification: true,
                                    loopMode: LoopMode.playlist,
                                  );
                                  recent = RecentlyplayedModel(
                                    index: index,
                                    id: songListDb[index].id,
                                    artist: songListDb[index].artist,
                                    duration: songListDb[index].duration,
                                    songname: songListDb[index].songname,
                                    songurl: songListDb[index].songurl,
                                  );
                                  addRecently(recent!);
                                 addMostplayed( mostsong[index]);
                               // updateMostPlayed(mostsong[index]);
                           
                                 
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Playscreen(
                                          cuindex: index,
                                        ),
                                      ));
                                },
                                trailing: IconButton(
                                    onPressed: (() {
                                      showOptions(context, index);
                                    }),
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ))),
                          );
                        }),
                      ),
                    )
                  ]),
                ],
              ))),
    );
  }
}
