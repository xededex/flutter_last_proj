import 'package:flutter/material.dart';
import 'package:music_player/player.dart';
import 'package:music_player/Track.dart';

class Tracks extends StatelessWidget {
  const Tracks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TracksPage(),
    );
  }
}

class TracksPage extends StatefulWidget {
  const TracksPage({super.key});

  @override
  State<TracksPage> createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {

  List<Track> trackList = [
    Track("Acidic", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Acidic.mp3"),
    Track("Adderall", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Adderall.mp3"),
    Track("De Sade", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - De Sade.mp3"),
    Track("Finale", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Finale.mp3"),
    Track("H377", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - H377.mp3"),
    Track("Heirloom", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Heirloom.mp3"),
    Track("Hive Mind", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Hive Mind.mp3"),
    Track("Medicine for the Dead", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Medicine for the Dead.mp3"),
    Track("The Chapeltown Rag", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - The Chapeltown Rag.mp3"),
    Track("The Dying Song (Time To Sing)", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - The Dying Song (Time To Sing).mp3"),
    Track("Warranty", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Warranty.mp3"),
    Track("Yen", "Slipknot", "res/albums-icon.png", "../audio/The End So Far/Slipknot - Yen.mp3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
          children: [
            Expanded(
              flex:5,
              child: Container(
                //color: Colors.deepOrange,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 12,
                  itemBuilder: (context, index){
                    return Card(
                        child: ListTile(
                          title: Text(trackList[index].title),
                          subtitle: Text(trackList[index].subtitle),
                          leading: Image(image: AssetImage(trackList[index].icon)),
                          trailing: const Icon(Icons.play_arrow_rounded),
                          onTap: ()=>{
                            //Navigation.push()
                          },
                        )
                    );
                  },
                ),
              )
            ),
            Expanded(
              flex: 1,
              child: Container(
                //color: Colors.red,
                child: PlayerView(tracks: trackList),
              ),
            )
          ],
        )
      );
  }
}