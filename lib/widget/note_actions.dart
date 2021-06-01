import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_unity_example/icons.dart';
import 'package:flutter_unity_example/models.dart';
import 'package:flutter_unity_example/services.dart';
import 'package:flutter_unity_example/styles.dart';
import 'package:share/share.dart';

/// Provide actions for a single [Note], used in a [BottomSheet].
class NoteActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final note = Provider.of<Note>(context);
    final state = note?.state;
    final id = note?.id;
    final uid = Provider.of<CurrentUser>(context)?.data?.uid;

    final textStyle = TextStyle(
      color: kHintTextColorLight,
      fontSize: 16,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (id != null && state < NoteState.archived)
          ListTile(
            leading: const Icon(AppIcons.archive_outlined),
            title: Text('Archive', style: textStyle),
            onTap: () => Navigator.pop(
                context,
                NoteStateUpdateCommand(
                  id: id,
                  uid: uid,
                  from: state,
                  to: NoteState.archived,
                  dismiss: true,
                )),
          ),
        if (id != null && state < NoteState.AR)
          ListTile(
            leading: const Icon(Icons.scatter_plot_outlined),
            title: Text('Place with AR', style: textStyle),
            onTap: () => Navigator.pop(
                context,
                NoteStateUpdateCommand(
                  id: id,
                  uid: uid,
                  from: state,
                  to: NoteState.AR,
                  dismiss: true,
                )),
          ),
        if (state == NoteState.AR)
          ListTile(
            leading: const Icon(Icons.scatter_plot_outlined),
            title: Text('Retrieve from AR', style: textStyle),
            onTap: () => Navigator.pop(
                context,
                NoteStateUpdateCommand(
                  id: id,
                  uid: uid,
                  from: state,
                  to: NoteState.unspecified,
                )),
          ),
        if (state == NoteState.archived)
          ListTile(
            leading: const Icon(AppIcons.unarchive_outlined),
            title: Text('Unarchive', style: textStyle),
            onTap: () => Navigator.pop(
                context,
                NoteStateUpdateCommand(
                  id: id,
                  uid: uid,
                  from: state,
                  to: NoteState.unspecified,
                )),
          ),
        if (id != null && state != NoteState.deleted)
          ListTile(
            leading: const Icon(AppIcons.delete_outline),
            title: Text('Delete', style: textStyle),
            onTap: () => Navigator.pop(
                context,
                NoteStateUpdateCommand(
                  id: id,
                  uid: uid,
                  from: state,
                  to: NoteState.deleted,
                  dismiss: true,
                )),
          ),

//        if (id != null) ListTile(
//          leading: const Icon(AppIcons.copy),
//          title: Text('Make a copy', style: textStyle),
//        ),
        if (state == NoteState.deleted)
          ListTile(
            leading: const Icon(Icons.restore),
            title: Text('Restore', style: textStyle),
            onTap: () => Navigator.pop(
                context,
                NoteStateUpdateCommand(
                  id: id,
                  uid: uid,
                  from: state,
                  to: NoteState.unspecified,
                )),
          ),
        ListTile(
          leading: const Icon(AppIcons.share_outlined),
          title: Text('Share', style: textStyle),
          onTap: () {
            Share.share(
                '${note.title.trim() != null ? note.title.trim() : ''}\n(On: ${DateTime.now().toIso8601String().substring(0, 10)})\n\n${note.content != null ? note.content : ''}');
          },
        ),
      ],
    );
  }
}
