import 'package:flutter/material.dart';

class WatchListScreen extends StatelessWidget {
  static const String routeName = "WatchList";

  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.yellow,
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class WatchListScreen extends StatelessWidget {
//   static const String routeName = "WatchedList Screen";
//   final firestoreInstance = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('قائمة المشاهدة'),
//         ),
//         body: WatchedList(),
//       ),
//     );
//   }
// }
//
// class WatchedList extends StatefulWidget {
//   @override
//   _WatchedListState createState() => _WatchedListState();
// }
//
// class _WatchedListState extends State<WatchedList> {
//   TextEditingController movieController = TextEditingController();
//
//   void addMovieToWatchedList(String movieName) async {
//     await firestoreInstance.collection('watched_list').add({
//       'movie_name': movieName,
//     });
//     setState(() {
//       movieController.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: movieController,
//                   decoration: InputDecoration(labelText: 'اسم الفيلم'),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   addMovieToWatchedList(movieController.text);
//                 },
//                 child: Text('إضافة'),
//               ),
//             ],
//           ),
//         ),
//         StreamBuilder<QuerySnapshot>(
//           stream: firestoreInstance.collection('watched_list').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }
//             var movies = snapshot.data!.docs;
//             List<Widget> movieWidgets = [];
//             for (var movie in movies) {
//               var movieName = movie['movie_name'];
//               var movieWidget = ListTile(
//                 title: Text(movieName),
//               );
//               movieWidgets.add(movieWidget);
//             }
//             return Expanded(
//               child: ListView(
//                 children: movieWidgets,
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
