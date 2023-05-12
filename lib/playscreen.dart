import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/cmmon.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/models/songsmodel.dart';
import 'addfav.dart';

class Playscreen extends StatefulWidget {
  int cuindex;
  Playscreen({super.key, required this.cuindex});

  List<Songs>? songs;
  static int? index = 0;
  static ValueNotifier<int> currentvalue = ValueNotifier<int>(index!);
  static List listnotfier = SongBox.getInstance().values.toList();
  static ValueNotifier<List> currentList = ValueNotifier<List>(listnotfier);

  @override
  State<Playscreen> createState() => _PlayscreenState();
}

class _PlayscreenState extends State<Playscreen> {
  bool playerDone=true;
  final player = AssetsAudioPlayer.withId('0');
  final box = SongBox.getInstance();

  bool isRepeat = false;
  bool isShuffle = false;

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Duration duration = Duration.zero;
    Duration position = Duration.zero;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: colord, // appbar  icon
        ),
        title: Text(
          'PLAYSCREEN',
          style: GoogleFonts.kadwa(color: colord),
        ),
      ),
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: Playscreen.currentvalue,
        builder: (BuildContext context, int value, child) {
          return ValueListenableBuilder<Box<Songs>>(
              valueListenable: box.listenable(),
              builder: (BuildContext context, Box<Songs> allsongs, child) {
                return player.builderCurrent(
                  builder: (context, playing) {
                    return Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.5,
                          child: Column(
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 30)),
                              QueryArtworkWidget(
                                keepOldArtwork: true,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkHeight: 180,
                                artworkWidth: 180,
                                artworkBorder: BorderRadius.circular(10),
                                artworkFit: BoxFit.cover,
                                id: int.parse(playing.audio.audio.metas.id!),
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/p5.jpg',
                                    height: 180,
                                    width: 180,
                                  ),
                                ),
                                type: ArtworkType.AUDIO,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18, right: 33),
                          child: Text(
                            player.getCurrentAudioTitle,
                            // 'Pularam Neram',
                            style: GoogleFonts.kadwa(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 43,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.60,
                                child: Text(
                                  player.getCurrentAudioArtist,
                                  textAlign: TextAlign.center,
                                  //  'Sooraj Santhosh',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.kadwa(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (checkFavour(
                                        playing.index, BuildContext)) {
                                      addfavour(playing.index);
                                    } else if (!checkFavour(
                                        playing.index, BuildContext)) {
                                      removefavour(playing.index);
                                    }
                                    setState(() {});
                                  },
                                  icon:
                                      (checkFavour(playing.index, BuildContext))
                                          ? const Icon(
                                              Icons.favorite_border_outlined,
                                              color: colord,
                                            )
                                          : const Icon(
                                              Icons.favorite,
                                              color: colord,
                                            )),
                              SizedBox(width: screenWidth * 0.10),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0,
                        ),
                        // const Padding(
                        //     padding: EdgeInsets.only(top: 0, bottom:0)),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          child: Container(
                            color: colord,
                            height: screenHeight * 0.446,
                            width: screenWidth * 7,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 80),
                              child: Column(
                                children: [
                                  PlayerBuilder.realtimePlayingInfos(
                                    player: player,
                                    builder: (context, realtimePlayingInfos) {
                                      duration = realtimePlayingInfos
                                          .current!.audio.duration;
                                      position =
                                          realtimePlayingInfos.currentPosition;
                                      return ProgressBar(
                                        thumbColor: Colors.white,
                                        baseBarColor: Colors.black,
                                        progressBarColor: Colors.white,
                                        progress: position,
                                        total: duration,
                                        onSeek: (duration) async {
                                          await player.seek(duration);
                                          // print(
                                          //     'User selected a new time: $duration');
                                        },
                                      );
                                    },
                                  ),
                                  PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, isPlaying) {
                                      return Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: IconButton(
                                              onPressed: (() async {


                                                if(playerDone==true){
                                                  playerDone=false;
                                                  await player.previous();
                                                setState(() {});
                                                playerDone=true;
                                                }

                                              }),
                                              icon: const Icon(
                                                Icons.skip_previous,
                                                color: Colors.black,
                                                size: 50,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 50),
                                            child: IconButton(
                                              onPressed: () async {
                                                player.playOrPause();
                                                setState(
                                                  () {
                                                    isPlaying = !isPlaying;
                                                  },
                                                );
                                              },
                                              icon: (isPlaying)
                                                  ? const Icon(
                                                      Icons.pause_circle,
                                                      color: Colors.black,
                                                      size: 45,
                                                    )
                                                  : const Icon(
                                                      Icons.play_circle,
                                                      color: Colors.black,
                                                      size: 45,
                                                    ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 60),
                                            child: IconButton(
                                              onPressed: () async {
                                                if(playerDone==true){
                                                  playerDone=false;
                                                  await player.next();
                                                  playerDone=true;
                                                }

                                               
                                              },
                                              icon: const Icon(
                                                Icons.skip_next,
                                                color: Colors.black,
                                                size: 50,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, isPlaying) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 54),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (isRepeat) {
                                                      player.setLoopMode(
                                                          LoopMode.none);
                                                      isRepeat = false;
                                                    } else {
                                                      player.setLoopMode(
                                                          LoopMode.single);
                                                      isRepeat = true;
                                                    }
                                                  });
                                                },
                                                icon: isRepeat
                                                    ? const Icon(
                                                        Icons.repeat_one,
                                                        size: 30,
                                                        color: Colors.black,
                                                      )
                                                    : const Icon(
                                                        Icons.repeat,
                                                        size: 30,
                                                        color: Colors.black,
                                                      ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 55),
                                              child: IconButton(
                                                onPressed: () {
                                                  showOptionsplayscreen(
                                                      context, widget.cuindex);
                                                },
                                                icon: const Icon(
                                                  Icons.playlist_add_outlined,
                                                  size: 40,
                                                ),
                                                color: Colors.black,
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 65),
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isShuffle) {
                                                        player.toggleLoop();
                                                        isShuffle = false;
                                                      } else {
                                                        player.toggleShuffle();
                                                        isShuffle = true;
                                                      }
                                                    });
                                                  },
                                                  icon: isShuffle
                                                      ? const Icon(
                                                          Icons
                                                              .shuffle_on_outlined,
                                                          size: 30,
                                                          color: Colors.black,
                                                        )
                                                      : const Icon(
                                                          Icons.shuffle,
                                                          size: 30,
                                                          color: Colors.black,
                                                        ),
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
