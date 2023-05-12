import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/widgets/bootomnavigation.dart';
import 'package:rhythmify1/models/mostplayed.dart';
import 'package:rhythmify1/models/songsmodel.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final box = SongBox.getInstance();
  final mostbox = MostPlayedBox.getInstance();
  List<SongModel> fetchSongs = [];
  List<SongModel> allsongs = [];
  @override
  void initState() {
    home();
    requestStoragepermission();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/p1.jpg'),
          ),
          Center(
            child: Text(
              'Rhythmify',
              style: GoogleFonts.kadwa(
                  textStyle: const TextStyle(color: colord, fontSize: 30)),
            ),
          ),
        ],
      ),
    );
  }

  Future home() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        ));
  }

//function for permission request
  Future<void> requestStoragepermission() async {
    //
    if (!kIsWeb) {
      bool status = await _audioQuery.permissionsStatus();
      //request when no premission
      if (!status) {
        await _audioQuery.permissionsRequest();
        fetchSongs = await _audioQuery.querySongs();
        for (var i in fetchSongs) {
          if (i.fileExtension == "mp3") {
            allsongs.add(i);
          }
        }
        for (var i in allsongs) {
          await box.add(Songs(
              id: i.id,
              songname: i.album,
              artist: i.artist,
              duration: i.duration,
              songurl: i.uri));
        }
        for (var items in allsongs) {
          mostbox.add(
            MostPlayed(
                songname: items.title,
                songurl: items.uri!,
                duration: items.duration!,
                artist: items.artist!,
                count: 0,
                id: items.id),
          );
        }
      }
    }
  }
}
