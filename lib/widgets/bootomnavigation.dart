import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/models/songsmodel.dart';
import 'package:rhythmify1/playscreen.dart';
import 'package:rhythmify1/screens/home1.dart';
import 'package:rhythmify1/screens/library.dart';
import 'package:rhythmify1/screens/music.dart';
import 'package:rhythmify1/screens/search.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  static int? index = 0;
  static ValueNotifier<int> currentvalue = ValueNotifier<int>(index!);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

final audioPlayer = AssetsAudioPlayer.withId('0');
final box = SongBox.getInstance();
List<Audio> convertAudios = [];

class _BottomNavigationState extends State<BottomNavigation> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  bool isPlaying = false;
  int pageIndex = 0;
  final List<dynamic> tablist = [
    Home1(),
    const Search(),
    const Music(),
    const Library(),
  ];

  @override
  Widget build(BuildContext context) {
  bool playerDoneMini = true;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: screenHeight * 0.878,
        child: Column(
          children: [
            Expanded(
              child: tablist.elementAt(pageIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            selectedItemColor: colord,
            unselectedItemColor: colord,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            currentIndex: pageIndex,
            onTap: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_add_check_outlined),
                  label: 'Music'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: 'Library'),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(0),
        child: ValueListenableBuilder(
          valueListenable: BottomNavigation.currentvalue,
          builder: (context, int value, child) {
            return ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: ((context, Box<Songs> allsongs, child) {
                  return audioPlayer.builderCurrent(
                      builder: ((context, playing) {
                    return Container(
                      height: screenHeight * 0.075,
                      width: screenWidth * 0.98,
                      decoration: const BoxDecoration(
                        color: colord,
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          log('hlooooo');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      Playscreen(cuindex: value))));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              QueryArtworkWidget(
                                quality: 100,
                                artworkWidth:
                                    MediaQuery.of(context).size.width * 0.13,
                                artworkHeight:
                                    MediaQuery.of(context).size.height * 0.060,
                                keepOldArtwork: true,
                                artworkBorder: BorderRadius.circular(10),
                                id: int.parse(playing.audio.audio.metas.id!),
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    'assets/p2.jpg',
                                    fit: BoxFit.cover,
                                    height: screenHeight * 0.06,
                                    width: screenWidth * 0.16,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      audioPlayer.getCurrentAudioTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      audioPlayer.getCurrentAudioArtist,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 3),
                              PlayerBuilder.isPlaying(
                                  player: audioPlayer,
                                  builder: ((context, isPlaying) {
                                    return IconButton(
                                        onPressed: (() async {
                                          if (playerDoneMini == true) {
                                            playerDoneMini = false;
                                            await audioPlayer.previous();
                                            playerDoneMini = true;
                                          }
                                        }),
                                        icon: const Icon(
                                          Icons.skip_previous_outlined,
                                          color: Colors.black,
                                          size: 30,
                                        ));
                                  })),
                              PlayerBuilder.isPlaying(
                                  player: audioPlayer,
                                  builder: ((context, isPlaying) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              audioPlayer.playOrPause();
                                              setState(
                                                () {
                                                  isPlaying = !isPlaying;
                                                },
                                              );
                                            },
                                            icon: (isPlaying)
                                                ? const Icon(
                                                    Icons.pause,
                                                    color: Colors.white,
                                                    size: 19,
                                                  )
                                                : const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white,
                                                    size: 19,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })),
                              IconButton(
                                onPressed: () async{
                                  log(' i am next');
                                  if (playerDoneMini == true) {
                                    playerDoneMini = false;
                                   await audioPlayer.next();
                                    playerDoneMini = true;
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
                }));
          },
        ),
      ),
    );
  }
}
