import 'package:flutter/material.dart';
import 'package:wipap/components/rounded_button.dart';
import 'package:wipap/components/validator.dart';
import 'package:flutter/cupertino.dart';
// import 'package:internship_management_system/screens/login_screen.dart';
// import 'package:internship_management_system/services/network.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();
  }


  void _showMessage(Map<String, dynamic> messages){

    // var keys = Object.key
    List<Widget> children = [];

    messages.forEach((key, value)
    {
      children.add(Text("$key: $value", style: TextStyle(color: Colors.red),));
    });
    
    final snackbar = SnackBar(content: Container(
      height: 100.0,
      child: ListView(children: children,
      ),
    ), action: SnackBarAction(label: 'Close', onPressed: (){}), backgroundColor: Colors.white,);
    globalkey.currentState.showSnackBar(snackbar);
  }

  _register () async {

      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState.validate()) {

      final data = {
        "name": '$name',
        "email": '$email',
        "phone": '$phone',
        "password": '$password',
        "program": "$program",
        "level": "$level",
        "index_no": '$indexNo'
      };
        //Go to registration screen.
        http.Response response = await http.post(
              'http://internship-management-system.herokuapp.com/api/register', body: data, headers: {
           /*      'Content-type': 'application/json', */
                'Accept':'application/json'
              }
              
        );
       var body = json.decode(response.body);

            setState(() {
              isLoading = false;
            });


        if(response.statusCode == 200){

          /*   Navigator.pushNamed(context, LoginScreen.id); */
        }else{
             _showMessage(body['errors']); 
        }

      } else {
        setState(() {
          _validate = true;
          isLoading = false;
        });
      }
  }

  String name;
  String email;
  String indexNo;
  String password;
  String confirmPassword;
  var program;
  var level;
  String phone;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final globalkey = GlobalKey<ScaffoldState>();
 
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalkey,
      appBar: AppBar(
        title: Text('Register'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: _validate,
          child: ListView(
            children: <Widget>[
            
              ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.blueGrey,
                    ),
                    title:    TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                      ),
                      validator: Validator(field: 'Name').makeValidator,
                    ),
                  ),
            
              SizedBox(
                height: 8.0,
              ),
               ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                      title:  TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                          ),
                          validator: Validator(field: 'Email').makeValidator,
                        ),
                    ),
              SizedBox(
                height: 8.0,
              ),
            ListTile(
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blueGrey,
                ),
                title:    TextFormField(
                    onChanged: (value) {
                      indexNo = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter index number',
                    ),
                    validator: Validator(field: 'Index number').makeValidator,
                    ),
                  ),
             
              SizedBox(
                height: 8.0,
              ),
                 ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.blueGrey,
                ),
                title:  TextFormField(
                    onChanged: (value) {
                      phone = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter phone',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: Validator(field: 'Phone').makeValidator,
                    ),
                  ),
                       
              SizedBox(
                height: 8.0,
              ), 


              ListTile(
                leading: Icon(
                  Icons.vpn_key,
                  color: Colors.blueGrey,
                ),
                title:   TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your password.',
                    ),
                    validator: Validator(field: 'Password').makeValidator,
                ),
              ),
            
             
              SizedBox(
                height: 8.0,
              ),

                ListTile(
                leading: Icon(
                  Icons.vpn_key,
                  color: Colors.blueGrey,
                ),
                title:    TextFormField(obscureText: true,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm your password',
                ),
                validator:  (confirmPassword){
                              if(confirmPassword.isEmpty)
                              {
                                   return 'Confirm Passowrd is required';
                              }
                              else if(confirmPassword != password)
                              {

                                return 'Password mismatch';
                              }else
                                  return null;
                              }
              ),
              ),
            
             
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonText: isLoading ? 'Registering...' : 'Register',
                onPressed: isLoading ? null : _register,
                buttonColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
