import 'package:flutter/material.dart';

class CheckpointScreen extends StatelessWidget {
  const CheckpointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 50,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/CarbonSaverToken.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CarbonSaveToken',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '80',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Consulta de pontos por local',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  isDense: false,
                  items: [
                    DropdownMenuItem(
                      value: 'shopping_ciane',
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/home.png',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Shopping Ciane'),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/CarbonSaverToken.png',
                                    width: 12,
                                    height: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '40',
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'shopping_iguatemi',
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/home.png',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shopping Iguatemi'),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/CarbonSaverToken.png',
                                    width: 12,
                                    height: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '40',
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8DCBC8)),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  elevation: 3,
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Gaste seus CarbonSaver Token e resgate sua Recompensa',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Adicione a lógica do botão aqui
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF8DCBC8), backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF8DCBC8)),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text('Resgatar'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Consulte a sua pegada de carbono e descubra o quanto você está contribuindo para o meio ambiente',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Adicione a lógica do botão aqui
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF8DCBC8), backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF8DCBC8)),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text('Pegada de carbono'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
