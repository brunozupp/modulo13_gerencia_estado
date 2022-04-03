import 'dart:async';
import 'dart:math';

import 'package:modulo13_gerencia_estado/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {

  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcState(imc: 0));

  Stream<ImcState> get imcOut => _imcStreamController.stream;

  void calcularIMC({
    required double peso,
    required double altura,
  }) async {

    try {

      _imcStreamController.add(ImcStateLoading());

      await Future.delayed(const Duration(seconds: 1));

      //throw Exception();

      _imcStreamController.add(ImcState(imc: peso / pow(altura, 2)));
    } catch(e) {
      _imcStreamController.add(ImcStateError(message: "Erro ao calcular IMC"));
    }
  }

  void dispose() {
    _imcStreamController.close();
  }
}