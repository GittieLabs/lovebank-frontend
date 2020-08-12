import 'dart:async';
import 'package:flutterapp/models/local_invite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/main.dart';

class InviteDataService {

    //The constructor and factory code below makes this a singleton
    InviteDataService._privateConstructor();

    static final InviteDataService _instance = InviteDataService._privateConstructor();

    factory InviteDataService() {
        return _instance;
    }
    //end



    DocumentReference _reference;
    StreamSubscription<DocumentSnapshot> _streamSub;
    dynamic _stream = InviteDataStream();


    void listenTo(String id) {
        if (_streamSub != null) {
            //cancel the old listener if it exists
            _streamSub.cancel();
        }

        _reference = LoveApp.firestore.collection('invites').document(id);

        //create a new listener
        _streamSub = _reference.snapshots().listen( (snapshot) {
            if (snapshot.data == null) {
                _stream.pushData(null);
            } else if (snapshot.data.isNotEmpty) {
                _stream.pushData(Invite.fromJson(snapshot.data));
            }
        });
    }

    Stream<Invite> get inviteData {
        return _stream.stream;
    }
}

class InviteDataStream {

    void pushData(invite) {
        _controller.sink.add(invite);
    }

    final _controller = StreamController<Invite>();

    Stream<Invite> get stream => _controller.stream;

    void dispose() {
        _controller.close();
    }
}
