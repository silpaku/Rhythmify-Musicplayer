import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/cmmon.dart';
import 'package:rhythmify1/models/songsmodel.dart';

import '../playscreen.dart';



class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
final TextEditingController searchcontroller = TextEditingController();

class _SearchState extends State<Search> {
  late List<Songs> dbsongs = [];
  List<Audio> allsongs = [];

  late List<Songs> searchlist = List.from(dbsongs);
  bool istaped = true;

  final box = SongBox.getInstance();
  @override
  void initState() {
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'SEARCH',
          style: GoogleFonts.kadwa(
            color: const Color.fromARGB(255, 245, 109, 46),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: searchcontroller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 245, 109, 46),
                ),
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.clear,
                    color: Color.fromARGB(255, 245, 109, 46),
                  ),
                  onTap: () {
                    searchcontroller.clear();
                  },
                ),
                hintText: 'What Do You Looking For...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                updateSearch(value);
              },
            ),
             SizedBox(
              height: screenHeight *0.02,
            ),
            searchlist.isEmpty
                ? const Text(
                    'No Results Found',
                    style: TextStyle(color: Colors.white),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchlist.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          // NowPlayingSlider.enteredvalue.value = index;
                          player.open(
                            Audio.file(searchlist[index].songurl!,
                                metas: Metas(
                                    title: searchlist[index].songname,
                                    artist: searchlist[index].artist,
                                    id: searchlist[index].id.toString())),
                            showNotification: true,
                          );
                          FocusScope.of(context).unfocus();
                          Navigator.push(
                            
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  Playscreen(cuindex: index,),
                              ));
                        },
                        title: Text(
                          searchlist[index].songname!,
                          style: GoogleFonts.kadwa(
                              color: Colors.white, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          searchlist[index].artist ?? "No Artist",
                          style: GoogleFonts.kadwa(
                              color: Colors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        leading: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(40),
                            id: searchlist[index].id!,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 30,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/p5.jpg',
                                  fit: BoxFit.cover,
                                  width: screenWidth * 0.14,
                                  height: screenHeight * 0.14,
                                  // height: 60,
                                ),
                              ),
                            )),
                        trailing:IconButton(onPressed: (() {
                          showOptions(context, index);
                        }), icon:const Icon(Icons.more_vert,
                        color: Colors.white,
                        ))
                        
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  updateSearch(String value) {
    setState(() {
      searchlist = dbsongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();

      allsongs.clear();
      for (var item in searchlist) {
        allsongs.add(Audio.file(item.songurl.toString(),
            metas: Metas(title: item.songname, id: item.id.toString())));
      }
    });
  }
}
