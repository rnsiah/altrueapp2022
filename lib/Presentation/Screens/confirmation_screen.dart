import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pplhelping.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
          ),
          body: _confirmationForm()
          ),
    );
  }

  Widget _confirmationForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _userNameField(),
          SizedBox(
            height: 12,
          ),
          _codeField(),
          SizedBox(height: 7,),
          _confirmationButton(),
        ],
      ),
    );
  }

  Widget _userNameField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: 'email',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
    );
  }

  Widget _codeField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: 'Confirmation Code',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
    );
  }

  Widget _confirmationButton() {
    return ElevatedButton(
      child: Text('Confirm Now',

      ),
      onPressed: () {},
    );
  }
}
