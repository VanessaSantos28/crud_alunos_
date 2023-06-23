import 'package:crud_teste_pratico/models/aluno.dart';
import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../models/text_field_aluno.dart';

class AlunoForm extends StatefulWidget {
  final Aluno? aluno;

  const AlunoForm({super.key, this.aluno});

  @override
  State<AlunoForm> createState() => _AlunoFormState();
}

class _AlunoFormState extends State<AlunoForm> {
  late final aluno = widget.aluno;

  late final id = aluno?.id;

  final formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _descController = TextEditingController();
  final _senhaController = TextEditingController();
  final _emailController = TextEditingController();
  final _situacaoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _valorMensalidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    populateForm();
  }

  void populateForm() {
    final _aluno = aluno;
    if (_aluno != null) {
      _nomeController.text = _aluno.nome;
      _descController.text = _aluno.desc ?? "";
      _emailController.text = _aluno.email;
      _situacaoController.text = _aluno.situacao;
      _telefoneController.text = _aluno.telefone;
      _valorMensalidadeController.text = _aluno.valorMensalidade;
      _senhaController.text = _aluno.senha;
    }
  }

  Future<void> _addData() async {
    await SQLHelper.createData(
      _nomeController.text,
      _descController.text,
      _emailController.text,
      _situacaoController.text,
      _telefoneController.text,
      _valorMensalidadeController.text,
      _senhaController.text,
    );
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      _nomeController.text,
      _descController.text,
      _emailController.text,
      _situacaoController.text,
      _telefoneController.text,
      _valorMensalidadeController.text,
      _senhaController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 118, 6, 138),
        title: const Text(
          'Cadastro de Alunos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            TextFieldAluno(
              controllerAluo: _nomeController,
              hintTextAluno: 'Nome',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldAluno(
              controllerAluo: _valorMensalidadeController,
              hintTextAluno: 'Mensalidade:',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldAluno(
              controllerAluo: _emailController,
              hintTextAluno: 'E-mail:',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldAluno(
              controllerAluo: _senhaController,
              hintTextAluno: 'Senha:',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldAluno(
              controllerAluo: _telefoneController,
              hintTextAluno: 'Tel.:',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldAluno(
              controllerAluo: _descController,
              hintTextAluno: 'Observação',
              nLinhas: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() == true) {
                    final alunoID = aluno?.id;
                    if (alunoID == null) {
                      await _addData().then((value) => Navigator.pop(context));
                    } else {
                      await _updateData(alunoID)
                          .then((value) => Navigator.pop(context));
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    id == null ? "Adicionar" : "Atualizar",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
