import 'package:flutter/material.dart';
import 'package:flutterapp/userAuthentication.dart';

/* 
LayOut of the Sign In Widget
Also validates the email and passwords before connecting to Firebase Authentication
*/

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authentication = AuthService();
  
  //Variables to Store email, passWord and Error Message to be shown when they are not valid
  String email = '';
  String password = '';
  String error ='';

  //formKey to validate the sign in form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation:0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign Up'),
            onPressed: (){
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                onChanged: (val) {
                  setState(()=>email = val.trim());
                }
              ),
              SizedBox(height: 5.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Password should be 8 characters or longer' : null,
                onChanged: (val) {
                  setState(()=>password = val);
                }
              ),
              SizedBox(height: 5.0),
              RaisedButton(
                color: Colors.blue[500],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result = await _authentication.signInWithEmail(email, password);
                    if (result == null){
                      setState(()=> error = 'Please enter a valid email');
                    }
                  }
                }
              ),
              SizedBox(height: 1.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize:14)
              )
            ],
          ),
        ),
      ),
    );
  }
}