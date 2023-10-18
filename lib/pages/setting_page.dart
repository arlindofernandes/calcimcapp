import 'package:calcimcapp/model/usuario_model.dart';
import 'package:calcimcapp/repository/usuario_repository.dart';
import 'package:calcimcapp/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UsuarioRepository usuarioRepository = UsuarioRepository();
  late Usuario usuario;

  TextEditingController nomeController = TextEditingController(text: "");

  TextEditingController alturaController = TextEditingController(text: "");

  bool salvando = false;
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  List<DropdownMenuItem> returnItens(int quant) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i <= quant; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  carregarDados() async {
    usuario = await usuarioRepository.getUsuario();
    nomeController.text = usuario.nome;
    alturaController.text = usuario.altura.toString();
    // dataController.text =
    //     dadosModel.dataNasc == null ? "" : dadosModel.dataNasc.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: [
                const TextLabel(
                  texto: "Nome",
                ),
                TextField(
                  controller: nomeController,
                ),
                const TextLabel(
                  texto: "Altura",
                ),
                TextField(
                  controller: alturaController,
                ),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        salvando = false;
                      });
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("o nome deve ser preenchido")));
                        return;
                      }

                      usuario.nome = nomeController.text;
                      usuario.altura = double.tryParse(alturaController.text)!;
                      usuarioRepository.updateUsuario(usuario);

                      setState(() {
                        salvando = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          salvando = false;
                        });

                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Salvar"))
              ]),
      ),
    );
  }
}
