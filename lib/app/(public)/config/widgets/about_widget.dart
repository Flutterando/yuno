// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuno/app/core/widgets/channel_card.dart';

import '../../../core/assets/images.dart' as img;
import '../../../core/widgets/sponsor_card.dart';

class AboutWidget extends StatelessWidget {
  AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'YuNO',
            style: GoogleFonts.lemon(
              fontSize: 47.5,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            child: Text(
              'Yuno is a minimalist, open-source retro gaming frontend designed to deliver a nostalgic and efficient gaming experience. This project aims to create a simplified interface for accessing and playing your favorite retro games.',
              textAlign: TextAlign.justify,
            ),
          ),
          TextButton(
            onPressed: _seeMoreLaunchUrl,
            child: const Text('See more'),
          ),
          const Gap(12),
          Text(
            'Sponsors',
            style: Theme.of(context).textTheme.displaySmall,
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
          const Gap(12),
          Text(
            'Channels',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Wrap(
            children: [
              ChannelCard(
                imageIcon: img.youtubePNG,
                channelName: 'Flutterando',
                onTap: _goToFlutterandoChannel,
              )
            ],
          ),
          const Gap(12)
        ],
      ),
    );
  }

  final Uri _url = Uri.https('github.com', '/Flutterando/yuno');
  Future<void> _seeMoreLaunchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception("Cold't launch");
    }
  }

  final Uri _urlFluterrandoSite = Uri.https('flutterando.com.br');
  Future<void> _goToFluterrandoSite() async {
    if (!await launchUrl(_urlFluterrandoSite)) {
      throw Exception("Cold't launch");
    }
  }

  final Uri _urlFteamSite = Uri.https('fteam.dev');
  Future<void> _goToFteamSite() async {
    if (!await launchUrl(_urlFteamSite)) {
      throw Exception("Cold't launch");
    }
  }

  final Uri _urlFlutterandoCanal =
      Uri.https('youtube.com', '/channel/UCplT2lzN6MHlVHHLt6so39A');
  Future<void> _goToFlutterandoChannel() async {
    if (!await launchUrl(_urlFlutterandoCanal)) {
      throw Exception("Cold't launch");
    }
  }
}
