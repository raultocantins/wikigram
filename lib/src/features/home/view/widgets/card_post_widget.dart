import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikigram/src/core/utils/string_constants.dart';
import 'package:wikigram/src/core/utils/text_styles.dart';
import 'package:wikigram/src/features/home/model/post_entity.dart';

class CardPostWidget extends StatelessWidget {
  final PostEntity post;
  const CardPostWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: post.imageUrl == null
              ? Image.asset(
                  'assets/images/default_image.webp',
                  fit: BoxFit.cover,
                )
              : Image.network(
                  post.imageUrl ?? '',
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
                post.title,
                style: title,
              ),
              Text(
                post.description,
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
                        post.title,
                      );
                    },
                    child: const Text(
                      StringConstants.readMore,
                    ),
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
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(String title) async {
    final url = Uri.parse(
      'https://pt.wikipedia.org/wiki/${post.title.replaceAll(' ', '_')}',
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
      'https://pt.wikipedia.org/wiki/${post.title.replaceAll(' ', '_')}',
    );
  }
}
