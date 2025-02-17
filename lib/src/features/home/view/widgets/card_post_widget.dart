import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikigram/src/core/utils/string_constants.dart';
import 'package:wikigram/src/core/utils/text_styles.dart';
import 'package:wikigram/src/features/home/model/post_entity.dart';

class CardPostWidget extends StatefulWidget {
  final PostEntity post;
  const CardPostWidget({
    required this.post,
    super.key,
  });

  @override
  State<CardPostWidget> createState() => _CardPostWidgetState();
}

class _CardPostWidgetState extends State<CardPostWidget> {
  double volume = 1.0;
  double pitch = 0.7;
  double rate = 0.5;
  PlayState playState = PlayState.started;
  FlutterTts tts = FlutterTts();
  @override
  void initState() {
    super.initState();
    initTts();
  }

  Future<void> initTts() async {
    await _stop();
    await tts.awaitSpeakCompletion(true);
    await tts.setVolume(volume);
    await tts.setSpeechRate(rate);
    await tts.setPitch(pitch);
    _speak(widget.post.description);
  }

  Future<void> _speak(String text) async {
    setState(() {
      playState = PlayState.started;
    });
    await tts.speak(text);
  }

  Future<void> _stop() async {
    setState(() {
      playState = PlayState.paused;
    });
    await tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: widget.post.imageUrl == null
              ? Image.asset(
                  'assets/images/default_image.webp',
                  fit: BoxFit.cover,
                )
              : Image.network(
                  widget.post.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.title,
                style: title,
              ),
              Text(
                widget.post.description,
                style: description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () {
                      _launchInBrowser(
                        widget.post.title,
                      );
                    },
                    child: const Text(
                      StringConstants.readMore,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (playState == PlayState.started) {
                            _stop();
                          } else {
                            _speak(widget.post.description);
                          }
                        },
                        icon: playState == PlayState.started
                            ? const Icon(Icons.pause_circle_filled_rounded)
                            : const Icon(Icons.play_circle_filled_rounded),
                      ),
                      IconButton(
                        onPressed: () {
                          sharePost();
                        },
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(String title) async {
    final url = Uri.parse(
      'https://pt.wikipedia.org/wiki/${widget.post.title.replaceAll(' ', '_')}',
    );
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> sharePost() async {
    await Share.share(
      'https://pt.wikipedia.org/wiki/${widget.post.title.replaceAll(' ', '_')}',
    );
  }
}

enum PlayState { started, paused }
