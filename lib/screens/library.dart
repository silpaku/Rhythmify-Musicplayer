import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/recentlyplayed.dart';
import 'package:rhythmify1/colorsd.dart';
import '../models/favouritemodel.dart';
import '../models/mostplayed.dart';
import '../models/recentlymodel.dart';
import '../widgets/favorite.dart';
import '../widgets/mostly played.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

final player = AssetsAudioPlayer.withId('0');

class _LibraryState extends State<Library> {
  final List<RecentlyplayedModel> recentsongs = [];
  final box = RecentlyPlayedBox.getInstance();
  late List<RecentlyplayedModel> recent = box.values.toList();
  List<Audio> recsongs = [];

  final List<favourites> likedsongs = [];
  final favourbox = FavouriteBox.getInstance();
  late List<favourites> liked = favourbox.values.toList();
  List<Audio> favsong = [];

  final mostbox = MostPlayedBox.getInstance();

  List<MostPlayed> mostplayedsongs = [];
  List<Audio> songs = [];

  @override
  void initState() {
    final List<RecentlyplayedModel> recentsong = box.values.toList();
    for (var i in recentsong) {
      recsongs.add(Audio.file(i.songurl.toString(),
          metas: Metas(
            artist: i.artist,
            title: i.songname,
            id: i.id.toString(),
          )));
    }
    List<MostPlayed> mostsong = mostbox.values.toList();
    int i = 0;
    for (var element in mostsong) {
      if (element.count > 3) {
        mostplayedsongs.insert(i, element);
        i++;
      }
    }

    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: colord, // Set the color of the back button icon
          ),
          title: Text(
            'LIBRARY',
            style: GoogleFonts.kadwa(
              color: colord,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        'Recently Played',
                        style: GoogleFonts.kadwa(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                       SizedBox(
                        width: screenWidth*0.25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Recently(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'See All',
                            style: GoogleFonts.kadwa(
                                color: colord,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  buildHorizontalListView([]),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Mostly Played',
                          style: GoogleFonts.kadwa(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                         SizedBox(
                          width: screenWidth*0.27,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Mostly(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              'See All',
                              style: GoogleFonts.kadwa(
                                  color: colord,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ValueListenableBuilder<Box<MostPlayed>>(
                        valueListenable: mostbox.listenable(),
                        builder: (context, Box<MostPlayed> mostdb, child) {
                          // List<MostPlayed> mostlysongs=mostdb.values.toList().reversed.toList();
                          return mostplayedsongs.isNotEmpty
                              ? buildHorizontalListViewmostly(
                                  mostly: mostplayedsongs)
                              : const Center(
                                  child: Text(
                                    'mostly Played is Empty',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                        },
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Text(
                          'Favorite Lists',
                          style: GoogleFonts.kadwa(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                         SizedBox(
                          width: screenWidth*0.27,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Favorite(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 46.0),
                            child: Text(
                              'See All',
                              style: GoogleFonts.kadwa(
                                  color: colord,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ValueListenableBuilder<Box<favourites>>(
                        valueListenable: favourbox.listenable(),
                        builder: (context, Box<favourites> dbfavour, child) {
                          List<favourites> likedsongs =
                              dbfavour.values.toList().reversed.toList();
                          return likedsongs.isNotEmpty
                              ? buildHorizontalListViewfavour(
                                  count: likedsongs.length, liked: likedsongs)
                              : const Center(
                                  child: Text(
                                    'favourites Played is Empty',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

//==============================horizondal view========================================
  Widget buildHorizontalListView(List<String> data) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      
      child: ValueListenableBuilder<Box<RecentlyplayedModel>>(
        valueListenable: box.listenable(),
        builder: (context, Box<RecentlyplayedModel> dbrecent, child) {
          List<RecentlyplayedModel> recentsongs =
              dbrecent.values.toList().reversed.toList();
          return recentsongs.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: recentsongs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.3,
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 50,
                      // backgroundColor: Colors.black,
                      child: QueryArtworkWidget(
                        id: recentsongs[index].id!,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        artworkWidth: MediaQuery.of(context).size.width * 0.30,
                        artworkHeight:
                            MediaQuery.of(context).size.height * 0.30,
                        nullArtworkWidget: const CircleAvatar(
                          radius: 52,
                          backgroundImage: AssetImage('assets/p5.jpg'),
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text('Recently Played is Empty',style: TextStyle(color: Colors.white),),
                );
        },
      ),
    );
  }

//========================================================================

  Widget buildHorizontalListViewmostly({required List<MostPlayed> mostly}) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
            itemCount: mostly.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.3,
                  margin: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 52,
                    // backgroundColor: Colors.black,
                    child: QueryArtworkWidget(
                      id: mostly[index].id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      artworkWidth: MediaQuery.of(context).size.width * 0.30,
                      artworkHeight: MediaQuery.of(context).size.height * 0.30,

                      nullArtworkWidget: const CircleAvatar(
                        radius: 52,
                        backgroundImage: AssetImage('assets/p5.jpg'),
                      ),
                      // child: Image(image: AssetImage(data[index])),
                    ),
                  ),
                )));
  }
}
//=================================================================

Widget buildHorizontalListViewfavour(
    {required int count, required List<favourites> liked}) {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      itemCount: count,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.3,
        margin: const EdgeInsets.all(10),
        child: CircleAvatar(
          radius: 59,
          // backgroundColor: Colors.black,
          child: QueryArtworkWidget(
            id: liked[index].id!,
            type: ArtworkType.AUDIO,
            artworkFit: BoxFit.cover,
            artworkWidth: MediaQuery.of(context).size.width * 0.30,
            artworkHeight: MediaQuery.of(context).size.height * 0.30,
            nullArtworkWidget: const CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('assets/p5.jpg'),
            ),
          ),
        ),
        // child: Image(image: AssetImage(data[index])),
      ),
    ),
  );
}












