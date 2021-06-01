import 'package:flutter_unity_example/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:notekeeper/services/sharedPref.dart';

class About extends StatefulWidget {
  // Function(Brightness brightness) changeTheme;
  // Home({Key key, Function(Brightness brightness) changeTheme})
  //     : super(key: key) {
  //   this.changeTheme = changeTheme;
  // }
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String selectedTheme;
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   if (Theme.of(context).brightness == Brightness.dark) {
    //     selectedTheme = 'dark';
    //   } else {
    //     selectedTheme = 'light';
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // GestureDetector(
              //   behavior: HitTestBehavior.opaque,
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Container(
              //       padding:
              //           const EdgeInsets.only(top: 24, left: 24, right: 24),
              //       child: Icon(Icons.arrow_back)),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 24, right: 24),
                //child: buildHeaderWidget(context),
              ),
              // buildCardWidget(Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text('App Theme',
              //         style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24)),
              //     Container(
              //       height: 20,
              //     ),
              //     Row(
              //       children: <Widget>[
              //         Radio(
              //           value: 'light',
              //           groupValue: selectedTheme,
              //           onChanged: handleThemeSelection,
              //         ),
              //         Text(
              //           'Light theme',
              //           style: TextStyle(fontSize: 18),
              //         )
              //       ],
              //     ),
              //     Row(
              //       children: <Widget>[
              //         Radio(
              //           value: 'dark',
              //           groupValue: selectedTheme,
              //           onChanged: handleThemeSelection,
              //         ),
              //         Text(
              //           'Dark theme',
              //           style: TextStyle(fontSize: 18),
              //         )
              //       ],
              //     ),
              //   ],
              // )),
              buildCardWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "ARNoteKeeper",
                      style: TextStyle(
                          fontFamily: 'ZillaSlab',
                          fontSize: 24,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              )),
              buildCardWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Text('About app',
                  //     style: TextStyle(
                  //         fontFamily: 'ZillaSlab',
                  //         fontSize: 24,
                  //         color: Theme.of(context).primaryColor)),
                  // Container(
                  //   height: 40,
                  // ),
                  Center(
                    child: Text('Developed by'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'ARNoteKeeper Team (RAP)',
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 20),
                    ),
                  )),
                  Container(
                    alignment: Alignment.center,
                    child: OutlineButton.icon(
                      icon: Icon(Icons.email),
                      label: Text('EMAIL',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              color: Colors.grey.shade500)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onPressed: _launchGmail,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Center(
                    child: Text('Made With'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlutterLogo(
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Flutter',
                              style: TextStyle(
                                  fontFamily: 'ZillaSlab', fontSize: 24),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ))
        ],
      ),
    );
  }

  Widget buildCardWidget(Widget col) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                color: Colors.black.withAlpha(25),
                blurRadius: 10)
          ]),
      margin: EdgeInsets.fromLTRB(26, 5, 26, 8),
      padding: EdgeInsets.all(12),
      child: col,
    );
  }

  Widget buildHeaderWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 16, left: 8),
      child: Text(
        'Settings',
        style: TextStyle(
            fontFamily: 'ZillaSlab',
            fontWeight: FontWeight.w700,
            fontSize: 36,
            color: Theme.of(context).primaryColor),
      ),
    );
  }

  // void handleThemeSelection(String value) {
  //   setState(() {
  //     selectedTheme = value;
  //   });
  //   if (value == 'light') {
  //     widget.changeTheme(Brightness.light);
  //   } else {
  //     widget.changeTheme(Brightness.dark);
  //   }
  //   setThemeinSharedPref(value);
  // }

  void openEmail() {
    launch('https://www.flutter.dev');
  }

  _launchGmail() async {
    if (await canLaunch("mailto: rohitpagote12@gmail.com")) {
      await launch("mailto: rohitpagote12@gmail.com");
    } else {
      throw 'Could Not Launch';
    }
  }
}
