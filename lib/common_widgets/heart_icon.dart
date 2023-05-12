import 'package:flutter/material.dart';


class HeartIcon extends StatefulWidget {
  const HeartIcon({super.key});

  @override
  State<HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  bool heartadded = true;
  @override
  Widget build(BuildContext context) {
    // return heartadded == false
    //     ? InkWell(
    //       onTap: (){
    //         setState(() {
    //           if(heartadded==false){
    //             heartadded=true;
    //           }else{
    //             heartadded=false;
    //           }
    //         });
    //       },
    //       child: InkWell(
    //         onTap: () {

    //         },
    //         child: Icon(
    //             Icons.favorite,
    //             color: Color.fromARGB(255, 245, 109, 46),
    //           ),
    //       ),
    //     )
    //     : Icon(
    //         Icons.favorite_outline,
    //             color: Color.fromARGB(255, 245, 109, 46),
    //       );
    return heartadded
        ? IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 245, 109, 46),
            ))
        : IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Color.fromARGB(255, 245, 109, 46),
            ),
          );
  }
}



// import 'package:flutter/material.dart';

// class Hearticon extends StatefulWidget {
//   String temp;
//   bool isfav;
//   Hearticon({super.key, required this.temp, required this.isfav});

//   @override
//   State<Hearticon> createState() => _HearticonState();
// }

// class _HearticonState extends State<Hearticon> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           if (widget.isfav) {
//             widget.isfav = false;
//             favoritelist.value.remove(widget.temp);

//             ScaffoldMessenger.of(context)
//               ..removeCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                   behavior: SnackBarBehavior.floating,
//                   width: 250,
//                   duration: Duration(seconds: 1),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   backgroundColor: Color.fromARGB(255, 191, 96, 250),
//                   content: Center(child: Text('Removed From Favourite'))));
//           } else {
//             widget.isfav = true;
//             favoritelist.value.add(widget.temp);
//             ScaffoldMessenger.of(context)
//               ..removeCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                   behavior: SnackBarBehavior.floating,
//                   width: 250,
//                   duration: Duration(seconds: 1),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   backgroundColor: Color.fromARGB(255, 49, 9, 73),
//                   content: Center(child: Text('Added To Favourite'))));
//           }
//           favoritelist.notifyListeners();
//         });
//       },
//       child: Icon(
//         Icons.favorite,
//         color: (widget.isfav)
//             ? Color.fromARGB(255, 45, 10, 67)
//             : (Color.fromARGB(255, 204, 132, 249)),
//         // size: MediaQuery.of(context).size.width * 0.075,
//         size: 33,
//       ),
//     );
//   }
// }