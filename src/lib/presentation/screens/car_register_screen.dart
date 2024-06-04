import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Veículo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarRegisterScreen(),
    );
  }
}

class CarRegisterScreen extends StatelessWidget {
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de veículo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Adicione a navegação para voltar aqui
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Cadastre seu veículo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF8DCBC8),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Veículos cadastrados',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: <String>['Veículo 1', 'Veículo 2', 'Veículo 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Adicione a lógica ao mudar a seleção aqui
                },
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF8DCBC8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildTextField(_placaController, 'Placa do veículo'),
                    SizedBox(height: 10),
                    _buildTextField(_modeloController, 'Modelo do veículo'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(_tipoController, 'Tipo do veículo'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(_anoController, 'Ano'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(_corController, 'Cor'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(_marcaController, 'Marca'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Adicione a lógica de cadastro aqui
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF8DCBC8),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Color(0xFF8DCBC8)),
                  ),
                ),
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8DCBC8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Adicione a lógica de atualização aqui
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF8DCBC8),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Color(0xFF8DCBC8)),
                  ),
                ),
                child: Text(
                  'Atualizar cadastro',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8DCBC8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
