class User {
  final String userId;
  final String partnerId;
  final String firebaseId;
  final String email;
  final String displayName;
  final String inviteCode;
  final String mobile;
  final int balance;
//  final List tasksCreated;  Not tested yet, will include in the future
//  final List tasksReceived;

  User({this.userId, this.partnerId, this.firebaseId, this.email,
    this.displayName, this.inviteCode, this.mobile, this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      partnerId: json['partner_id'],
      firebaseId: json['firebase_uid'],
      email: json['email'],
      mobile: json['mobile'],
      displayName: json['displayName'],
      inviteCode: json['invite_code'],
      balance: json['balance'],
    );
  }
}
