import 'package:crud_teste_pratico/constants/constantes.dart';
import 'package:crud_teste_pratico/models/aluno.dart';
import 'package:crud_teste_pratico/pages/form.dart';
import 'package:flutter/material.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent, content: Text("Data Deleted")));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 118, 6, 138),
        title: const Text(
          'Lista de Alunos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: _allData.length,
        itemBuilder: (context, index) => Card(
          elevation: 5,
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              ListTile(
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
                            "${_allData[index].valorMensalidade}",
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
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
                          "Senha: ",
                          style: kTextStyleSubtitle,
                        ),
                        Text(
                          _allData[index].senha,
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
                      children: [
                        const Text(
                          "Situação.: ",
                          style: kTextStyleSubtitle,
                        ),
                        Text(
                          _allData[index].situacao,
                          style: kSmallTextStyleSubtitle,
                        )
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
                          _allData[index].desc ?? "",
                          style: kSmallTextStyleSubtitle,
                        )
                      ],
                    ),
                  ],
                ),
                trailing: Row(
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
                      icon: const Icon(Icons.edit),
                      color: Colors.indigo,
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteData(_allData[index].id!);
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
