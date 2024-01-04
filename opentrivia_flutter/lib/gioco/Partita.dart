class Partita {
  final String idPartita;
  final String modalita;
  final String difficolta;
  final String idPlayer1;
  final String namePlayer1;
  final String idPlayer2;
  final String namePlayer2;
  final String? turno;

  Partita({
    required this.idPartita,
    required this.modalita,
    required this.difficolta,
    required this.idPlayer1,
    required this.namePlayer1,
    required this.idPlayer2,
    required this.namePlayer2,
    this.turno,
  });

  factory Partita.fromMap(Map<String, dynamic> map) {
    return Partita(
      idPartita: map['idPartita'],
      modalita: map['modalita'],
      difficolta: map['difficolta'],
      idPlayer1: map['idPlayer1'],
      namePlayer1: map['namePlayer1'],
      idPlayer2: map['idPlayer2'],
      namePlayer2: map['namePlayer2'],
      turno: map['turno'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idPartita': idPartita,
      'modalita': modalita,
      'difficolta': difficolta,
      'idPlayer1': idPlayer1,
      'namePlayer1': namePlayer1,
      'idPlayer2': idPlayer2,
      'namePlayer2': namePlayer2,
      'turno': turno,
    };
  }
}
