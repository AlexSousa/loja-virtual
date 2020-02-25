import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Criar Conta"),
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome Completo"),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Nome Invalido";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@")) {
                      return "Email Invalido";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return "Senha Invalida";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "Endereço"),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Endereço Invalido";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    child: Text("Criar Conta", style: TextStyle(fontSize: 18)),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _addressController.text,
                        };
                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSucess,
                            onFail: _onFail);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSucess() {}
  void _onFail() {}
}
