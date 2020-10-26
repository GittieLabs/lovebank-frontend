import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/services/taskhandler.dart';

import '../../redux/app_state.dart';

class TaskWindow extends StatefulWidget {
  @override
  _TaskWindowState createState() => _TaskWindowState();
}

class _TaskWindowState extends State<TaskWindow> {
  // final _TaskFormKey = GlobalKey<FormState>();
  String description = '';
  int points = 0;
  // final _formKey = GlobalKey<FormState>();
  final _descriptionFormKey = GlobalKey<FormState>();
  final _pointsFormKey = GlobalKey<FormState>();
  Widget buildField(
      String hintText, dynamic validator, dynamic onChanged, bool obscure) {
    return TextFormField(
      key: Key(hintText),
      obscureText: obscure,
      style: TextStyle(fontSize: 12),
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.only(top: 15),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
  @override
  Widget build(BuildContext context) {
    // String description = '';
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    
    Widget descriptionField = buildField("Description", (val) {
      if (int.parse(val) <= 0) {
        return 'please enter a valid score';
      } else {
        return null;
      } }, (val) => (setState(() => description = val)), false);

    Widget pointsField = buildField("Points", (val) {
      if (val.length <= 8) {
        return 'please enter a valid description';
      } else {
        return null;
      } }, (val) => (setState(() => points = int.parse(val))), false);

    return SimpleDialog(
      // key: _formKey,
      title: const Text('Task'),
      children: <Widget>[
        SimpleDialogOption(
          key: _descriptionFormKey,
          child: descriptionField,
        ),
        SimpleDialogOption(
          key : _pointsFormKey,
          child: pointsField,
        ),
        SimpleDialogOption(
          child: StoreConnector<AppState, FirebaseUser>(
                      converter: (store) => store.state.auth,
                      builder: (context, user) {
                        return RaisedButton(
                            child: Text("Create"),
                            onPressed:() async{
                              // if (_descriptionFormKey.currentState.validate() && _pointsFormKey.currentState.validate()){
                                // var idToken = await user.getIdToken();
                                print(user.uid);
                                print(description);
                                print(points);
                                createBtnClicked(user.uid,description,points);
                              // }
                              Navigator.pop(context);
                            }
                        );
                      }
          )
          // RaisedButton(
          //   child: Text("Create"),
            // onPressed:() async{
            //   if (_descriptionFormKey.currentState.validate() && _pointsFormKey.currentState.validate()){
            //     var idToken = await user.getIdToken();
            //     createBtnClicked();
            //   }
            // }
          // )
        ),
        SimpleDialogOption(
          child: CloseButton()
        ),
      ]
    );
  }
}