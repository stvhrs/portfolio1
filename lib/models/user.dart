class User {
  String id;
  String username;
  String password;
  bool owner;
  User(this.id, this.username, this.password, this.owner);

  factory User.fromMap(Map<String, dynamic> data) {
    return User(data['id_user'], data['username'], data['password'],
        data['status'] == "owner");
  }
  static toMap(User data) {
    return {
      "id_user": data.id,
      "username": data.username,
      "password": data.password,
      "status": data.owner ? "owner" : "admin"
    };
  }
}
