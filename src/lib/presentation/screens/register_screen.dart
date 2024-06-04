import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/repositories/client_repository.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Uint8List? _image;
  final ClientRepository _clientRepository = ClientRepository();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState?.value;

      try {
        await _clientRepository.insertClient(
          data!['firstName'],
          data['lastName'],
          data['email'],
          data['password'],
          _image,
          'image/jpeg', // Ou o mimeType correto da imagem
          'profile.jpg', // Ou o nome correto da imagem
        );
        Fluttertoast.showToast(msg: 'Cadastro efetuado com sucesso');
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$').hasMatch(value)) {
      return 'A senha deve ter pelo menos 8 caracteres, incluindo letras maiúsculas, minúsculas, números e caracteres especiais';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'firstName',
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'lastName',
                  decoration: InputDecoration(labelText: 'Sobrenome'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                FormBuilderTextField(
                  name: 'confirmPassword',
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _formKey.currentState?.fields['password']?.value) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Escolher Imagem'),
                    ),
                    SizedBox(width: 16),
                    _image == null
                        ? Text('Nenhuma imagem selecionada')
                        : Image.memory(_image!, width: 100, height: 100),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Cadastre-se'),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já possui uma conta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Entre'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
