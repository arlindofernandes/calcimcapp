import 'package:calcimcapp/model/imc.dart';
import 'package:calcimcapp/model/usuario_model.dart';
import 'package:calcimcapp/repository/imc_repository.dart';
import 'package:calcimcapp/repository/usuario_repository.dart';
import 'package:calcimcapp/service/gerar_custom.dart';
import 'package:calcimcapp/shared/widgets/custon_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imcRepository = ImcRepository();
  UsuarioRepository usuarioRepository = UsuarioRepository();
  Usuario usuario = Usuario.vazio();

  var _imcs = const <ImcModel>[];
  ImcModel imc = ImcModel.vazio();
  var pesoController = TextEditingController();

  @override
  void initState() {
    obterdados();
    super.initState();
  }

  Future<void> obterdados() async {
    usuario = await usuarioRepository.getUsuario();
    _imcs = await imcRepository.obterDados(usuario.id);
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
                          usuario.peso = double.parse(
                              pesoController.text.replaceAll(',', '.'));
                          var altura = usuario.altura;
                          var calc = usuario.peso! / (altura * altura);
                          await imcRepository.salvar(ImcModel(
                              id: 0,
                              usuarioId: usuario.id,
                              altura: usuario.altura,
                              peso: usuario.peso!,
                              imc: calc,
                              dataRegistro: DateTime.now()));
                          await usuarioRepository.updatePeso(usuario);
                          setState(() {
                            Navigator.pop(context);
                            obterdados();
                          });
                        },
                        child: const Text("Adicionar"))
                  ],
                );
              });
        },
      ),
      appBar: AppBar(
        title: const Text("Calcuradora de IMC"),
        centerTitle: true,
      ),
      drawer: CustonDrawer(usuario: usuario),
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
                          await imcRepository.remover(imc.id);
                          setState(() {
                            obterdados();
                          });
                        },
                        key: Key(imc.id.toString()),
                        child: Card(
                            color: GeradorCustonService.backColors(imc.imc),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    GeradorCustonService.mensagem(imc.imc),
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ],
                              ),

                              // Row(
                              //   children: [
                              //     Text(GeradorCustonService.mensagem(imc.imc)),
                              //   ],
                              // ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'IMC: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        imc.imc.toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Altura: ${imc.altura.toStringAsFixed(2)} m',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Peso: ${imc.peso.toStringAsFixed(2)} kg',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      // Text(
                                      //     'Data: ${imc.dataRegistro.toLocal()}'),
                                      // // Text("${imc.peso} / ${imc.altura} | "),
                                      Text(
                                        GeradorCustonService.formatarDataHora(
                                            imc.dataRegistro),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //Text(imc.imc.round().toString()),
                            )));

                    //
                    //       subtitle: Text("${imc.peso} / ${imc.altura}"),
                    //     ),
                    //   ),
                    // );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
