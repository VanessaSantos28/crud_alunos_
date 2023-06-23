class Aluno {
  final int? id;
  final String nome;
  final String email;
  final String telefone;
  final String valorMensalidade;
  final String senha;
  final String situacao;
  final String? desc;
  final String? avatarURL;

  const Aluno(
      {this.id,
      required this.nome,
      required this.email,
      required this.telefone,
      required this.valorMensalidade,
      required this.senha,
      required this.situacao,
      this.desc,
      this.avatarURL});

  static Aluno fromMap(Map<String, dynamic> data) {
    return Aluno(
        id: data['id'],
        nome: data['nome'],
        email: data['email'],
        telefone: data['telefone'],
        valorMensalidade: data['valorMensalidade'],
        senha: data['senha'],
        desc: data['desc'],
        situacao: data['situacao']);
  }

  static List<Aluno> fromMapList(List list) {
    return list.map<Aluno>((aluno) => fromMap(aluno)).toList();
  }
}
