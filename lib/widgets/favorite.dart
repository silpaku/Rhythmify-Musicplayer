import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/addfav.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/playscreen.dart';
import 'package:rhythmify1/widgets/bootomnavigation.dart';
import 'package:rhythmify1/models/favouritemodel.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

final player = AssetsAudioPlayer.withId('0');

class _FavoriteState extends State<Favorite> {
  final List<favourites> likedsongs = [];
  final box = FavouriteBox.getInstance();
  late List<favourites> liked = box.values.toList();

  List<Audio> favsong = [];
  @override
  void initState() {
    final List<favourites> likedsong = box.values.toList().reversed.toList();
    for (var i in likedsong) {
      favsong.add(Audio.file(i.songurl.toString(),
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
          color: colord, // appbar icon color
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Favourite Lists',
          style: GoogleFonts.kadwa(
            color: colord,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<favourites>>(
              valueListenable: box.listenable(),
              builder: (context, Box<favourites> dbfavour, child) {
                List<favourites> likedsongs =
                    dbfavour.values.toList().reversed.toList();
                log('we are liked songs');
                log(likedsongs.toString());
                return ListView.builder(
                  itemCount: likedsongs.length,

                  //===================================================================================
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        audioPlayer.open(
                          Playlist(audios: favsong, startIndex: index),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    Playscreen(cuindex: index))));
                      },
                      title: Text(
                        likedsongs[index].songname!,
                        style: GoogleFonts.kadwa(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        likedsongs[index].artist!,
                        style: GoogleFonts.kadwa(
                            fontSize: 12, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      leading: CircleAvatar(
                        radius: 27,
                        child: QueryArtworkWidget(
                          id: likedsongs[index].id!,
                          artworkWidth:
                              MediaQuery.of(context).size.width * 0.30,
                          artworkHeight:
                              MediaQuery.of(context).size.height * 0.30,
                          type: ArtworkType.AUDIO,
                          artworkFit: BoxFit.contain,
                          nullArtworkWidget: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/p2.jpg'),
                          ),
                        ),
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              onTap: () {
                                deletefav(index, context);
                              },
                              child: Text('Remove song '),
                              value: 'option1',
                            ),
                          ];
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          String message = '';
                          if (value == 'option1') {
                            message = 'Song removed from favourite';
                          }
                          // else if (value == 'option2') {
                          //   message = 'Added to playlist';
                          // }

                          final snackBar = SnackBar(
                            content: Text(message),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
