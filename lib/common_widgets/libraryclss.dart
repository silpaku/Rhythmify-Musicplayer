import 'package:flutter/material.dart';
Widget buildHorizontalListView(List<String> data) {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        height:MediaQuery.of(context).size.height *0.6,
        width: MediaQuery.of(context).size.width *0.3,
        margin:const EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundImage: AssetImage(data[index]),
        ),
        // child: Image(image: AssetImage(data[index])),
      ),
    ),
  );
}
