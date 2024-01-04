import 'package:flutter/material.dart';

class ListaAmiciFragment extends StatefulWidget {
  @override
  _ListaAmiciFragmentState createState() => _ListaAmiciFragmentState();
}

class _ListaAmiciFragmentState extends State<ListaAmiciFragment> {
  late Button addFriendButton;
  late RecyclerView recyclerView;
  late List<String> friendsList;
  late FriendsAdapter adapter;
  late String uid;
  late DatabaseReference amiciRef;

  @override
  void initState() {
    super.initState();
    addFriendButton = Button();
    recyclerView = RecyclerView();
    friendsList = [];
    adapter = FriendsAdapter(friendsList);
    uid = FirebaseAuth.instance.currentUser?.uid.toString();
    amiciRef = FirebaseDatabase.instance.reference.child("users").child(uid).child("amici");

    addFriendButton.setOnClickListener(() {
      Navigator.of(context).pushNamed('action_listaAmiciFragment2_to_aggiungiAmico2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          addFriendButton,
          recyclerView,
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Aggiungi il codice di dispose, se necessario
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final layoutManager = LinearLayoutManager(context);
    recyclerView.layoutManager = layoutManager;

    recyclerView.adapter = adapter;

    // Aggiungi un ValueEventListener per ottenere i dati degli amici da Firebase
    amiciRef.addValueEventListener(ValueEventListener(
      onDataChange: (snapshot) {
        friendsList.clear(); // Svuota la lista prima di popolarla con i nuovi dati
        for (amicoSnapshot in snapshot.children) {
          final amico = amicoSnapshot.getValue(String) as String?;
          if (amico != null) {
            friendsList.add(amico);
          }
        }
        adapter.notifyDataSetChanged(); // Aggiorna la RecyclerView quando i dati cambiano
      },
      onCancelled: (error) {
        // Gestisci l'errore, se necessario
      },
    ));
  }
}
