import 'package:flutter/material.dart';
import 'package:flutterapp/services/userAuthentication.dart';

/* 
LayOut of the Sign In Widget
Also validates the email and passwords before connecting to Firebase Authentication
*/

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final AuthService _authentication = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Variables to Store email. password and error message to show up when they are not valid
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation:0.0,
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: (){
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // SizedBox(height: 2.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(()=>email = val.trim());
                }
              ),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Password should be 8 characters or longer' : null,
                onChanged: (val) {
                  setState(()=>password = val);
                }
              ),
              // SizedBox(height: 1.0),
              RaisedButton(
                color: Colors.blue[200],
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result = await _authentication.registerWithEmail(email, password);
                    if (result == null){
                      setState(()=> error = 'Please enter a valid email');
                    }
                  }
                }
              ),
              // SizedBox(height: 1.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize:10)
              )
            ],
          ),
        ),
      ),
    );
  }
}
