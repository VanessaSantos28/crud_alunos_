import 'package:crud_teste_pratico/constants/constantes.dart';
import 'package:crud_teste_pratico/models/aluno.dart';
import 'package:crud_teste_pratico/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../database/db_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Aluno> _allData = [];

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent, content: Text("Usuário apagado")));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 118, 6, 138),
        title: const Center(
          child: Text(
            'Lista de Alunos',
            style: kTitleStyle,
          ),
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: _allData.length,
        itemBuilder: (context, index) => ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: .5,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _allData[index].nome,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "Mensalidade: ",
                      style: kTextStyleSubtitle,
                    ),
                    Text(
                      _allData[index].valorMensalidade,
                      style: kSmallTextStyleMensalidade,
                    )
                  ],
                ),
              ],
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "E-mail: ",
                    style: kTextStyleSubtitle,
                  ),
                  Text(
                    _allData[index].email,
                    style: kSmallTextStyleSubtitle,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Tel.: ",
                    style: kTextStyleSubtitle,
                  ),
                  Text(
                    _allData[index].telefone,
                    style: kSmallTextStyleSubtitle,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "obs.: ",
                    style: kTextStyleSubtitle,
                  ),
                  Text(
                    _allData[index].desc,
                    style: kSmallTextStyleSubtitle,
                  )
                ],
              ),
            ],
          ),
          trailing: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: LiteRollingSwitch(
                      width: 125,
                      iconOn: Icons.check_circle_outline,
                      iconOff: Icons.cancel_outlined,
                      colorOn: Colors.green,
                      colorOff: Colors.red,
                      textOn: "Ativo",
                      textOff: "Inativo",
                      value: false,
                      textSize: 20,
                      textOnColor: Colors.white,
                      textOffColor: Colors.white,
                      onTap: () {},
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onChanged: (bool state) {
                        setState(() {
                          // ignore: avoid_print
                          return print(
                              "Aluno(a) ${(state) ? "ativa" : "inativa"}");
                        });
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    AlunoForm(aluno: _allData[index])))
                            .then((value) => _refreshData());
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 40,
                      ),
                      color: Colors.indigo,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Excluir usuário'),
                                  content: const Text('Tem certeza?'),
                                  actions: [
                                    TextButton(
                                      child: const Text("Não"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Sim"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _deleteData(_allData[index].id!);
                                      },
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 40,
                      ),
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AlunoForm()))
            .then((value) => _refreshData()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
