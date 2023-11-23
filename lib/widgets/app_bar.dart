import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';


class StatusBar extends StatefulWidget {
  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  bool micStatus = false;

  @override
  void initState() {
    super.initState();

    // Listen for mute state changes
    AgoraRtcEngine.onLocalAudioStreamStateChanged = (bool muted) {
      setState(() {
        micStatus = muted;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(
                micStatus ? Icons.mic_off : Icons.mic,
                color: Colors.white,
              ),
              onPressed: toggleMute,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            child: IconButton(
              icon: Icon(
                Icons.call_end,
                color: Colors.white,
              ),
              onPressed: disconnectCall,
            ),
          ),
        ],
      ),
    );
  }

  void toggleMute() {
    AgoraRtcEngine.toggleLocalAudioStream();
  }

  void disconnectCall() {
    Navigator.pop(context);
  }
}
