class Band {
  late String id;
  late String name;
  late int votes;
  Band({required this.id, required this.name, required this.votes});

  factory Band.fromMap(Map obj) => Band(
        id: obj['id'],
        name: obj['name'],
        votes: obj['votes'],
      );
}
