class User {
  final String userId;
  final String partnerId;
  final String email;
  final String displayName;
  final String mobile;
  final int balance;
  final String profilePic;
//  final List tasksCreated;  Not tested yet, will include in the future
//  final List tasksReceived;

  User({this.userId, this.partnerId, this.email,
    this.displayName, this.mobile, this.balance, this.profilePic});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      partnerId: json['partnerId'],
      email: json['email'],
      mobile: json['mobile'],
      displayName: json['displayName'],
      balance: json['balance'],
      profilePic: json['profilePic']
    );
  }
}
