const notaFrequenciaTabela = 'tbNotaFrequencia';
const notaFrequenciaRegistro = 'registro';
const notaFrequenciaTurma = 'turma';
const notaFrequenciaAluno = 'aluno';
const notaFrequenciaDisciplina = 'disciplina';
const notaFrequenciaNota = 'nota';
const notaFrequenciaFreq = 'frequencia';

class NotaFrequencia {
  int? registro;
  int registroTurma;
  int registroAluno;
  int registroDisciplina;
  double nota;
  double frequencia;

  NotaFrequencia(
      {this.registro,
        required this.registroTurma,
        required this.registroAluno,
        required this.registroDisciplina,
        required this.nota,
        required this.frequencia,
      });

  factory NotaFrequencia.fromMap(Map map) {
    return NotaFrequencia(
        registro: int.tryParse(map[notaFrequenciaRegistro].toString()),
        registroTurma: int.parse(map[notaFrequenciaTurma].toString()),
        registroAluno: int.parse(map[notaFrequenciaAluno].toString()),
        registroDisciplina: int.parse(map[notaFrequenciaDisciplina].toString()),
        nota: double.parse(map[notaFrequenciaNota].toString()),
        frequencia: double.parse(map[notaFrequenciaFreq].toString()));
  }

  Map<String, dynamic> toMap() {
    return {
      notaFrequenciaRegistro: registro,
      notaFrequenciaTurma: registroTurma,
      notaFrequenciaAluno: registroAluno,
      notaFrequenciaDisciplina: registroDisciplina,
      notaFrequenciaNota: nota,
      notaFrequenciaFreq: frequencia
    };
  }
}
