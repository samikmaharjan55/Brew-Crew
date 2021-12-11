class TheUser {
  final String uid;

  TheUser({required this.uid}); // constructor of uid

}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.sugars,
      required this.strength,
      required this.name});
}
