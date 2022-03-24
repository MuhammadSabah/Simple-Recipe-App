import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/circle_image.dart';
import '../models/models.dart';

class ProfileScreen extends StatefulWidget {
  static MaterialPage page(User user) {
    return MaterialPage(
      name: AppPages.profilePath,
      key: ValueKey(AppPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  final User user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            SizedBox(height: 20),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
        ListTile(
          title: Text(
            'View raywenderlich.com',
            style: GoogleFonts.lato(fontSize: 18),
          ),
          onTap: () async {
            if (kIsWeb) {
              await launch('https://www.raywenderlich.com/');
            } else {
              Provider.of<ProfileManager>(context, listen: false)
                  .tapOnRaywenderlich(true);
            }
          },
        ),
        SizedBox(height: 8),
        ListTile(
          title: Text(
            'Log out',
            style: GoogleFonts.lato(fontSize: 18),
          ),
          onTap: () {
            // 1
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            // 2
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dark Mode',
            style: GoogleFonts.lato(fontSize: 18),
          ),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: const TextStyle(fontSize: 21),
        ),
        const SizedBox(height: 10.0),
        Text(widget.user.role),
        const SizedBox(height: 12.0),
        Text(
          '${widget.user.points} Points',
          style: const TextStyle(
            fontSize: 26,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
