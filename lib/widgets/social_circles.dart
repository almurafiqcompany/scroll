import 'package:al_murafiq/models/profile_compaine.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SocialCircle extends StatelessWidget {
  final List<Social> socail;

  SocialCircle({Key key, this.socail}) : super(key: key);

  // ignore: always_specify_types
  final List<Map<String, dynamic>> socialData = [
    {'icon': FontAwesomeIcons.whatsapp, 'type': 'whatsapp'},
    {'icon': FontAwesomeIcons.instagram, 'type': 'instagram'},
    {'icon': FontAwesomeIcons.facebookF, 'type': 'facebook'},
    {'icon': FontAwesomeIcons.snapchat, 'type': 'snapshat'},
    {'icon': FontAwesomeIcons.googlePlus, 'type': 'googleplus'},
    {'icon': FontAwesomeIcons.youtube, 'type': 'youtube'},
    {'icon': MdiIcons.web, 'type': 'website'},
    {'icon': FontAwesomeIcons.linkedin, 'type': 'linked_in'},
    {'icon': FontAwesomeIcons.ellipsisH, 'type': 'other'},
  ];

  final Map<String, dynamic> oo = {
    'whatsapp': FontAwesomeIcons.whatsapp,
    'instagram': FontAwesomeIcons.instagram,
    'facebook': FontAwesomeIcons.facebookF,
    'snapshat': FontAwesomeIcons.snapchat,
    'googleplus': FontAwesomeIcons.googlePlus,
    'website': MdiIcons.web,
    'twitter': FontAwesomeIcons.twitter,
    'linked_in': FontAwesomeIcons.linkedin,
    'youtube': FontAwesomeIcons.youtube,
    'other': FontAwesomeIcons.ellipsisH,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables, always_specify_types
        children: List.generate(
          socail.length,
          (int index) => socail[index].icon_type != null
              ? GestureDetector(
                  onTap: () async {
                    await launch(socail[index].link);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFFCCD2DB),
                      radius: 25,
                      child: FaIcon(
                        // ignore: unnecessary_string_interpolations
                        //socialData[index]['icon'],
                        oo[socail[index].icon_type],
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
