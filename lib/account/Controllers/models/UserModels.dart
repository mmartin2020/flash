class Usermodels {
  Usermodels({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
  });

  // factory map

  Usermodels.fromUser(map)
      : this(
            email: map['email'],
            name: map['name'],
            phone: map['phone'],
            uid: map['uid']);

  // variables
  String? name;
  String? email;
  String? phone;
  String? uid;

  // map to server

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone, 'uid': uid};
  }
}
