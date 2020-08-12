import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirestoreMock extends Mock implements Firestore {

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

    List snaps = [];

    final _streamcontroller = StreamController<DocumentSnapshot>();
    Stream<DocumentSnapshot> get _stream => _streamcontroller.stream;

    @override
    Stream<DocumentSnapshot> snapshots({bool includeMetadataChanges = false}) {
        return _stream;
    }

    @override
    Future setData(Map<String, dynamic> data, {bool merge=false}) async {
        pushData(DocumentSnapshotMock(data));
        return;
    }

    void pushData(DocumentSnapshot snap) {
        _streamcontroller.sink.add(snap);
    }

    void dispose() {
        _streamcontroller.close();
    }

}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {
    final data;
    DocumentSnapshotMock(this.data);
}
