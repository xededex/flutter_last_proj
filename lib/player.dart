import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import 'Track.dart';

class PlayerView extends StatefulWidget {
  List<Track> tracks;

  PlayerView({super.key, required this.tracks});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  bool playing = true;
  late List<Track> tracks;
  int curentTrack = 0;

  late Uint8List audio;
  bool complite = false;
  AudioPlayer audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  void toast(String message, {Key? textKey}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, key: textKey),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tracks = widget.tracks;
    setSource(AssetSource(tracks.first.asset));
  }

  Future<void> setSource(Source source) async {
    await audioPlayer.setSource(source);
    toast('Completed setting source.', textKey: const Key('toast-source-set'));
    audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(tracks[curentTrack].icon),
          const SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    tracks[curentTrack].title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tracks[curentTrack].subtitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          //color: Colors.yellow,
                          width: 200,
                          child: Row(children: [
                            IconButton(
                                onPressed: () => {
                                      setState(() => {
                                            if (curentTrack == 0)
                                              curentTrack = tracks.length - 1
                                            else
                                              curentTrack--,
                                            setSource(AssetSource(tracks[curentTrack].asset))
                                          })
                                    },
                                icon: const Icon(Icons.skip_previous_rounded)),
                            const SizedBox(
                              width: 30,
                            ),
                            IconButton(
                                onPressed: () => {
                                      setState(() => {
                                            playing = !playing,
                                            if (!playing)
                                              {audioPlayer.pause()}
                                            else
                                              {audioPlayer.resume()}
                                          })
                                    },
                                icon: !playing == false
                                    ? const Icon(Icons.pause_rounded)
                                    : const Icon(Icons.play_arrow_rounded)),
                            const SizedBox(
                              width: 30,
                            ),
                            IconButton(
                                onPressed: () => {
                                      setState(() => {
                                            if (curentTrack ==
                                                tracks.length - 1)
                                              curentTrack = 0
                                            else
                                              curentTrack++,
                                            setSource(AssetSource(tracks[curentTrack].asset))
                                          })
                                    },
                                icon: const Icon(Icons.skip_next_rounded)),
                          ])))
                ],
              ))
        ],
      ),
    ));
  }
}
