import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/widgets/bootomnavigation.dart';
import 'package:rhythmify1/models/recentlymodel.dart';
import 'package:rhythmify1/playscreen.dart';
import 'cmmon.dart';

class Recently extends StatefulWidget {
  const Recently({
    super.key,
  });

  @override
  State<Recently> createState() => _RecentlyState();
}

final player = AssetsAudioPlayer.withId('0');

class _RecentlyState extends State<Recently> {
  final List<RecentlyplayedModel> recentsongs = [];
  final box = RecentlyPlayedBox.getInstance();
  late List<RecentlyplayedModel> recent = box.values.toList();
  List<Audio> recsongs = [];

  @override
  void initState() {
    final List<RecentlyplayedModel> recentsong =
        box.values.toList().reversed.toList();
    for (var i in recentsong) {
      recsongs.add(Audio.file(i.songurl.toString(),
          metas: Metas(
            artist: i.artist,
            title: i.songname,
            id: i.id.toString(),
          )));
    }
    setState(() {});
    super.initState();
  }

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
          'RECENTLY PLAYED',
          style: GoogleFonts.kadwa(
            color: colord,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ValueListenableBuilder<Box<RecentlyplayedModel>>(
            valueListenable: box.listenable(),
            builder: (context, Box<RecentlyplayedModel> dbrecent, child) {
              List<RecentlyplayedModel> recentsongs =
                  dbrecent.values.toList().reversed.toList();
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recentsongs.length,

                  //================================================================================================
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        audioPlayer.open(Playlist(audios: recsongs,startIndex: index),
                        showNotification: true,
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                        loopMode: LoopMode.playlist
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Playscreen(cuindex: index),));
                      },
                        title: Text(
                          recentsongs[index].songname!,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          recentsongs[index].artist!,
                          style: const TextStyle(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          radius: 27,
                          child: QueryArtworkWidget(
                            id: recentsongs[index].id!,
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
                            )));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
