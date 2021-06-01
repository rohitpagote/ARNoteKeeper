import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_unity_example/models.dart';
import 'package:flutter_unity_example/icons.dart';
import 'package:flutter_unity_example/styles.dart';
import 'package:flutter_unity_example/utils.dart';

import 'drawer_filter.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

/// Navigation drawer for the app.
class _AppDrawerState extends State<AppDrawer> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) => Consumer<NoteFilter>(
        builder: (context, filter, _) => Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _drawerHeader(context),
              if (isNotIOS) const SizedBox(height: 25),
              DrawerFilterItem(
                icon: AppIcons.thumbtack,
                title: 'Notes',
                isChecked: filter.noteState == NoteState.unspecified,
                onTap: () {
                  filter.noteState = NoteState.unspecified;
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              DrawerFilterItem(
                icon: AppIcons.archive_outlined,
                title: 'Archive',
                isChecked: filter.noteState == NoteState.archived,
                onTap: () {
                  filter.noteState = NoteState.archived;
                  Navigator.pop(context);
                },
              ),
              DrawerFilterItem(
                icon: AppIcons.delete_outline,
                title: 'Trash',
                isChecked: filter.noteState == NoteState.deleted,
                onTap: () {
                  filter.noteState = NoteState.deleted;
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              DrawerFilterItem(
                icon: Icons.scatter_plot_outlined,
                title: 'AR Section',
                isChecked: filter.noteState == NoteState.AR,
                onTap: () {
                  print('RESULT1');
                  _checkBiometric().then((result) {
                    print('RESULT:$result');
                    if (result) {
                      filter.noteState = NoteState.AR;
                      Navigator.pop(context);
                    }
                  });
                  print('RESULT2');
                },
              ),
              const Divider(),
              DrawerFilterItem(
                icon: AppIcons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  Navigator.popAndPushNamed(context, '/settings');
                },
              ),
              DrawerFilterItem(
                icon: Icons.help_outline,
                title: 'About',
                // onTap: () => launch('https://github.com/xinthink/flutter-keep'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/about');
                },
              ),
            ],
          ),
        ),
      );

  Widget _drawerHeader(BuildContext context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: kHintTextColorLight,
                fontSize: 26,
                fontWeight: FontWeights.light,
                // letterSpacing: -2.5,
              ),
              children: [
                const TextSpan(
                  text: 'ARNoteKeeper',
                  style: TextStyle(
                    color: kAccentColorLight,
                    fontWeight: FontWeights.medium,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                // const TextSpan(text: ' Keep'),
              ],
            ),
          ),
        ),
      );
  Future _checkBiometric() async {
    // check for biometric availability
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biometrics $e");
    }

    // print("biometric is available: $canCheckBiometrics");

    // enumerate biometric technologies
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    // print("following biometrics are available");
    if (availableBiometrics != null) {
      if (availableBiometrics.isNotEmpty) {
        availableBiometrics.forEach((ab) {
          print("\tBIOMETRIC: $ab");
        });
      }
    } else {
      print("no biometrics are available");
    }

    // authenticate with biometrics
    bool authenticated = false;
    try {
      print('AuthenticatedA');

      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Authenticate to use this feature',
          useErrorDialogs: true,
          stickyAuth: false,
          androidAuthStrings: AndroidAuthMessages(signInTitle: "AR"));
    } catch (e) {
      print("error using biometric auth: $e");
    }
    print('AuthenticatedB');
    setState(() {
      isAuth = authenticated ? true : false;
    });
    print('Authenticated:$authenticated');
    return isAuth;

    // print("authenticated: $authenticated");
  }
}
