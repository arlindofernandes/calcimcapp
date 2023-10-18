// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:calcimcapp/model/usuario_model.dart';
import 'package:calcimcapp/pages/setting_page.dart';

class CustonDrawer extends StatelessWidget {
  final Usuario usuario;
  const CustonDrawer({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.album),
                        )
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.teal),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      backgroundColor: Colors.white, child: Icon(Icons.person)),
                ),
                accountName: Text("Nome: ${usuario.nome}"),
                accountEmail: Text("peso: ${usuario.peso}")),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: ((BuildContext bc) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: const Column(
                        children: [
                          Text(
                            "Termos de uso e privacidade",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "O uso deste serviço está sujeito à aceitação dos seguintes termos. Ao acessar ou utilizar este serviço, você concorda em cumprir e estar vinculado a estes termos. O serviço destina-se a fins legítimos e seu uso deve estar em conformidade com as leis e regulamentos aplicáveis. A propriedade intelectual do serviço e de seu conteúdo é exclusiva do titular do serviço e protegida por leis de direitos autorais. A privacidade dos usuários é respeitada, e as informações pessoais serão tratadas de acordo com a política de privacidade. O serviço é fornecido \"no estado em que se encontra\", sem garantias de qualquer tipo. O titular do serviço não assume responsabilidade por danos decorrentes do uso ou incapacidade de uso do serviço. Estes termos estão sujeitos a alterações, e é responsabilidade do usuário revisá-los periodicamente.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Termos de uso e privacidade"),
                  ],
                )),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (bc) => const SettingShPage()));
              Navigator.push(context,
                  MaterialPageRoute(builder: (bc) => const SettingPage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 5,
                    ),
                    Text("configuraçoes"),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
