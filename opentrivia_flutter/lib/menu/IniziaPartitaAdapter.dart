import 'package:flutter/material.dart';

class IniziaPartitaAdapter extends StatelessWidget {
  final Map<String, String> friendsList;
  final IniziaPartitaState iniziaPartitaFragment;

  IniziaPartitaAdapter(this.friendsList, this.iniziaPartitaFragment);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendsList.length,
      itemBuilder: (context, position) {
        final friendId = friendsList.keys.elementAt(position);
        final friendName = friendsList[friendId];

        return IniziaPartitaItem(
          friendId: friendId,
          friendName: friendName,
          iniziaPartitaFragment: iniziaPartitaFragment,
        );
      },
    );
  }
}

class IniziaPartitaItem extends StatelessWidget {
  final String friendId;
  final String? friendName;
  final IniziaPartitaState iniziaPartitaFragment;

  IniziaPartitaItem({
    required this.friendId,
    required this.friendName,
    required this.iniziaPartitaFragment,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(friendName ?? ''),
      onTap: () {
        iniziaPartitaFragment.nomeAvversario(friendName ?? '');

        for (int i = 0; i < iniziaPartitaFragment.friendsList.length; i++) {
          if (i == iniziaPartitaFragment.adapterPosition) {
            iniziaPartitaFragment.avversarioID = friendId;
            iniziaPartitaFragment.avversarioNome = friendName ?? '';
          }
          iniziaPartitaFragment.checkVisibility[i] =
              i == iniziaPartitaFragment.adapterPosition;
        }

        iniziaPartitaFragment.setState(() {});
      },
      trailing: Visibility(
        visible: iniziaPartitaFragment.checkVisibility[position],
        child: Icon(Icons.check),
      ),
    );
  }
}
