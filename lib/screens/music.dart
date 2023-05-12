import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmify1/cmmon.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/functions/addplaylist.dart';
import 'package:rhythmify1/models/playlistmodel.dart';
import 'package:rhythmify1/widgets/playlist.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final playlistbox = PlaylistSongsbox.getInstance();
  late List<PlaylistSongs> playlistsongs = playlistbox.values.toList();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: colord, // Set the color of the back button icon
        ),
        title: Text(
          'PLAYLIST',
          style: GoogleFonts.kadwa(color: colord, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: (() {
                showPlaylistOptionsadd(context);
              }),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(8.0)),
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Add New Playlist',
                        style: GoogleFonts.kadwa(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.71,
              // color: Colors.red,
              child: ValueListenableBuilder<Box<PlaylistSongs>>(
                valueListenable: playlistbox.listenable(),
                builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                  List<PlaylistSongs> playlistsong =
                      playlistsongs.values.toList();
                  return playlistsong.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: playlistsong.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                title: Text(
                                  playlistsong[index].playlistname!,
                                  style: GoogleFonts.kadwa(
                                      color: Colors.white, fontSize: 16),
                                ),
                                leading: const Image(
                                    image: AssetImage('assets/h5.jpg')),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      onPressed: (() {
                                        showPlaylistEditOption(context, index);
                                      }),
                                      icon: const Icon(Icons.edit),
                                      color: Colors.white,
                                    ),
                                    IconButton(
                                      onPressed: (() {
                                        showPlaylistDeleteConfirmation(
                                            context, index);
                                      }),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Playlist(
                                          index: index,
                                          playlistname:
                                              playlistsong[index].playlistname,
                                        ),
                                      ));
                                },
                              ),
                            );
                          }),
                        )
                      : const Center(
                          child: Text('Playlist is empty',
                              style: TextStyle(color: Colors.white38)),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
