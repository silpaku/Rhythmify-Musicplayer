import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget buildHorizontalListView1( assetPaths,  titles) {
  return SizedBox(
    height: 20,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: assetPaths.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    
                    assetPaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                titles[index],
                style: GoogleFonts.kadwa(color: Colors.white,fontSize: 14)
              ),
            ],
          ),
        );
      },
    ),
  );
}



List<String> assetPaths = [
  'assets/s1.jpg',
  'assets/s1.jpg',
  'assets/s1.jpg',
  'assets/s1.jpg',
  'assets/s1.jpg',
  'assets/s1.jpg',
];
List<String> titles = [
  'Title 1',
  'Title 2',
  'Title 3',
  'Title 1',
  'Title 2',
  'Title 3',
];