import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../../../../../resources/resources.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String? url;
  const AudioPlayerWidget({super.key, this.url});

  @override
  AudioPlayerWidgetState createState() => AudioPlayerWidgetState();
}

class AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late PlayerController playerController;
  bool isPlayerLoading = false;
  bool isPlaying = false;
  bool isPrepared = false;

  Future<void> _playPauseAudio(String url) async {
    if (isPlaying) {
      await playerController.pausePlayer();
      setState(() {
        isPlaying = false;
      });
      return;
    }

    if (!isPrepared) {
      setState(() {
        isPlayerLoading = true;
      });

      try {
        String path = await _getTemporaryPathFromUrl(url);
        await playerController.preparePlayer(
          path: path,
          shouldExtractWaveform: true,
        );
        isPrepared = true;
      } catch (e) {
        print("Error preparing audio: $e");
        setState(() {
          isPlayerLoading = false;
        });
        return;
      } finally {
        setState(() {
          isPlayerLoading = false;
        });
      }
    }

    await playerController.startPlayer();
    setState(() {
      isPlaying = true;
    });

    playerController.onCompletion.listen((_) {
      setState(() {
        isPlaying = false;
        playerController.stopPlayer();
      });
    });
  }

  Future<String> _getTemporaryPathFromUrl(String url) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = Uri.parse(url).pathSegments.last.split("/").last;
      final tempFilePath = '${tempDir.path}/$fileName';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = File(tempFilePath);
        await file.writeAsBytes(response.bodyBytes);
        return tempFilePath;
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }

  @override
  void initState() {
    playerController = PlayerController();
    super.initState();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      height: 60,
      decoration: BoxDecoration(
          color: R.appColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () =>
                isPlayerLoading ? null : _playPauseAudio(widget.url ?? ""),
          ),
          Expanded(
            flex: 20,
            child: isPlayerLoading
                ? SpinKitThreeInOut(
                    color: R.appColors.white,
                  )
                : isPrepared
                    ? AudioFileWaveforms(
                        size: Size(MediaQuery.of(context).size.width, 45),
                        playerController: playerController,
                        enableSeekGesture: true,
                        playerWaveStyle: PlayerWaveStyle(showSeekLine: false),
                        waveformType: WaveformType.long,
                        waveformData: playerController.waveformData,
                      )
                    : SizedBox(),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
