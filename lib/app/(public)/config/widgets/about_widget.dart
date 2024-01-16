// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yuno/app/core/widgets/channel_card.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';

import '../../../core/assets/images.dart' as img;
import '../../../core/widgets/sponsor_card.dart';

class AboutWidget extends StatelessWidget {
  AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Yuno is a minimalist, open-source retro gaming frontend designed to deliver a nostalgic and efficient gaming experience. This project aims to create a simplified interface for accessing and playing your favorite retro games.',
            textAlign: TextAlign.justify,
          ),
          TextButton(
            onPressed: _seeMoreLaunchUrl,
            child: const Text('See more'),
          ),
          const Gap(12),
          Text(
            'Sponsors',
            style: theme.textTheme.titleMedium,
          ),
          const Gap(12),
          Wrap(
            children: [
              SponsorsCard(
                image: img.fteamPNG,
                sponsorName: 'Fteam',
                onTap: _goToFteamSite,
              ),
              SponsorsCard(
                image: img.flutterandoPNG,
                sponsorName: 'Flutterando',
                onTap: _goToFluterrandoSite,
              )
            ],
          ),
          const Gap(14),
          Text(
            'Channels',
            style: theme.textTheme.titleMedium,
          ),
          const Gap(12),
          Wrap(
            children: [
              ChannelCard(
                imageIcon: img.youtubePNG,
                channelName: 'Flutterando',
                onTap: _goToFlutterandoChannel,
              )
            ],
          ),
          const Gap(120)
        ],
      ),
    );
  }

  final Uri _url = Uri.https('github.com', '/Flutterando/yuno');
  Future<void> _seeMoreLaunchUrl() {
    return openUrl(_url);
  }

  final Uri _urlFluterrandoSite = Uri.https('flutterando.com.br');
  Future<void> _goToFluterrandoSite() {
    return openUrl(_urlFluterrandoSite);
  }

  final Uri _urlFteamSite = Uri.https('fteam.dev');
  Future<void> _goToFteamSite() {
    return openUrl(_urlFteamSite);
  }

  final Uri _urlFlutterandoCanal =
      Uri.https('youtube.com', '/channel/UCplT2lzN6MHlVHHLt6so39A');
  Future<void> _goToFlutterandoChannel() {
    return openUrl(_urlFlutterandoCanal);
  }
}
