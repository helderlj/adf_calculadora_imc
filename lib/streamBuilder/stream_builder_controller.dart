import 'dart:async';
import 'dart:math';

import 'package:adf_calculadora_imc/streamBuilder/imc_state.dart';

class ImcStreamBuilderController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcStateLoading());

  Stream<ImcState> get imcOut => _imcStreamController.stream;

  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    _imcStreamController.add(ImcStateLoading());
    await Future.delayed(const Duration(seconds: 1));

    final imc = peso / pow(altura, 2);

    _imcStreamController.add(ImcState(imc: imc));
  }

  void dispose() {
    _imcStreamController.close();
  }
}
