import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythmify1/cmmon.dart';
import 'package:rhythmify1/colorsd.dart';
import 'package:rhythmify1/settings/popup.dart';
import 'package:share_plus/share_plus.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color:colord, // Set the color of the back button icon
        ),
        title: Text('SETTINGS',style: GoogleFonts.kadwa(color:colord),),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
                 showDialog(
                    context: context,
                    builder: (builder) {
                      return settingmenupopup(mdFilename: 'privacy.md');
                    },
                  );
              // showDialog(
              //   context: context,
              //   builder: (_) => AlertDialog(
              //     title: Text('Privacy and Policy',style: GoogleFonts.kadwa(color:colord),),
              //     content: const Text('This is the privacy and policy '),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  const Icon(Icons.privacy_tip_sharp,color:colord,),
                  const SizedBox(width: 30,),
                  Text('Privacy And Policy',style: GoogleFonts.kadwa(fontSize: 16,color: colord),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                    context: context,
                    builder: (builder) {
                      return settingmenupopup(
                          mdFilename: 'terms.md');
                    },
                  );
              // showDialog(
              //   context: context,
              //   builder: (_) => AlertDialog(
              //     title: Text('Terms and Services',style: GoogleFonts.kadwa(color:colord),),
              //     content: const Text('This is the terms and services'),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  const Icon(Icons.bookmark_outline_outlined,color:colord,),
                  const SizedBox(width: 30,),
                  Text('Terms And Services',style: GoogleFonts.kadwa(fontSize: 16,color: colord),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: colord,
                  title: Text('About Rhythmify',style: GoogleFonts.kadwa(color:Colors.black),),
                   content:about() //const Text('This is the about Rhythmify '),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  const Icon(Icons.circle_notifications,color:colord,),
                  const SizedBox(width: 30,),
                  Text('About Rhythmify',style: GoogleFonts.kadwa(fontSize: 16,color: colord),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                // const Icon(Icons.share,color:colord,),
                // const SizedBox(width: 30,),
                IconButton(onPressed: (() {
                  Share.share('jndkjnjk');
                }), icon:Icon(Icons.share,color: colord,),
                ),
                Text('Share',
                
                style: GoogleFonts.kadwa(fontSize: 16,color:colord),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
