import 'package:calcimcapp/model/imc.dart';
import 'package:calcimcapp/repository/imc_repository.dart';
import 'package:calcimcapp/service/gerar_custom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imcRepository = ImcRepository();
  var _imcs = const <Imc>[];
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

  @override
  void initState() {
    obterImcs();
    super.initState();
  }

  Future<void> obterImcs() async {
    _imcs = await imcRepository.listar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          pesoController.text = "";
          alturaController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar dados do IMC"),
                  content: Wrap(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 30,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: pesoController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 0),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              hintText: "Peso",
                              prefixIcon: Icon(
                                Icons.line_weight,
                                color: Colors.teal,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 30,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: alturaController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 0),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              hintText: "Altura",
                              prefixIcon: Icon(
                                Icons.height,
                                color: Colors.teal,
                              )),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          var peso = pesoController.text.replaceAll(',', '.');
                          var altura =
                              alturaController.text.replaceAll(',', '.');
                          await imcRepository.adicionat(
                              Imc(double.parse(peso), double.parse(altura)));
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Adicionar"))
                  ],
                );
              });
        },
      ),
      appBar: AppBar(title: const Text("Calcuradora IMC")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _imcs.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var imc = _imcs[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        await imcRepository.remove(imc.id);
                        obterImcs();
                      },
                      key: Key(imc.id),
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child:
                                GeradorCustonService.avatar(imc.calculaIMC()),
                          ),
                          title: Row(
                            children: [
                              Text(imc.calculaIMC().toStringAsFixed(0)),
                              const Text(" : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                              Text(GeradorCustonService.mensagem(
                                  imc.calculaIMC())),
                            ],
                          ),
                          subtitle: Text("${imc.peso} / ${imc.altura}"),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
