import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UsersAdapter extends RecyclerView.Adapter<UsersAdapter.ViewHolder> {
  final Map<String, String> userKeyMap;
  late FirebaseDatabase database;

  UsersAdapter(this.userKeyMap);

  @override
  ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
    final itemView = LayoutInflater.from(parent.context).inflate(R.layout.lista_amici_friend_item, parent, false);
    return ViewHolder(itemView);
  }

  @override
  void onBindViewHolder(ViewHolder holder, int position) {
    final userId = userKeyMap.keys.elementAt(position);
    final username = userKeyMap[userId];

    holder.textViewFriendName.text = username;

    checkIfUserIsFriend(userId, (isFriend) {
      if (isFriend) {
        holder.addFriendButton.visibility = View.INVISIBLE;
        holder.isFriendCheck.visibility = View.VISIBLE;
      } else {
        holder.addFriendButton.visibility = View.VISIBLE;
        holder.isFriendCheck.visibility = View.INVISIBLE;
      }
    });
  }

  void checkIfUserIsFriend(String friendUserId, Function(bool) callback) {
    database = FirebaseDatabase.instance;
    bool isFriend = false;

    final uid = FirebaseAuth.instance.currentUser?.uid.toString();
    final amiciRef = database.reference.child("users").child(uid).child("amici");
    amiciRef.addListenerForSingleValueEvent(ValueEventListener(
      onDataChange: (snapshot) {
        for (var userSnapshot in snapshot.children) {
          final userId = userSnapshot.key;
          if (userId == friendUserId) {
            isFriend = true;
            break;
          }
        }
        callback(isFriend);
      },
      onCancelled: (error) {
        callback(false);
      },
    ));
  }

  @override
  int getItemCount() {
    return userKeyMap.length;
  }

  class ViewHolder extends RecyclerView.ViewHolder {
  final TextView textViewFriendName;
  final ImageView addFriendButton;
  final ImageView isFriendCheck;

  ViewHolder(View itemView) : super(itemView) {
  textViewFriendName = itemView.findViewById(R.id.textViewFriendName);
  addFriendButton = itemView.findViewById(R.id.clickableImage);
  isFriendCheck = itemView.findViewById(R.id.CheckImage);

  addFriendButton.setOnClickListener(() {
  final position = adapterPosition;
  if (position != RecyclerView.NO_POSITION) {
  addFriendButton.visibility = View.INVISIBLE;
  isFriendCheck.visibility = View.VISIBLE;

  final userId = userKeyMap.keys.elementAt(position);
  final username = userKeyMap[userId];

  database = FirebaseDatabase.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();
  final AmiciRef = database.reference.child("users").child(uid).child("amici");
  AmiciRef.child(userId).setValue(username);
  }
  });
  }
  }
}
