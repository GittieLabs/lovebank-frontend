import 'dart:async';
import 'package:flutterapp/models/local_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {

    //The constructor and factory code below makes this a singleton
    UserDataService._privateConstructor();

    static final UserDataService _instance = UserDataService._privateConstructor();

    factory UserDataService() {
        return _instance;
    }
    //end



    DocumentReference _reference;
    StreamSubscription<DocumentSnapshot> _streamSub;
    dynamic _stream = UserDataStream();


    void listenTo(String id) {
        if (_streamSub != null) {
            //cancel the old listener if it exists
            _streamSub.cancel();
        }

        _reference = Firestore.instance.collection('users').document(id);

        //create a new listener
        _streamSub = _reference.snapshots().listen( (snapshot) {
            if (snapshot.data.isNotEmpty) {
                _stream.pushData(User.fromJson(snapshot.data));
            }
        });
    }

    Stream<User> get userData {
        return _stream.stream;
    }
}

class UserDataStream {

    void pushData(user) {
        _controller.sink.add(user);
    }

    final _controller = StreamController<User>();

    Stream<User> get stream => _controller.stream;

    void dispose() {
        _controller.close();
    }
}
