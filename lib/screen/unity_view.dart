import 'package:flutter/material.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:flutter_unity_example/model/note.dart';
import 'package:flutter_unity_example/service/notes_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_unity_example/models.dart' show CurrentUser;
import 'package:flutter_unity_example/services.dart';

class UnityViewPage extends StatefulWidget {
  Note note;
  NoteState state;
  UnityViewPage({Key key, this.state, this.note}) : super(key: key);

  @override
  _UnityViewPageState createState() => _UnityViewPageState();
}

class _UnityViewPageState extends State<UnityViewPage> with CommandHandler {
  UnityViewController unityViewController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<CurrentUser>(context).data.uid;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          Container(
            color: Colors.black,
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(
                    context,
                    NoteStateUpdateCommand(
                        id: widget.note.id,
                        uid: uid,
                        from: widget.note.state,
                        to: NoteState.AR,
                        dismiss: true));
              },
              child: Text('Place here'),
            ),
          )
        ],
      ),
      body: UnityView(
        onCreated: onUnityViewCreated,
        onReattached: onUnityViewReattached,
        onMessage: onUnityViewMessage,
      ),
    );
  }

  void onUnityViewCreated(UnityViewController controller) {
    print('onUnityViewCreated');

    unityViewController = controller;
    controller.send(
      'AR Session Origin',
      'Setnotetext',
      '<size=100%><b>' +
          widget.note.title +
          '</b></b></size><br><br><size=80%>' +
          widget.note.content +
          '</size>',
    );
    //Enter number for the specific color it is according to kNoteColors
    const List<Color> kNoteColors = [
      Colors.white,
      Color(0xFFF28C82),
      Color(0xFFFABD03),
      Color(0xFFFFF476),
      Color(0xFFCDFF90),
      Color(0xFFA7FEEB),
      Color(0xFFCBF0F8),
      Color(0xFFAFCBFA),
      Color(0xFFD7AEFC),
      Color(0xFFFDCFE9),
      Color(0xFFE6C9A9),
      Color(0xFFE9EAEE),
    ];
    var idx = kNoteColors.indexOf(widget.note.color);
    //example 0=Colors.white and 11=Color(0xFFE9EAEE)
    //phele run karke dekhra kya kya hai toh OKAY?
    controller.send(
      'AR Session Origin', //title
      'Setnotecolor', //string
      idx.toString(), //color
    );
  }

  void onUnityViewReattached(UnityViewController controller) {
    print('onUnityViewReattached');
    super.dispose();
  }

  void onUnityViewMessage(UnityViewController controller, String message) {
    print('onUnityViewMessage');
    print(message);
  }

  void _updateNoteState(uid, NoteState state) {
    print('Old State:$state');
    // new note, update locally
    if (widget.note.id == null) {
      widget.note.updateWith(state: state);
      return;
    }
    print('New State:${widget.note.state}');
    // otherwise, handles it in a undoable manner
    processNoteCommand(
        _scaffoldKey.currentState,
        NoteStateUpdateCommand(
          id: widget.note.id,
          uid: uid,
          from: widget.note.state,
          to: state,
        ));
  }
}
