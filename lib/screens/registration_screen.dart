import 'package:flutter/material.dart';
import 'package:wipap/components/rounded_button.dart';
import 'package:wipap/components/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:wipap/screens/login_screen.dart';
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

  void _showMessage(Map<String, dynamic> messages) {
    // var keys = Object.key
    List<Widget> children = [];

    messages.forEach((key, value) {
      children.add(Text(
        "$key: $value",
        style: TextStyle(color: Colors.red),
      ));
    });

    final snackbar = SnackBar(
      content: Container(
        height: 100.0,
        child: ListView(
          children: children,
        ),
      ),
      action: SnackBarAction(label: 'Close', onPressed: () {}),
      backgroundColor: Colors.white,
    );
    globalkey.currentState.showSnackBar(snackbar);
  }

  _register() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState.validate()) {
      final data = {
        "name": '$name',
        "email": '$email',
        "phone": '$phone',
        "password": '$password',
        "account_type": "personal",
  
      };
      //Go to registration screen.
      http.Response response = await http.post(
          'https://wipap.herokuapp.com/api/register',
          body: data,
          headers: {
            'Accept': 'application/json'
          });
      var body = json.decode(response.body);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        /*   Navigator.pushNamed(context, LoginScreen.id); */
      } else {
        _showMessage(body['errors']);
      }
    } else {
      setState(() {
        _validate = true;
        isLoading = false;
      });
    }
  }

   _organizationRegister() async {
    setState(() {
      isLoading = true;
    });

    if (_organizationalformKey.currentState.validate()) {
      final data = {
        "company_name": '$organizationName',
        "email": '$organizationEmail',
        "phone": '$phone',
        "password": '$password',
        "location": "$location",
        "account_type": "company",
      };
      //Go to registration screen.
      http.Response response = await http.post(
          'https://wipap.herokuapp.com/api/register',
          body: data,
          headers: {
            /*      'Content-type': 'application/json', */
            'Accept': 'application/json'
          });
      var body = json.decode(response.body);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
         Navigator.pushNamed(context, LoginScreen.id); 
      } else {
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
  String password;
  String confirmPassword;
  String phone;
  bool isLoading = false;
  String organizationName;
  String organizationEmail;
  String location;

  final _formKey = GlobalKey<FormState>();

  final _organizationalformKey = GlobalKey<FormState>();
  final globalkey = GlobalKey<ScaffoldState>();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.green,
          key: globalkey,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person_outline), text: 'Personal'),
                Tab(icon: Icon(Icons.business), text: 'Organization'),
              ],
            ),
//            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _validate,
                  child: ListView(
                    children: <Widget>[
                      inputType(
                          label: 'Enter your name',
                          fieldIcon: Icon(
                            Icons.account_circle,
                            color: Colors.blueGrey,
                          ),
                          field: 'Name',
                          fieldName: name),

                      SizedBox(
                        height: 8.0,
                      ),

                      inputType(
                          label: 'Enter your email',
                          fieldIcon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
                          keyType: TextInputType.emailAddress,
                          field: 'Email',
                          fieldName: email),

                      SizedBox(
                        height: 8.0,
                      ),

                      inputType(
                          label: 'Enter location',
                          fieldIcon: Icon(
                            Icons.location_on,
                            color: Colors.blueGrey,
                          ),
                          field: 'Location',
                          fieldName: location),

                      SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.blueGrey,
                        ),
                        title: TextFormField(
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
                        title: TextFormField(
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
                        title: TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm your password',
                            ),
                            validator: (confirmPassword) {
                              if (confirmPassword.isEmpty) {
                                return 'Confirm Passowrd is required';
                              } else if (confirmPassword != password) {
                                return 'Password mismatch';
                              } else
                                return null;
                            }),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      RoundedButton(
                        buttonText: isLoading ? 'Registering...' : 'Register',
                        onPressed: isLoading ? null : _register,
                        buttonColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _organizationalformKey,
                  autovalidate: _validate,
                  child: ListView(
                    children: <Widget>[
                      inputType(
                          label: 'Enter organization name',
                          fieldIcon: Icon(
                            Icons.business,
                            color: Colors.blueGrey,
                          ),
                          field: 'Organization Name',
                          fieldName: organizationName),
                      SizedBox(
                        height: 8.0,
                      ),
                      inputType(
                          label: 'Enter oranization email',
                          fieldIcon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
                          keyType: TextInputType.emailAddress,
                          field: 'Organization Email',
                          fieldName: organizationEmail),
                      SizedBox(
                        height: 8.0,
                      ),
                      inputType(
                          label: 'Enter location',
                          fieldIcon: Icon(
                            Icons.location_on,
                            color: Colors.blueGrey,
                          ),
                          field: 'Location',
                          fieldName: location),
                      SizedBox(
                        height: 8.0,
                      ),
                      inputType(
                          label: 'Enter Phone',
                          fieldIcon: Icon(
                            Icons.phone,
                            color: Colors.blueGrey,
                          ),
                          keyType: TextInputType.phone,
                          field: 'Phone',
                          fieldName: phone),
                      SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.vpn_key,
                          color: Colors.blueGrey,
                        ),
                        title: TextFormField(
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
                        title: TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm your password',
                            ),
                            validator: (confirmPassword) {
                              if (confirmPassword.isEmpty) {
                                return 'Confirm Passowrd is required';
                              } else if (confirmPassword != password) {
                                return 'Password mismatch';
                              } else
                                return null;
                            }),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      RoundedButton(
                        buttonText: isLoading ? 'Registering...' : 'Register',
                        onPressed: isLoading ? null : _organizationRegister,
                        buttonColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //Scaffold(

  }

  Widget inputType(
      {String label,
      String field,
      String fieldName,
      Icon fieldIcon,
      TextInputType keyType = TextInputType.text}) {
    return ListTile(
      leading: fieldIcon,
      title: TextFormField(
        onChanged: (value) {
          fieldName = value;
        },
        keyboardType: keyType,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: Validator(field: field).makeValidator,
      ),
    );
  }
}
