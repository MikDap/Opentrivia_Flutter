/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FriendsAdapter extends RecyclerView.Adapter<FriendsAdapter.ViewHolder> {
  final List<String> friendsList;

  FriendsAdapter(this.friendsList);

  @override
  ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
    View itemView = LayoutInflater.from(parent.context).inflate(R.layout.lista_amici_friend_item, parent, false);
    return ViewHolder(itemView);
  }

  @override
  void onBindViewHolder(ViewHolder holder, int position) {
    String friendName = friendsList[position];
    holder.textViewFriendName.text = friendName;
  }

  @override
  int getItemCount() {
    return friendsList.length;
  }

  class ViewHolder extends RecyclerView.ViewHolder {
  final TextView textViewFriendName;
  final ImageView addFriendButton;
  final ImageView isFriendCheck;

  ViewHolder(View itemView) :
  textViewFriendName = itemView.findViewById(R.id.textViewFriendName),
  addFriendButton = itemView.findViewById(R.id.clickableImage),
  isFriendCheck = itemView.findViewById(R.id.CheckImage) {
  addFriendButton.visibility = View.INVISIBLE;
  isFriendCheck.visibility = View.INVISIBLE;
  }
  }
}
*/