import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PlayBookAudio extends StatefulWidget {
  final String bookimage;
  final String bookaudio;
  final String Bookname;
  final String authorname;
  const PlayBookAudio({
    super.key,
    required this.bookimage,
    required this.bookaudio,
    required this.Bookname,
    required this.authorname,
  });

  @override
  State<PlayBookAudio> createState() => _PlayBookAudioState();
}

class _PlayBookAudioState extends State<PlayBookAudio> {
  Uint8List? bytes;
  late final AudioPlayer audioPlayer;
  late final AudioCache audioCache;

  String? musicUrl;
  Duration duration = const Duration();
  Duration position = const Duration();
  bool playing = false;

  @override
  void initState() {
    super.initState();
    String imageUrl = widget.bookimage;
    musicUrl = widget.bookaudio;
    bytes = base64Decode(imageUrl);
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(prefix: 'audio_cache/');
    print('playing form cache');
    audioCache.load(musicUrl!);
    getAudio();
    audioCache.loadAll([musicUrl!]);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioPlayer.onDurationChanged.listen(null);
    audioPlayer.onPositionChanged.listen(null);
    audioPlayer.onPlayerComplete.listen(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/total baground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Row(
                          children: [
                            Container(
                             width: MediaQuery.of(context).size.width * 0.1, // Adjust as needed
                             height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/relm logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'RELM',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Color.fromRGBO(63, 63, 63, 5),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 106, 74, 74),
                        blurRadius: 15,
                        offset: Offset(4, 4)),
                    BoxShadow(
                        color: Color.fromARGB(255, 12, 55, 55),
                        blurRadius: 15,
                        offset: Offset(-4, -4))
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(bytes!)),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Bookname,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 210, 197, 197)
                                  .withOpacity(0.5),
                              offset: const Offset(2, 2),
                              blurRadius: 2,
                            ),
                          ],
                          decorationStyle: TextDecorationStyle.solid,
                          letterSpacing: 1.5,
                          wordSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.person_2_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 2),
                          Text(
                            widget.authorname,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 210, 197, 197)
                                      .withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 2,
                                ),
                              ],
                              decoration: TextDecoration.none,
                              letterSpacing: 1.0,
                              wordSpacing: 2.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Slider.adaptive(
                min: 0.0,
                activeColor: Colors.black,
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    audioPlayer.seek(Duration(seconds: value.toInt()));
                  });
                },
                onChangeEnd: (double value) {
                  audioPlayer.seek(position);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(position.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      audioPlayer
                          .seek(Duration(seconds: position.inSeconds - 30));
                    },
                    icon: const Icon(Icons.fast_rewind, size: 45),
                  ),
                  InkWell(
                    onTap: () {
                      if (playing) {
                        audioPlayer.pause();
                      } else {
                        if (musicUrl != null) {
                          audioPlayer
                              .play(UrlSource(musicUrl!)); // Play the music
                        }
                      }
                      setState(() {
                        playing = !playing;
                      });
                    },
                    child: Icon(
                      playing
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_filled_outlined,
                      size: 70,
                      color: Color.fromARGB(255, 219, 207, 207),
                      shadows: [
                        Shadow(
                            //  color: Color.fromARGB(255, 0, 0, 0)
                            //           .withOpacity(0.5),
                            //       offset: const Offset(-2, -2),
                            //       blurRadius: 0,
                            color: Color.fromRGBO(63, 63, 63, 20),
                            blurRadius: 15,
                            offset: Offset(4, 4))
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      audioPlayer
                          .seek(Duration(seconds: position.inSeconds + 30));
                    },
                    icon: const Icon(
                      Icons.fast_forward,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getAudio() {
    if (musicUrl != null) {
      audioPlayer.play(UrlSource(musicUrl!));

      audioPlayer.onDurationChanged.listen((Duration d) {
        if (mounted) {
          setState(() {
            duration = d;
          });
        }
      });
      audioPlayer.onPositionChanged.listen((Duration p) {
        if (mounted) {
          setState(() {
            position = p;
          });
        }
      });
      audioPlayer.onPlayerComplete.listen((event) {
        if (mounted) {
          setState(() {
            playing = false;
          });
        }
      });
    } else {
      print('No music URL provided');
    }
  }
}
