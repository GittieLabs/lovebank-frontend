class User {
  final String userId;
  final String partnerId;
  final String email;
  final String displayName;
  final String mobile;
  final int balance;
  final String profilePic;
  final bool darkMode;
  final bool task_acceptance_notifications;
  final bool task_completion_notifications;
  final bool task_reminder_notifications;
//  final List tasksCreated;  Not tested yet, will include in the future
//  final List tasksReceived;

  User(
      {this.userId,
      this.partnerId,
      this.email,
      this.displayName,
      this.mobile,
      this.balance,
      this.profilePic,
      this.darkMode,
      this.task_acceptance_notifications,
      this.task_completion_notifications,
      this.task_reminder_notifications});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        partnerId: json['partnerId'],
        email: json['email'],
        mobile: json['mobile'],
        displayName: json['displayName'],
        balance: json['balance'],
        profilePic: json['profilePic'],
        darkMode: json['darkMode'],
        task_acceptance_notifications: json['task_acceptance_notifications'],
        task_completion_notifications: json['task_completion_notifications'],
        task_reminder_notifications: json['task_reminder_notifications']);
  }
}
