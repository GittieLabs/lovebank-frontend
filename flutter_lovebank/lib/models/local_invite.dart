import 'package:cloud_firestore/cloud_firestore.dart';

class Invite {
  final Timestamp creationTime;
  final Timestamp expirationTime;
  final String inviteCode;
  final String mobile;
  final String requesterId;

  Invite({this.creationTime, this.expirationTime, this.inviteCode, this.mobile, this.requesterId});

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      creationTime: json['creation_time'],
      expirationTime: json['expiration_time'],
      inviteCode: json['invite_code'],
      mobile: json['mobile'],
      requesterId: json['requester_id'],
    );
  }
}
