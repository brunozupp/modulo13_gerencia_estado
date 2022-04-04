import 'dart:async';
import 'dart:math';

import 'package:modulo13_gerencia_estado/bloc_pattern_mine/imc_state_mine.dart';

class ImcBlocPatternControllerMine {

  final _imcStreamController = StreamController<ImcStateMine>.broadcast()
    ..add(ImcStateModelMine(imc: 0));

  Stream<ImcStateMine> get imcOut => _imcStreamController.stream;

  void calcularIMC({
    required double peso,
    required double altura,
  }) async {

    try {

      _imcStreamController.add(ImcStateLoadingMine());

      await Future.delayed(const Duration(seconds: 1));

      throw Exception();

      _imcStreamController.add(ImcStateModelMine(imc: peso / pow(altura, 2)));
    } catch(e) {
      _imcStreamController.add(ImcStateErrorMine(message: "Erro ao calcular IMC"));
    }
  }

  void dispose() {
    _imcStreamController.close();
  }
}