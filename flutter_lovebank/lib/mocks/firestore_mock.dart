import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';

class FirestoreMock extends Mock implements Firestore {

    //The constructor and factory code below makes this a singleton
    FirestoreMock._privateConstructor();

    static final FirestoreMock instance = FirestoreMock._privateConstructor();

    factory FirestoreMock() {
        return instance;
    }
    //end


    Map collections = {};

    @override
    CollectionReference collection(String path) {
        if (!collections.containsKey(path)) {
            collections[path] = CollectionReferenceMock();
        }
        return collections[path];
    }

}

class CollectionReferenceMock extends Mock implements CollectionReference {

    Map documents = {};

    @override
    DocumentReference document([String path]){
        if (!documents.containsKey(path)) {
            documents[path] = DocumentReferenceMock();
        }
        return documents[path];
    }

}

class DocumentReferenceMock extends Mock implements DocumentReference {

    DocumentSnapshot latestsnap = DocumentSnapshotMock({});

    final _streamcontroller = StreamController<DocumentSnapshot>.broadcast();
    Stream<DocumentSnapshot> get _stream => _streamcontroller.stream;

    DocumentReferenceMock() {
        _streamcontroller.onListen = () {
            pushData(latestsnap);
        };
    }

    @override
    Stream<DocumentSnapshot> snapshots({bool includeMetadataChanges = false}) {
        return _stream;
    }

    @override
    Future setData(Map<String, dynamic> data, {bool merge=false}) async {
        DocumentSnapshot snap = DocumentSnapshotMock(data);
        latestsnap = snap;
        pushData(snap);
        return;
    }

    void pushData(DocumentSnapshot snap) {
        _streamcontroller.sink.add(snap);
        print(snap.data);
    }

    void dispose() {
        _streamcontroller.close();
    }

}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {
    Map _data = {};
    DocumentSnapshotMock(Map<String, dynamic> data){
        this._data = data;
    }

    @override
    Map<String, dynamic> get data => _data;
}
