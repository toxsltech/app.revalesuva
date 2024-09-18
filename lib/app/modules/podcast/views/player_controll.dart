import 'package:audioplayers/audioplayers.dart';

import '../../../../export.dart';

class PlayerControls extends StatefulWidget {

  final AudioPlayer audioPlayer;

  final String url;


  PlayerControls({required this.audioPlayer, required this.url});


  @override

  __PlayerControlsState createState() => __PlayerControlsState();

}


class __PlayerControlsState extends State<PlayerControls> {

  Duration _duration = Duration.zero;

  Duration _position = Duration.zero;

  bool _isPlaying = false;


  @override

  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      widget.audioPlayer.onDurationChanged.listen((Duration d) => setState(() {

        _duration = d;

      }));

      widget.audioPlayer.onPositionChanged.listen((Duration p) => setState(() {

        _position = p;

      }));

      widget.audioPlayer.onPlayerStateChanged.listen((PlayerState s) {

        setState(() {

          _isPlaying = s == PlayerState.playing;

        });

      });

    });

  }


  @override

  Widget build(BuildContext context) {

    return Column(

      children: [

        Slider(

          value: _position.inMilliseconds.toDouble(),

          min: 0.0,

          max: _duration.inMilliseconds.toDouble(),

          onChanged: (value) {

            setState(() {

              _isPlaying = true;

              _position = Duration(milliseconds: value.toInt());

              widget.audioPlayer.seek(_position);

            });

          },

        ),

        Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            IconButton(

              onPressed: () async {

                if (_isPlaying) {

                  widget.audioPlayer.pause();

                } else {

                  await widget.audioPlayer.play(widget.url as Source);

                }

                setState(() {

                  _isPlaying = !_isPlaying;

                });

              },

              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),

            ),

          ],

        ),

      ],

    );

  }

}