import 'package:flutter/material.dart';

class ChatListaAmiciAdapter extends RecyclerView.Adapter<ChatListaAmiciAdapter.ViewHolder> {
  final Map<String, String> userKeyMap;
  final ChatListaAmici.OnAmicoClickListener clickListener;

  ChatListaAmiciAdapter(this.userKeyMap, this.clickListener);

  @override
  ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
    View itemView = LayoutInflater.from(parent.context).inflate(R.layout.chat_amico_item, parent, false);
    return ViewHolder(itemView);
  }

  @override
  void onBindViewHolder(ViewHolder holder, int position) {
    String userId = userKeyMap.keys.elementAt(position);
    String? username = userKeyMap[userId];
    holder.amico.text = username ?? "";
    holder.chat.setOnClickListener(() {
      if (username != null) {
        clickListener.onAmicoClick(userId, username);
      }
    });
  }

  @override
  int getItemCount() {
    return userKeyMap.length;
  }

  class ViewHolder extends RecyclerView.ViewHolder {
  final TextView amico;
  final ImageView chat;

  ViewHolder(View itemView) : super(itemView) {
  amico = itemView.findViewById(R.id.textViewFriendName);
  chat = itemView.findViewById(R.id.ChatImage);
  }
  }
}
