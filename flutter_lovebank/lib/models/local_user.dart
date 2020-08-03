class User {
  final String partnerId;
  final String email;
  final String displayName;
  final String mobile;
  final int balance;
//  final List tasksCreated;  Not tested yet, will include in the future
//  final List tasksReceived;

  User({this.partnerId, this.email,
    this.displayName, this.mobile, this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      partnerId: json['partnerId'],
      email: json['email'],
      mobile: json['mobile'],
      displayName: json['displayName'],
      balance: json['balance'],
    );
  }
}
