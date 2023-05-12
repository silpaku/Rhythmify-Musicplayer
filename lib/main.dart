import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmify1/functions/dbfunctions.dart';
import 'package:rhythmify1/models/favouritemodel.dart';
import 'package:rhythmify1/models/mostplayed.dart';
import 'package:rhythmify1/models/playlistmodel.dart';
import 'package:rhythmify1/models/recentlymodel.dart';
import 'package:rhythmify1/models/songsmodel.dart';

import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);
  Hive.registerAdapter(favouritesAdapter());
  openfavourite();
  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddb();
  Hive.registerAdapter(RecentlyplayedModelAdapter());
  openrecentlyplayeddb();
  Hive.registerAdapter(PlaylistSongsAdapter());
  await Hive.openBox<PlaylistSongs>('playlist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}

